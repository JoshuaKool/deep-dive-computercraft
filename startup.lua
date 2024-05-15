local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
else
    local main = basalt.createFrame()
    local aButton = main:addButton():setText("Click")

    aButton:onClick(function(self,event,button,x,y)
    if(event=="mouse_click")and(button==1)then
        basalt.debug("Left mousebutton got clicked!")
    end
    end)
end