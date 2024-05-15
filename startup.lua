local mouseWidth = 0
local mouseHeight = 0
local monitor = peripheral.find("monitor")


if monitor == nil then
    print("No monitor found")
    return
else
    local x, y = monitor.getSize()
    monitor.clear()
    monitor.SetBackgroundColour(colors.lime)
    monitor.setTextColour(colors.white)
    monitor.setCursorPos(1, 1)
    monitor.write("Start")

    local function checkClickPosition()
        if mouseWidth > 1 and mouseWidth < 6 and mouseHeight > 1 and mouseHeight < 3 then
            shell.run("button.lua")
        end
    end

    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        mouseWidth = x
        mouseHeight = y
        checkClickPosition()
    end
end