local monitor = peripheral.find("monitor")
local modems = peripheral.find("modem", function(name, object) return object.isWireless() end)

if monitor == nil then
    print("No monitor found")
    return
end

monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

if #modems == 0 then
    print("No wireless modems found")
    return
end

print("Wireless modems found: " .. #modems)

for _, modem in ipairs(modems) do
    modem.open(1) -- Open the modem on channel 1 to communicate with peripherals
end

local function drawVerticalProgressBar(monitor, usedItems, totalSlots)
    local width, height = monitor.getSize()
    local barHeight = height - 1
    local filledHeight = math.floor((usedItems / (totalSlots * 64)) * barHeight)
    local emptyHeight = barHeight - filledHeight
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

local function findChestOrBarrelConnectedToModem(modem)
    local connectedPeripherals = modem.getNamesRemote()
    for _, peripheralName in ipairs(connectedPeripherals) do
        local peripheralType = peripheral.getType(peripheralName)
        if peripheralType == "minecraft:chest" or peripheralType == "minecraft:barrel" then
            local peripheralObject = peripheral.wrap(peripheralName)
            local inventory = peripheralObject.list()
            local totalSlots = peripheralObject.size()
            local usedItems = countItems(inventory)
            return usedItems, totalSlots
        elseif peripheralType == "modem" then
            local subModem = peripheral.wrap(peripheralName)
            return findChestOrBarrelConnectedToModem(subModem)
        end
    end
    return 0, 0
end

while true do
    local totalUsedItems, totalSlots = 0, 0
    for _, modem in ipairs(modems) do
        local usedItems, slots = findChestOrBarrelConnectedToModem(modem)
        totalUsedItems = totalUsedItems + usedItems
        totalSlots = totalSlots + slots
    end

    local monitorWidth, monitorHeight = monitor.getSize()

    if monitorWidth < 18 then
        monitor.setTextScale(0.5)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor must be at least 2 blocks wide")
        return
    elseif monitorHeight < 19 then
        monitor.setTextScale(0.5)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor must be at least 3 blocks high")
        return
    end

    drawVerticalProgressBar(monitor, totalUsedItems, totalSlots)
    monitor.setTextScale(0.5)
    monitor.setCursorPos(1, 1)
    monitor.setBackgroundColor(colors.black)
    monitor.clearLine()
    monitor.write("Total items: " .. totalUsedItems)

    sleep(5)
end