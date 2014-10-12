local JSON = dofile("lib/dkjson.lua")

local updater = {}

local function getLocal(v)
	if v then
		if fs.exists("lib/.version") then
			local file = fs.open("lib/.version", "r")
			local ver = file.readAll()
			file.close()
			return tonumber(ver)
		else
			return 0
		end
	else
		if fs.exists("lib/.dlversion") then
			local file = fs.open("lib/.dlversion", "r")
			local ver = file.readAll()
			file.close()
			return tonumber(ver)
		else
			return 0
		end	
	end
end

local function getOnline(user, repo)
	local size = 0
	local query = "https://api.github.com/repos/"..user.."/"..repo.."/commits"
	local request = http.get(query).readAll()
	local data = JSON.decode(request)
	size = size + #data
	local sha = data[#data].sha
	repeat
		local query = "https://api.github.com/repos/"..user.."/"..repo.."/commits?sha="..sha
		local request = http.get(query).readAll()
		local data = JSON.decode(request)
		if #data ~= 1 then
			size = size + #data
			size = size - 1
		end
		sha = data[#data].sha
	until #data == 1
	return size
end

local function setLocal(ver, v)
	if v then
		local file = fs.open("lib/.version", "w")
		file.write(ver)
		file.close()
	else
		local file = fs.open("lib/.dlversion", "w")
		file.write(ver)
		file.close()
	end
end

function updater.update(funcToRun, user, repo)
	local onl = getOnline(user, repo)
	local loc = getLocal(true)
	if onl > loc then
		setLocal(onl, true)
		funcToRun()
	end
end

function updater.new()
	local onl = getOnline("Kolpa", "cc-update-checker")
	local loc = getLocal(false)
	if onl > loc then
		print("a new version of the updater api is downloading now")
		local new = http.get("https://raw.github.com/Kolpa/cc-update-checker/master/lib/updater.lua").readAll()
		local file = fs.open("lib/updater.lua", "w")
		file.write(new)
		file.close()
		setLocal(onl, false)
		print("Restarting now")
		sleep(1)
		shell.run(shell.getRunningProgram())
	end
end

return updater
