term.clear()
print("App Store")
button = gui.createButton(  "button", function() http.get("") end ) --#This creates a new button with a function that when triggered will print "Hello World!"

button:draw( 1,1 5, colors.green, colors.white ) -- #This draws the button at (1,1) with a width of 5. The first color is what the buttons color will be and the second color is the text color

button:toggle( colors.red,4) --#This toggles the buttons color to red for 4 seconds (If you leave the second argument as nil it will just toggle the button)

button:trigger() --#This triggers the buttons function

gui.detect( 1,3,true ) --#this checks an array of all the buttons you've defined and returns the name of the button. If you also set the third argument to true it will trigger that buttons action