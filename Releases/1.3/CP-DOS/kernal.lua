os.loadAPI('cp-dos/apis/gui')
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
 

local function Boot()
term.clear()
bar = gui.createBar( "bar" ) --#This creates a new bar with the name
bar:draw( 5,8,30,colors.white,colors.green,true,colors.black,colors.white ) --#This draws the bar at (5,8) with a length of 30. The first color is the bar color, the second color is the progress color, the next argument is whether or not to display the percent, the third color is the text background color (for displaying the percent) and the fifth is the percent text color.
bar:update( percent ) --#Re-draws the bar with the new percent
term.clear()
sleep(0.5)
print("CP-DOS 1.3")
sleep(0.5)
getFreeMem()
sleep(0.5)
update()
textutils.slowPrint("Terminal mode is active!")
sleep(0.5)
print("THIS OS IN ALPHA IT STILL USES CRAFTOS FOR IT'S BASE!")
sleep(0.5)
print("THIS WILL CHANGE!")
sleep(0.5)
print("Type advown for all the names of the creators from the apps")
sleep(0.5)
end

Boot()
