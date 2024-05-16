local monitor = peripheral.find("monitor")
local chest = peripheral.find("minecraft:chest")
local barrel = peripheral.find("minecraft:barrel")

monitor.clear()

if monitor == nil then
    print("No monitor found")
    return
end

function print_inventory_statistics(chest, barrel, monitor)
    local x, y = monitor.getSize()

    if x < 36 then
        monitor.setTextScale(4)
        monitor.write("Monitor width is too small")
    else if y < 13 then
        monitor.setTextScale(6)
        monitor.write("Monitor high is too small")
    end
    end
    if chest == "minecraft:chest" then
        local inventory = chest.list()
        local width = math.floor((x - 5) / 2)
        local height = 1
        monitor.setCursorPos(width, height)
        monitor.write("chest")
        for slot, item in pairs(inventory) do
            item.name = item.name:gsub("minecraft:", "")
            local text = item.name
            local width = math.floor((x - 5) / 2)
            local height = 2
            monitor.setCursorPos(width, height)
            monitor.write("chest")
        end
        else if barrel == "minecraft:barrel" then
            local inventory = barrel.list()
            local width = math.floor((x - 6) / 2)
            local height = 1
            monitor.setCursorPos(width, height)
            monitor.write("barrel")
            for slot, item in pairs(inventory) do
                item.name = item.name:gsub("minecraft:", "")
                local text = item.name
                local width = math.floor((x - 6) / 2)
                local height = 2
                monitor.setCursorPos(width, height)
                monitor.write("barrel")
            end
        end
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("minecraft:chest")
    local barrel = peripheral.find("minecraft:barrel")
    print_inventory_statistics(chest, barrel, monitor)

    sleep(10)
end