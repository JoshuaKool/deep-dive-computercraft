local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
end

monitor.clear()
monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

local function drawProgressBar(usedSlots, totalSlots)
    local width, height = monitor.getSize()
    local barLength = width
    local filledLength = math.floor((usedSlots / totalSlots) * barLength)
    local emptyLength = barLength - filledLength

    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.setBackgroundColor(colors.green)
    monitor.write(string.rep(" ", filledLength))
    monitor.setBackgroundColor(colors.red)
    monitor.write(string.rep(" ", emptyLength))
    monitor.setBackgroundColor(colors.black)
end

function print_inventory_statistics(chest, barrel, monitor)
    local x, y = monitor.getSize()

    if x < 36 then
        monitor.setTextScale(4)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor width is too small")
        return
    elseif y < 13 then
        monitor.setTextScale(6)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor height is too small")
        return
    end

    if chest then
        local inventory = chest.list()
        for slot, item in pairs(inventory) do
            item.name = item.name:gsub("minecraft:", "")
            local text = item.name
            local width = math.floor((x - #text) / 2)
            local height = 1
            monitor.setCursorPos(width, height)
            monitor.write("Chest: " .. text)
        end
    elseif barrel then
        local inventory = barrel.list()
        for slot, item in pairs(inventory) do
            item.name = item.name:gsub("minecraft:", "")
            local text = item.name
            local width = math.floor((x - #text) / 2)
            local height = 1
            monitor.setCursorPos(width, height)
            monitor.write("Barrel: " .. text)
        end
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
        monitor.clear()
        print_inventory_statistics(chest, barrel, monitor)

        local totalSlots = chest and chest.size() or barrel.size()
        local usedSlots = chest and #chest.list() or #barrel.list()

        drawProgressBar(usedSlots, totalSlots)
    end

    sleep(5)
end