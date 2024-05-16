local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
else

    local function drawButton()
        local monitorWidth, monitorHeight = monitor.getSize()
        monitor.clear()
        monitor.setTextScale(1)
        monitor.setTextColor(colors.white)

        local startText = "Start"
        local startTextWidth = #startText
        local startX = math.floor((monitorWidth - startTextWidth) / 2)
        local startY = math.floor((monitorHeight - 1) / 2)
        monitor.clear()
        monitor.setBackgroundColor(colors.black)
        monitor.setTextColor(colors.white)

        monitor.setBackgroundColor(colors.lime)
        monitor.setCursorPos(startX, startY)
        monitor.write(startText)
        monitor.setBackgroundColor(colors.black)
    end

    local function checkClickPosition(mouseWidth, mouseHeight)
        local monitorWidth, monitorHeight = monitor.getSize()
        local startText = "Start"
        local startTextWidth = #startText
        local startX = math.floor((monitorWidth - startTextWidth) / 2)
        local startY = math.floor((monitorHeight - 1) / 2)

        if mouseWidth >= startX and mouseWidth <= startX + startTextWidth - 1
            and mouseHeight == startY then
            os.run({}, "loading.lua")
        end
    end

    drawButton()

    while true do
        local event, side, x, y = os.pullEvent()
        if event == "monitor_touch" then
            checkClickPosition(x, y)
        end
    end
end