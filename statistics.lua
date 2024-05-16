local monitor = peripheral.find("monitor")
local chest = peripheral.find("minecraft:chest")
local shulker = peripheral.find("minecraft:shulker_box")
local barrel = peripheral.find("minecraft:barrel")


monitor.clear()

if monitor == nil then
    print("No monitor found")
    return
end

if chest == "minecraft:chest" then
    iets = chest
    else if shulker == "minecraft:shulker_box" then
        iets = shulker
        else if barrel == "minecraft:barrel" then
            iets = barrel
        end
    end
end

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
else
    monitor.clear()
    local inventory = iets.list()
    if iets.list() == nil then
        monitor.write("No items found")
    end

    for name in pairs(inventory) do
        name.name = name.name:gsub("minecraft:", "")
        local text = name.name
        local width = math.floor((x - #text) / 2)
        local height = 1
        monitor.setCursorPos(width, height)
        monitor.write(text)
    end
end
end