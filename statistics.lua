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

local function drawVerticalProgressBar(monitor, usedItems, totalSlots)
    local width, height = monitor.getSize()
    local barHeight = height - 1
    local filledHeight = math.floor((usedItems / (totalSlots * 64)) * barHeight)
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

local function getModemList()
    local modems = {modem}
    for _, name in pairs(peripheral.getNames()) do
        if peripheral.getType(name) == "modem" and name ~= peripheral.getName(modem) then
            table.insert(modems, peripheral.wrap(name))
        end
    end
    return modems
end

local isMainComputer = false

print("Is this the main computer? (yes/no)")
local answer = read()
if answer:lower() == "yes" then
    isMainComputer = true
end

if isMainComputer then
    while true do
        local modems = getModemList()
        for _, m in pairs(modems) do
            m.transmit(1, 1, "request_inventory")
        end

        local totalUsedItems = 0
        local totalSlots = 0

        -- Wait for responses
        local timeout = os.startTimer(5)
        while true do
            local event, side, channel, replyChannel, message, distance = os.pullEvent()
            
            if event == "modem_message" and channel == 1 and replyChannel == 1 then
                local inventoryData = message
                totalUsedItems = totalUsedItems + inventoryData.usedItems
                totalSlots = totalSlots + inventoryData.totalSlots
            elseif event == "timer" and side == timeout then
                break
            end
        end

        if totalSlots > 0 then
            drawVerticalProgressBar(monitor, totalUsedItems, totalSlots)
            monitor.setTextScale(0.5)
            monitor.setCursorPos(1, 1)
            monitor.setBackgroundColor(colors.black)
            monitor.clearLine()
            monitor.write("Total Items: " .. totalUsedItems)
        else
            monitor.clear()
            monitor.setCursorPos(1, 1)
            monitor.setTextScale(0.5)
            monitor.write("No inventory data received")
        end

        sleep(5)
    end
else
    while true do
        local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        
        if channel == 1 and message == "request_inventory" then
            local chest = peripheral.find("minecraft:chest")
            local barrel = peripheral.find("minecraft:barrel")
            
            local usedItems = 0
            local totalSlots = 0

            if chest then
                usedItems = countItems(chest.list())
                totalSlots = chest.size()
            elseif barrel then
                usedItems = countItems(barrel.list())
                totalSlots = barrel.size()
            end

            modem.transmit(1, 1, {usedItems = usedItems, totalSlots = totalSlots})
        end
    end
end