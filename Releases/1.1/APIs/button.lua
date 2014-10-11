function advPrint( txt, y1, ort, x1, x2 )
    --[[
        An extended version of print with several features
        ul - unbuffered left; will print the text exactly at x1 or 1
        l - buffered left; will print the text 1 character off x1 or 2
        c - center; will center the text between x1 and x2 or on the whole screen
        r - buffered right; will print the text 1 character off x2 or the terminal size
        ur - unbuffered right; will print the text exactle at x2 or the terminal size
    ]]--
 
    y1 = y1 or 1
 
    if ort == "ul" or not ort then
        x1 = x1 or 1
        term.setCursorPos( x1, y1 )
        term.write( txt )
        return x1
    elseif ort == "l" then
        x1 = x1 or 1
        term.setCursorPos( x1+1, y1 )
        term.write( txt )
        return x1+1
    elseif ort == "c" then
        x1 = x1 or 1
        x2 = x2 or term.getSize()
        local x3 = math.ceil( ( ( x2-x1+1 )-#txt+1 )/2 )
        term.setCursorPos( x3, y1 )
        term.write( txt )
        return x3
    elseif ort == "r" then
        x2 = x2 and x2 or ( x1 and x1 or term.getSize() )
        local x3 = x2 - #txt
        term.setCursorPos( x3, y1 )
        term.write( txt )
        return x3
    elseif ort == "ur" then
        x2 = x2 and x2 or ( x1 and x1 or term.getSize() )
        local x3 = x2 - #txt + 1
        term.setCursorPos( x3, y1 )
        term.write( txt )
        return x3
    end
end
 
function rectangle( x1, y1, x2, y2, clr, char, charclr )
    --[[
        Will draw a colored rectangle between x1, y1 and x2, y2
        Optional: char, charclr - The character the rectangle will be filled with
    ]]--
 
    x1, x2 = math.min( x1, x2 ), math.max( x1, x2 )
    y1, y2 = math.min( y1, y2 ), math.max( y1, y2 )
 
    term.setBackgroundColor( clr )
 
    if charclr then
        term.setTextColor( charclr )
    end
 
    char = (char and #char == 1) and char or " "
 
    for y = y1, y2 do
        term.setCursorPos( x1, y )
        term.write(char:rep( x2-x1+1 ))
    end
end
 
function read( arg )
    --[[
        Will trigger a pullEvent when completed
        PRM1 : "advread_complete"
        PRM2 : the text that was typed in
    ]]--
 
    assert( arg.x1 and arg.x2 and arg.y1, "Too few arguments" )
 
    local new = {
        draw = function( self )
            self.obj.setBackgroundColor( self.bg )
            self.obj.setTextColor( self.fg )
            self.obj.setCursorPos( self.x1, self.y1 )
            self.obj.write( (" "):rep( self.x2-self.x1+1 ) )
            self.obj.setCursorPos( self.x1, self.y1 )
            self.obj.write( self.txt:sub( self.pos+1, self.pos+1+( self.x2-self.x1 ) ) )
            self.obj.setCursorPos( self.x1+self.cursor-1, self.y1 )
        end;
 
        setCursor = function( self, x1 )
            if x1 ~= self.pos+self.cursor then
                if x1 < self.pos+1 then
                    self.pos = math.max( x1-1, 0 )
                    self.cursor = 1
                elseif x1 > self.pos+( self.x2-self.x1 )+1 then
                    if x1 <= #self.txt+1 then
                        self.pos = x1-( self.x2-self.x1 )-1
                        self.cursor = self.x2-self.x1+1
                    else
                        self.pos = #self.txt-( self.x2-self.x1 )
                        self.cursor = self.x2-self.x1+1
                    end
                else
                    self.cursor = math.min( x1-self.pos, #self.txt+1 )
                end
                self:draw()
            end
        end;
 
        insert = function( self, txt )
            self.txt = self.txt:sub( 1, self.pos+self.cursor-1 ) .. txt .. self.txt:sub( self.pos+self.cursor )
        end;
 
        evhandle = function( self, ... )
            local e = { ... }
 
            if e[1] == "char" then
                if self.filter then
                    e[2] = self.filter( e[2] )
                end
 
                if e[2] then
                    self:insert( e[2] )
                    self:setCursor( self.pos+self.cursor+#tostring( e[2] ) )
                end
            elseif e[1] == "paste" then
                self:insert( e[2] )
                self:setCursor( self.pos+self.cursor+#e[2] )
            elseif e[1] == "key" then
                if e[2] == 14 and self.pos+self.cursor > 1 then
                    self.txt = self.txt:sub( 1, self.pos+self.cursor-2) .. self.txt:sub( self.pos+self.cursor )
                    self:setCursor( self.pos+self.cursor-1 )
                elseif e[2] == 28 then
                    os.queueEvent( "advread_complete", self.txt )
                elseif e[2] == 199 then
                    self:setCursor( 1 )
                elseif e[2] == 203 then
                    self:setCursor( self.pos+self.cursor-1 )
                elseif e[2] == 205 then
                    self:setCursor( self.pos+self.cursor+1 )
                elseif e[2] == 207 then
                    self:setCursor( #self.txt+1 )
                elseif e[2] == 211 then
                    self.txt = self.txt:sub( 1, self.pos+self.cursor-1 ) .. self.txt:sub( self.pos+self.cursor+1 )
                    self:draw()
                end
            elseif e[1] == "mouse_click" then
                if e[2] == 1 then
                    if e[3] >= self.x1 and e[3] <= self.x2 and e[4] == self.y1 then
                        self:setCursor( self.pos+e[3]-self.x1+1 )
                    end
                end
            end
 
            self.obj.setCursorPos( self.x1+self.cursor-1, self.y1 )
        end;
 
        x1 = arg.x1;
        x2 = arg.x2;
        y1 = arg.y1;
        pos = 0;
        cursor = 1;
        txt = arg.txt or "";
        bg = arg.bg or 128;
        fg = arg.fg or 1;
        obj = arg.obj or term;
        filter = arg.filter;
        isElement = true;
    }
 
    new:draw()
    return new
end
 
function button( arg )
    --[[
        Will create a new button object
        Every text line looks like this:
        { txt = "Your text" ; pos = "ul/l/c/r/ur" ; fg = text-color }
    ]]--
 
    assert( arg.x1 and arg.x2 and arg.y1 and arg.y2, "Too few arguments" )
 
    if type( arg.txt ) == "string" then
        arg.txt = {
            {
                txt = arg.txt;
                pos = "l";
                fg = 1;
            }
        }
    elseif type( arg.txt ) == "table" then
        for k, v in pairs( arg.txt ) do
            if type( v ) == "string" then
                arg.txt[k] = {
                    txt = v;
                    pos = "l";
                    fg = 1;
                }
            elseif type( v ) == "table" then
                arg.txt[k] = {
                    txt = type( v.txt ) == "string" and v.txt or "";
                    pos = type( v.pos ) == "string" and ( v.pos == "ul" or v.pos == "l" or v.pos == "c" or v.pos == "r" or v.pos == "ur" ) and v.pos or "l";
                    fg = type( v.fg ) == "number" and v.fg > 0 and v.fg < 32769 and v.fg or 8;
                }
            end
        end
    end
 
    local new = {
        draw = function( self )
            self.obj.setBackgroundColor( self.bg )
 
            for y = self.y1, self.y2 do
                self.obj.setCursorPos( self.x1, y )
                self.obj.write( (" "):rep( self.x2-self.x1+1 ) )
            end
 
            local ys = math.floor( ( ( self.y2-self.y1+1 )-#self.txt+1 )/2 )+self.y1
 
            for k, v in pairs( self.txt ) do
                self.obj.setTextColor( v.fg )
                self.advPrint( v.txt, ys+k-1, v.pos, self.x1, self.x2 )
            end
 
        end;
 
        addLine = function( self, arg )
            self.txt[#self.txt+1] = {
                txt = arg.txt;
                pos = arg.pos and ( arg.pos == "ul" or arg.pos == "l" or arg.pos == "c" or arg.pos == "r" or arg.pos == "ur" ) and arg.pos or "l";
                fg = arg.fg and ( arg.fg > 0 and arg.fg < 32769 ) and arg.fg or 1;
            }
        end;
 
        setLine = function( self, arg )
            assert( arg.index and tonumber( arg.index ) and arg.index <= #self.txt, "No such line" )
            self.txt[arg.index] = {
                txt = arg.txt or self.txt[arg.index].txt;
                pos = arg.pos and ( arg.pos == "ul" or arg.pos == "l" or arg.pos == "c" or arg.pos == "r" or arg.pos == "ur" ) and arg.pos or self.txt[arg.index].pos;
                fg = arg.fg and ( arg.fg > 0 and arg.fg < 32769 ) and arg.fg or self.txt[arg.index].fg;
            }
        end;
 
        x1 = arg.x1;
        x2 = arg.x2;
        y1 = arg.y1;
        y2 = arg.y2;
        txt = arg.txt or {};
        bg = arg.bg or 8;
        obj = arg.obj or term;
        advPrint = advPrint;
        isElement = true;
    }
 
    new:draw()
    return new
end
 
function checkHitmap( arg )
    --[[
        Checks a table of GUI elements for a possible hit
        Returns a table with all matching elements
        e.g.
        {
            eg1 = {
                button1 = yourbuttonpointer;
            };
 
            button2 = yourbuttonpointer;
        }
    ]]--
 
    assert( type(arg) == "table" and arg.x1 and arg.y1 and type( arg.hitmap ) == "table", "Too few or invalid arguments" )
 
    arg.hits = arg.hits or {}
 
    for k, v in pairs( arg.hitmap ) do
        if type ( v ) == "table" and not v.isElement then
            arg.hits[k] = checkHitmap( { x1 = arg.x1; y1 = arg.y1; hitmap = v } )
        else
            arg.hits[k] = v
        end
    end
 
    return arg.hits
end