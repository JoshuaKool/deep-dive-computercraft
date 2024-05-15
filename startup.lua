local monitor = peripheral.find("monitor")
local loop = true
local button = require("button")

if monitor == nil then
    print("No monitor found")
    return
else
    local buttoncollor = button.screen()

    local function getClick()
        local event, side, x, y = os.pullEvent("monitor_touch")
        shell.run("loading.lua")
    end
    while loop == true do
        getClick()
        if getClick() then
            loop = false
            return
        end
    end
end