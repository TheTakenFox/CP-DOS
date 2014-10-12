
local function dofile (filename) -- we need this later.
          local f = assert(loadfile(filename))
          return f()
        end
local function get(paste) -- This function is from pastebin program.
        local response = http.get(
                "http://pastebin.com/raw.php?i=0UnwMYY4"..textutils.urlEncode( paste )
        )
          
        if response then
                --print( "Success." )
          
                local sResponse = response.readAll()
                response.close()
                return sResponse
        else
                print( "Update failed." )
        end
end
local version = "1.1" -- Put the version in here.
local pastetoget = "0UnwMYY4" -- Enter your paste
local dataweneed = get(pastetoget)
if string.find( dataweneed, 'local version = "'..version..'"' ) then -- This if part can be commented out if you want to disable UPDATES on your own computer.
-- if you are coding it in-game etc.




-- If this happens, our program found a different version on pastebin
local handsofthedead = fs.open(".updatedprog","w")
handsofthedead.write(dataweneed)
handsofthedead.close()
fs.move(shell.getRunningProgram(),"noneedanymore")
fs.move(".updatedprog",shell.getRunningProgram() )
fs.delete("noneedanymore")
-- Process ends after here. Update done. TADAA.
-- We should add some kind of thing so user knows wtf happened
print("The program updated.")
dofile(shell.getRunningProgram())
return
end

local function getFreeMem()
  local bytesFree = fs.getFreeSpace("/")
  local kbFree = math.ceil(bytesFree / 1024)
  local mbFree = math.ceil(kbFree / 1024)
 
  if fs.exists("/disk") then
        diskFree = fs.getFreeSpace("/disk")
        diskKB = math.ceil(diskFree / 1024)
        diskMB = math.ceil(diskKB / 1024)
        diskPresent = true
  end
 
sleep(0.5)
  print("Approx. Bytes free: "..bytesFree)
sleep(0.5)
  print("Approx. KB free: "..kbFree)
sleep(0.5)
  print("Approx. MB free: "..mbFree)
sleep(0.5)
 if diskPresent then
        print("|DISK|")
sleep(0.5)
        print("Approx. Bytes free: "..diskFree)
sleep(0.5)
        print("Approx. KB free: "..diskKB)
sleep(0.5)
        print("Approx. MB free: "..diskMB)
  end
end
 
 
 
 
local function Boot()
term.clear()
textutils.slowPrint("Booting CP-DOS")
sleep(2)
print("Booted!")
sleep(0.3)
term.clear()
sleep(0.5)
print("CP-DOS 1.1")
sleep(0.5)
getFreeMem()
sleep(0.5)
textutils.slowPrint("Terminal mode is active!")
sleep(0.5)
print("THIS OS IN ALPHA IT STILL USES CRAFTOS FOR IT'S BASE!")
sleep(0.5)
print("THIS WILL CHANGE!")
sleep(0.5)
print("More programs will be inclued soon!")
sleep(0.5)
print("Type advow for all the names of the creators from the apps")
sleep(0.5)
print("Type in advpro for an Advanced Program List")
sleep(0.5)
end
Boot()
