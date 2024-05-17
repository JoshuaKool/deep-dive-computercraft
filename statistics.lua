local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")

if monitor == nil then
    print("No monitor found")
    return
end

if modem == nil then
    print("No modem found")
    return
end

monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

local function drawVerticalProgressBar(monitor, filledPercentage)
    local width, height = monitor.getSize()
    local barHeight = height - 1
    local filledHeight = math.floor(filledPercentage * barHeight)
    local barXPos = math.floor(width / 2)

    for y = 1, filledHeight do
        monitor.setCursorPos(barXPos, height - y)
        monitor.setBackgroundColor(colors.green)
        monitor.write(" ")
    end

    for y = filledHeight + 1, barHeight do
        monitor.setCursorPos(barXPos, height - y)
        monitor.setBackgroundColor(colors.red)
        monitor.write(" ")
    end

    monitor.setBackgroundColor(colors.black)
end

local function countItems(inventory)
    local totalItems = 0
    for slot, item in pairs(inventory) do
        totalItems = totalItems + item.count
    end
    return totalItems
end

modem.open(1)

local isMainComputer = true

while true do
    modem.transmit(1, 1, "request_inventory")

    local totalUsedItems = 0
    local totalSlots = 0

    local timeout = os.startTimer(5)
    while true do
        local event, side, channel, replyChannel, message, distance = os.pullEvent()
        
        if event == "modem_message" and channel == 1 and replyChannel == 1 then
            local inventoryData = message
            totalUsedItems = inventoryData.usedItems
            totalSlots = inventoryData.totalSlots
            break
        elseif event == "timer" and side == timeout then
            totalSlots = -1
            break
        end
    end

    monitor.clear()
    if totalSlots > 0 then
        local filledPercentage = totalUsedItems / (totalSlots * 64)
        drawVerticalProgressBar(monitor, filledPercentage)
        monitor.setTextScale(0.5)
        monitor.setCursorPos(1, 1)
        monitor.write("Total Items: " .. totalUsedItems)
    else
        monitor.setCursorPos(1, 1)
        monitor.setTextScale(0.5)
        monitor.write("fuck")
    end

    sleep(5)
end