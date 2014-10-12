pver = "1.0"
while true do
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
print("PicView Menu")
print("1. Select a Picture to view")
print("2. Credits                 ")
print("3. Exit                    ")
write("> ")
local slc = read()
if slc == "1" then
shell.run("ls")
print("")
write("Picture: ")
local pct = read()
term.clear()
pic = paintutils.loadImage(pct)
paintutils.drawImage(pic, 1,1)
print("")
sleep(13)
elseif slc == "2" then
print("PicView"..pver)
print("by StarStruck Studios")
print("Dan200 - Paintutils")
sleep(5)
elseif slc == "3" then
term.clear()
term.setCursorPos(1,1)
print("Thank you for using PicView!")
break
end
end