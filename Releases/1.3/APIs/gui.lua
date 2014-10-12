-- GUI API
 
black = colors.black
white = colors.white
lightBlue = colors.lightBlue
green = colors.green
yellow = colors.yellow
blue = colors.blue
purple = colors.purple
magenta = colors.magenta
lime = colors.lime
orange = colors.orange
red = colors.red
brown = colors.brown
cyan = colors.cyan
pink = colors.pink
grey = colors.gray
gray = colors.gray
lightGray = colors.lightGray
lightGrey = colors.lightGray
 
-- Buttons
 
buttonList = {}
Buttons = {}
Buttons.__index = Buttons
 
function createButton( name, func )
        button = {}
        setmetatable(button,Buttons)
        button.name = name
        button.action = func
        return button
end
 
function Buttons:toggle( newColor,sec )
 
        self:draw( self.x,self.y,self.width,newColor,self.tcolor)
 
        if sec ~= nil then
                sleep(sec)
                self:draw( self.x,self.y,self.width,self.color,self.tcolor )
        end
end
 
 
function Buttons:draw( x,y,width,color,tcolor )
 
        table.insert(buttonList,{self.name,x,y,width,self.action})
       
        self.x = x
        self.y = y
        self.width = width
        if self.tcolor == nil then
                self.color = color
        end
        self.tcolor = tcolor
 
        for i = 1,width do
                paintutils.drawLine(x, y + i, x + #self.name + 1, y + i, color)
        end
 
        term.setCursorPos(x,y + math.ceil(width/2))
        term.setTextColor(tcolor)
        term.setBackgroundColor(color)
        term.write(" "..self.name.." ")
end
 
function Buttons:trigger()
        buttonList[i][5]()
end
 
function Buttons:remove()
        for i = 1,#buttonList do
                if self.name == buttonList[i][1] then
                        table.remove(buttonList,i)
                end
        end
        self = nil
end
 
function detect( x,y,trigger )
        for i = 1,#buttonList do
                if x >= buttonList[i][2] and x <= buttonList[i][2] + #buttonList[i][1] and y >= buttonList[i][3] and y <= buttonList[i][3] + buttonList[i][4] then
                        if trigger == true then
                                buttonList[i][5]()
                        end
                        return buttonList[i][1]
                end
        end
end
 
-- Progress Bars
 
barList = {}
Bars = {}
Bars.__index = Bars
 
function createBar( name )
        bar = {}
        setmetatable(bar,Bars)
        bar.name = name
        return bar
end
 
function Bars:setup( x,y,length,color,pcolor,disp,dispbcolor,tcolor )
        self.x,self.y,self.length,self.color,self.pcolor,self.disp,self.dispbcolor,self.tcolor = x,y,length,color,pcolor,disp,dispbcolor,tcolor
end
 
function Bars:draw( x,y,length,color,pcolor,disp,dispbcolor,tcolor )
       
        if self.x == nil and x ~= nil then
                self.x,self.y,self.length,self.color,self.pcolor,self.disp,self.dispbcolor,self.tcolor = x,y,length,color,pcolor,disp,dispbcolor,tcolor
        end
 
        self.percent = 0
        term.setCursorPos(x,y)
        paintutils.drawLine(x,y,x+ length,y,color)
        term.setCursorPos(x,y)
        if self.percent > 0 then
                paintutils.drawLine(x,y,x + length*(self.percent/100),y,pcolor)
        end
 
       
        percentString = tostring(self.percent).."%"
        if disp == true then
                term.setCursorPos(math.max(x + math.ceil(length/2) - math.ceil(#percentString/2),0) + 1,y-1)
                term.setBackgroundColor(dispbcolor)
                term.setTextColor(tcolor)
                write(percentString)
        end
end
 
function Bars:update( percent )
        self.percent = percent
        term.setCursorPos(self.x,self.y)
        paintutils.drawLine(self.x,self.y,self.x + self.length,self.y,self.color)
        term.setCursorPos(self.x,self.y)
        if self.percent > 0 then
                paintutils.drawLine(self.x,self.y,self.x + self.length*(self.percent/100),self.y,self.pcolor)  
        end
 
       
        percentString = tostring(self.percent).."%"
        if self.disp == true then
                term.setCursorPos(math.max(self.x + math.ceil(self.length/2) - math.ceil(#percentString/2),0) + 1,self.y-1)
                term.setBackgroundColor(self.dispbcolor)
                term.setTextColor(self.tcolor)
                write(percentString)
        end
end
 
-- Textboxs
 
function newTextBox(x,y,length,bcolor,tcolor)
        typed = {}
        alphabet = "abcdefghijklmnopqrstuvwxyz"
 
        term.setBackgroundColor(bcolor)
        paintutils.drawLine(x, y, x + length - 1, y, bcolor)
        term.setCursorPos(x, y)
        term.setTextColor(tcolor)
        term.write("_")
 
        typing = true
        term.setCursorPos(x,y)
        while typing do
                event,key = os.pullEvent()
                if event == "key" then
                        if key >= 0 and key <= 11 then
                                table.insert(typed,key)
                        elseif keys.getName(key) == "enter" then
                                typing = false
                                return string.gsub(table.concat(typed,""),"space"," ")
                        elseif keys.getName(key) == "space" then
                                table.insert(typed,keys.getName(key))
                        elseif keys.getName(key) == "period" then
                                table.insert(typed,".")
                        elseif keys.getName(key) == "comma" then
                                table.insert(typed,",")
                        elseif keys.getName(key) == "backspace" then
                                table.remove(typed,#typed)
                        else
                                key = keys.getName(key)
                                if string.find(alphabet,key) ~= nil then
                                        table.insert(typed,key)
                                end    
                        end
                        if #typed > length then
                                table.remove(typed,#typed)
                        else
                                cx,cy = term.getCursorPos()
                                term.setBackgroundColor(bcolor)
                                paintutils.drawLine(x, y, x + length - 1, y, bcolor)
                                term.setCursorPos(x,y)
                                term.write(string.gsub(table.concat(typed,""),"space"," "))
                                if cx < x + length then
                                        term.write("_")
                                end
                        end
                end
        end
end
 
-- Boxes
 
Boxs = {}
Boxs.__index = Boxs
 
function createDialogueBox( title,body,boxType )
        boxes = {}
        setmetatable(boxes,Boxs)
        boxes.title = title
        boxes.body = body
        boxes.boxType = boxType
        return boxes
end
 
function Boxs:draw( x,y,width,color,bcolor,tcolor )
        ret = nil
        self.width = width
        self.x = x
        self.y = y
 
        if self.boxType == "yn" then                                                                      -- YN Box
 
                if type(self.body) ~= "table" then
                        paintutils.drawLine(x, y, x + #self.body + 1, y, bcolor)
                        term.setCursorPos(x,y)
                        term.setTextColor(tcolor)
                        write(self.title)
 
                        self.len = #self.body
 
                        for i = 1,width do
                                paintutils.drawLine(x, y + i, x + #self.body, y + i, color)
                        end
 
                        term.setCursorPos(x + 1, y + 2)
                        term.write(self.body)
 
 
                        term.setCursorPos(x + 1,y + width)
                        term.setTextColor(tcolor)
                        term.setBackgroundColor(green)
                        write(" Yes ")
 
                        term.setCursorPos(x + len - 4,y + width)
                        term.setBackgroundColor(red)
                        write(" No ")
 
                        repeat
                                event,click,cx,cy = os.pullEvent("mouse_click")
 
                                if cx >= x + 1 and cx <= x + 5 and cy == y + width then
                                        ret = true
                                elseif cx >= x + len - 5 and cx <= x + len - 1  and cy == y + width then
                                        ret = false
                                end
                        until ret ~= nil
 
                else
 
                        len = 0
                        for i = 1,#self.body do
                                if #self.body[i] > len then
                                        len = #self.body[i]
                                end
                        end
 
                        paintutils.drawLine(x, y, x + len + 1, y, bcolor)
                        term.setCursorPos(x,y)
                        term.setTextColor(tcolor)
                        write(self.title)
 
                        for i = 1,width do
                                paintutils.drawLine(x, y + i, x + len + 1, y + i, color)
                        end
 
                        for i = 1,#self.body do
                                term.setCursorPos(x + (len/2 - #self.body[i]/2) + 1, y + i + 1)
                                term.write(self.body[i])
                        end
 
                        term.setCursorPos(x + 1,y + width)
                        term.setTextColor(tcolor)
                        term.setBackgroundColor(green)
                        write(" Yes ")
 
                        term.setCursorPos(x + len - 4,y + width)
                        term.setBackgroundColor(red)
                        write(" No ")
 
                        repeat
                                event,click,cx,cy = os.pullEvent("mouse_click")
 
                                if cx >= x + 1 and cx <= x + 5 and cy == y + width then
                                        ret = true
                                elseif cx >= x + len - 5 and cx <= x + len - 1  and cy == y + width then
                                        ret = false
                                end
                        until ret ~= nil
 
 
                        self.len = len
                end
 
        elseif self.boxType == "ok" then                                                                  -- Ok Box
                if type(self.body) ~= "table" then
 
                        paintutils.drawLine(x, y, x + #self.body + 1, y, bcolor)
                        term.setCursorPos(x,y)
                        term.setTextColor(tcolor)
                        write(self.title)
                        self.len = #self.body
 
                        for i = 1,width do
                                paintutils.drawLine(x, y + i, x + #self.body, y + i, color)
                        end
 
                        term.setCursorPos(x + 1, y + 2)
                        term.write(self.body)
 
                        term.setCursorPos(x + (self.len/2) - 1,y + width)
                        term.setTextColor(tcolor)
                        term.setBackgroundColor(green)
                        write(" Ok ")
 
                       
                        repeat
                                event,click,cx,cy = os.pullEvent("mouse_click")
 
                                if cx > x + (self.len/2 - 4) and cx < x + (self.len/2) and cy == y + width then
                                        ret = true
                                end
                        until ret == true
 
                else
                       
                        len = 0
                        for i = 1,#self.body do
                                if #self.body[i] > len then
                                        len = #self.body[i]
                                end
                        end
                        self.len = len
 
                        paintutils.drawLine(x, y, x + len + 1, y, bcolor)
                        term.setCursorPos(x,y)
                        term.setTextColor(tcolor)
                        write(self.title)
 
                        for i = 1,width do
                                paintutils.drawLine(x, y + i, x + len + 1, y + i, color)
                        end
 
                        for i = 1,#self.body do
                                term.setCursorPos(x + (len/2 - #self.body[i]/2) + 1, y + i + 1)
                                term.write(self.body[i])
                        end
 
                        term.setCursorPos(x + (self.len/2) - 1,y + width)
                        term.setTextColor(tcolor)
                        term.setBackgroundColor(green)
                        write(" Ok ")
                       
                        repeat
                                event,click,cx,cy = os.pullEvent("mouse_click")
 
                                if cx > x + (len/2 - 4) and cx < x + (len/2) and cy == y + width then
                                        ret = true
                                end
                        until ret == true
                end
        end
        return ret
end
 
function Boxs:clear( color )
        paintutils.drawLine(self.x, self.y, self.x + self.len + 1, self.y, color)
        for i = 1,self.width do
                paintutils.drawLine(self.x, self.y + i, self.x + self.len + 1, self.y + i, color)
        end
end