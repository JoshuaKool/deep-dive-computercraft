local mouseWidth = 0
local mouseHeight = 0
local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
else
    local monitorWidth, monitorHeight = monitor.getSize()
    monitor.clear()
    monitor.setBackgroundColor(colors.lime)
    monitor.setTextScale(2)
    monitor.setTextColor(colors.white)

    local startText = "Start"
    local startTextWidth = #startText
    local startX = math.floor((monitorWidth - startTextWidth * 2) / 2) + 1
    local startY = math.floor(monitorHeight / 2)

    monitor.setCursorPos(startX, startY)
    monitor.write(startText)

    local function drawButton()
        if mouseWidth >= startX and mouseWidth <= startX + startTextWidth - 1
            and mouseHeight == startY then
            monitor.setBackgroundColor(colors.lime)
        end
        monitor.setCursorPos(startX, startY)
        monitor.write(startText)
    end

    local function checkClickPosition()
        if mouseWidth >= startX and mouseWidth <= startX + startTextWidth - 1
            and mouseHeight == startY then
            os.run({}, "loading.lua")
        end
    end

    while true do
        local event, side, x, y = os.pullEvent()
        if event == "monitor_touch" then
            mouseWidth = x
            mouseHeight = y
            monitor.setBackgroundColor(colors.black)
            drawButton()
            checkClickPosition()
        end
    end
end