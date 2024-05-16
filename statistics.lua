local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
end

monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

local function drawProgressBar(monitor, usedSlots, totalSlots)
    local width, height = monitor.getSize()
    local barLength = width
    local filledLength = math.floor((usedSlots / totalSlots) * barLength)
    local emptyLength = barLength - filledLength

    monitor.setCursorPos(1, 2)
    monitor.setBackgroundColor(colors.green)
    monitor.write(string.rep(" ", filledLength))
    monitor.setBackgroundColor(colors.red)
    monitor.write(string.rep(" ", emptyLength))
    monitor.setBackgroundColor(colors.black)
end

local function countStacks(inventory)
    local totalItems = 0
    for slot, item in pairs(inventory) do
        totalItems = totalItems + item.count
    end
    return math.floor(totalItems / 64), totalItems % 64
end

local function printInventoryStatistics(monitor, inventory, title)
    local width, height = monitor.getSize()
    local yPos = 1

    monitor.clear()
    monitor.setCursorPos(1, yPos)
    monitor.write(title)
    yPos = yPos + 1

    local fullStacks, remainingItems = countStacks(inventory)
    monitor.setCursorPos(1, yPos)
    monitor.write("Full Stacks: " .. fullStacks)
    yPos = yPos + 1
    monitor.setCursorPos(1, yPos)
    monitor.write("Remaining Items: " .. remainingItems)
    yPos = yPos + 1

    for slot, item in pairs(inventory) do
        item.name = item.name:gsub("minecraft:", "")
        local text = item.name .. " x" .. item.count
        local xPos = math.floor((width - #text) / 2)
        monitor.setCursorPos(xPos, yPos)
        monitor.write(text)
        yPos = yPos + 1
    end
end

while true do
    local chest = peripheral.find("minecraft:chest")
    local barrel = peripheral.find("minecraft:barrel")

    if chest == nil and barrel == nil then
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("No chest or barrel found")
    else
        local inventory
        local title

        if chest then
            inventory = chest.list()
            title = "Chest Inventory"
        elseif barrel then
            inventory = barrel.list()
            title = "Barrel Inventory"
        end

        printInventoryStatistics(monitor, inventory, title)

        local totalSlots = chest and chest.size() or barrel.size()
        local usedSlots = chest and #chest.list() or #barrel.list()

        drawProgressBar(monitor, usedSlots, totalSlots)
    end

    sleep(5)
end