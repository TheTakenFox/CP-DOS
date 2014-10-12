os.loadAPI('/gui')
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
end
 
 local updater = dofile("lib/updater.lua")
         local function update()
print("Update Found!")
end
updater.new() -- this will check for any updates for the updater
updater.update(update, "Cloudpaw", "CP-DOS") -- first argument is the function to be executed in case of an update second is the username and last is the repostery where the program is located

 
local function Boot()
term.clear()
bar = gui.createBar( "bar" ) --#This creates a new bar with the name
bar:draw( 5,8,30,colors.white,colors.green,true,colors.black,colors.white ) --#This draws the bar at (5,8) with a length of 30. The first color is the bar color, the second color is the progress color, the next argument is whether or not to display the percent, the third color is the text background color (for displaying the percent) and the fifth is the percent text color.
bar:update( percent ) --#Re-draws the bar with the new percent
term.clear()
sleep(0.5)
print("CP-DOS 1.2")
sleep(0.5)
getFreeMem()
sleep(0.5)
button = gui.createButton(  "Start", function() secboot() end ) --#This creates a new button with a function that when triggered will print "Hello World!"

button:draw(1,1 5, colors.green, colors.white) -- #This draws the button at (1,1) with a width of 5. The first color is what the buttons color will be and the second color is the text color

button:toggle(colors.red,4) --#This toggles the buttons color to red for 4 seconds (If you leave the second argument as nil it will just toggle the button)

button:trigger() --#This triggers the buttons function

gui.detect( 1,3,true ) --#this checks an array of all the buttons you've defined and returns the name of the button. If you also set the third argument to true it will trigger that buttons action
end
local function secboot()
FileDialogueBox = gui.createDialogueBox("OS", {"Do you want to", "check for an update?"}, "y/n")

function skipFileCheck()
  FileDialogueBox:draw( 20,5,7,colors.gray,colors.lightBlue,colors.black)
  if FileDialogueBox == true then
   update()
  elseif FileDialogueBox == false then
textutils.slowPrint("Terminal mode is active!")
sleep(0.5)
print("THIS OS IN ALPHA IT STILL USES CRAFTOS FOR IT'S BASE!")
sleep(0.5)
print("THIS WILL CHANGE!")
sleep(0.5)
print("Type advown for all the names of the creators from the apps")
sleep(0.5)
end
end
end
end

Boot()
