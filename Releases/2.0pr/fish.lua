--Config
local FishSimulatorVersion = "1.5.4"
local fishX = 10
local fishY = 10
local fishHealth = 40
local fishLt = "(O<"
local fishRt = ">O)"
local fishX2 = 12
local fishY2 = 12
--Extra Variables
local feed = 33 -- the key id for the F key
local h = colors.green -- h is the variable for the color of the health number
local fishLook = true -- true means left false means right
local fishLook2 = false
FishScreen = {
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  },
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  },
  {},
  {},
  {},
  {},
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    32,
    0,
    0,
    0,
    32,
    0,
    0,
    0,
    0,
    0,
    32,
    0,
    0,
    0,
    32,
  },
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    8192,
    0,
    32,
    0,
    0,
    0,
    0,
    0,
    0,
    32,
    0,
    0,
    0,
    0,
    32,
  },
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    8192,
    0,
    8192,
    0,
    0,
    0,
    0,
    0,
    0,
    8192,
    0,
    0,
    0,
    0,
    8192,
  },
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    8192,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    8192,
    0,
    0,
    8192,
  },
  {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    8192,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    8192,
    0,
    0,
    8192,
  },
  {
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
    16,
  },
}
--Functions
function fishFeed()
    term.setCursorPos(5,5)
    term.setBackgroundColor(colors.lightBlue)
    print("Feeding Your Fish!")
    fishHealth = fishHealth+1.5
    fishMove()
        if fishHealth < 10 then
h = colors.red
elseif fishHealth < 20 then
h = colors.orange
    elseif fishHealth > 30 then
h = colors.green
elseif fishHealth > 20 then
h = 1
elseif fishHealth < 10 then
h = colors.red
end
if fishHealth > 40 then
term.setCursorPos(5,5)
term.setBackgroundColor(colors.lightBlue)
    print("Your Fish Was Overfed!")
    sleep(1)
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
    end
    if fishHealth < .5 then
    term.setCursorPos(5,5)
    term.setBackgroundColor(colors.lightBlue)
    print("Your Fish Starved To Death!")
    sleep(1)
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
    end
   end
function fishMove()
  term.setBackgroundColor(colors.lightBlue)
  term.clear()
 
  term.setCursorPos(1,1)
  term.setTextColor(1)
  term.write("Fish's Life: ")
  term.setTextColor(h)
  term.write(fishHealth)
  term.setCursorPos(fishX,fishY)
  term.setTextColor(colors.black)
  term.setBackgroundColor(colors.orange)
  if fishLook then
    print(fishLt)
    else if fishLook == false then
          print(fishRt)
    end
  end
move2 = math.random(4)
    fishHealth = fishHealth - .5
    if move2 == 1 then
          fishX2 = fishX2-1
          fishLook2 = true
          elseif move2 == 2 then
          fishX2 = fishX2+1
          fishLook2 = false
          elseif move2 == 3 then
          fishY2 = fishY2-1
          elseif move2 == 4 then
          fishY2 = fishY2+1
end
term.setCursorPos(fishX2,fishY2)
  term.setTextColor(colors.black)
  term.setBackgroundColor(colors.blue)
  if fishLook2 then
    print(fishLt)
    else if fishLook == false then
          print(fishRt)
    end
  end
    move = math.random(4)
    fishHealth = fishHealth - .5
    if move == 1 then
          fishX = fishX-1
          fishLook = true
          elseif move == 2 then
          fishX = fishX+1
          fishLook = false
          elseif move == 3 then
          fishY = fishY-1
          elseif move == 4 then
          fishY = fishY+1
  --Health ColorChangers
if fishHealth < 5 then
h = colors.red
elseif fishHealth < 10 then
h = colors.orange
    elseif fishHealth > 15 then
h = colors.green
elseif fishHealth > 9 then
h = 1
elseif fishHealth < 5 then
h = colors.red
end
if fishHealth > 40 then
term.setCursorPos(5,5)
term.setBackgroundColor(colors.lightBlue)
    term.clear()
        print("Your Fish Was Overfed!")
    sleep(1)
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
    end
    if fishHealth < .5 then
    term.setCursorPos(5,5)
    term.setBackgroundColor(colors.lightBlue)
        term.clear()
    print("Your Fish Starved To Death!")
    sleep(1)
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
    end
   end
  paintutils.drawImage(FishScreen,1,1)
  term.setBackgroundColor(colors.lightBlue)
  end
--Startup Screen
term.setBackgroundColor(colors.lightBlue)
term.setTextColor(colors.black)
term.clear()
paintutils.drawImage(FishScreen,1,1)
paintutils.drawImage(FishScreen,1,1)
term.setCursorPos(1,1)
term.setBackgroundColor(colors.lightBlue)
print("FishSimulator v. "..FishSimulatorVersion)
term.setCursorPos(fishX,fishY)
term.setBackgroundColor(colors.orange)
print(fishLt)
term.setBackgroundColor(colors.blue)
term.setCursorPos(fishX2,fishY2)
print(fishRt)
term.setBackgroundColor(colors.lightBlue)
sleep(.50)
term.setCursorPos(1,2)
print("Press any key to begin.")
os.pullEvent()
fishMove()
--Run Code
local id = os.startTimer(1)
while true do
  local event = {os.pullEvent()}
  if event[ 1 ] == "timer" and event[ 2 ] == id then
    fishMove()
    id = os.startTimer(1)
  elseif event[ 1 ] == "key" and event[ 2 ] == feed then
    fishFeed()
  elseif event[ 1 ] == "monitor_touch" then
    fishFeed()
  end
end