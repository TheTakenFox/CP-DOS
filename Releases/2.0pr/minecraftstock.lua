local investorTable = {"GoldProgramming", "DeathProgramming", "NASDAW", "QBC", "SNL"}
--local investors = {"Agoldfish"} Commented out until I get profile support.
local function displayWelcome()
  print("Welcome to CcStocks!\n")
  print("What would you like to do?\n")
  print("View current stocks? (V)\n")
  print("Invest into a market? (I)\n")
  print("Exit? (E)")
end
local function displayInvest()
  
end
local function displayCurrentStocks()
  
end

while true do
  displayWelcome()
  local event, param1 = os.pullEvent("char")
  if string.lower(param1) == "v" then
    displayCurrentStocks()
  elseif string.lower(param1) == "i" then
    displayInvest()
  elseif string.lower(param1) == "e" then
    return
end