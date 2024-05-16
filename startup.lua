local mouseWidth = 0
local mouseHeight = 0
local monitor = peripheral.find("monitor")


if monitor == nil then
    print("No monitor found")
    return
else
    local x, y = monitor.getSize()
    monitor.clear()
    monitor.setBackgroundColor(colors.green)
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(1, 2)
    monitor.write("Start")

    local function checkClickPosition()
        if mouseWidth >= 0 and mouseWidth <= 6 and mouseHeight > 1 and mouseHeight < 3 then
            monitor.clear()
            shell.run("loading.lua")
        end
    end
    local touch = true
    while touch == true do
        local event, side, x, y = os.pullEvent()
        if event == "monitor_touch" then
            mouseWidth = x
            mouseHeight = y
            if checkClickPosition() then
                touch = false
            end
        end
    end
end