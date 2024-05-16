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
    iets = "chest"
    else if shulker == "minecraft:shulker_box" then
        iets = "shulker"
        else if barrel == "minecraft:barrel" then
            iets = "barrel"
        end
    end
end

local x, y = monitor.getSize()

if x < 71 then
    print("Monitor width is too small")
    return
else if y < 26 then
    print("Monitor high is too small")
    return
else
    monitor.clear()
    monitor.write("hello")
end
end