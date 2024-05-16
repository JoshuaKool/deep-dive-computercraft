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
    monitor.setCursorPos(1, 1)
    monitor.write(x)
    monitor.setCursorPos(1, 2)
    monitor.write(y)

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

        for chest in pairs(inventory) do
            chest.name = chest.name:gsub("minecraft:", "")
            local text2 = chest.name
            local text = "chest"
            local width = math.floor((x - #text) / 2)
            local height = 1
            monitor.setCursorPos(width, height)
            monitor.write(text)
        end
        else if barrel == "minecraft:barrel" then
            local inventory = barrel.list()
            for barrel in pairs(inventory) do
                barrel.name = barrel.name:gsub("minecraft:", "")
                local text2 = barrel.name
                local text = "chest"
                local width = math.floor((x - #text) / 2)
                local height = 1
                monitor.setCursorPos(width, height)
                monitor.write(text)
            end
        end
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("minecraft:chest")
    local barrel = peripheral.find("minecraft:barrel")
    print_inventory_statistics(chest, barrel, monitor)

    sleep(1)
end