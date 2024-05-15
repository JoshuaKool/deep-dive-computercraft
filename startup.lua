local monitor = peripheral.find("monitor")
monitor.clear()

if monitor == nil then
    print("No monitor found")
    return
else
    local buttoncollor = colors.red

    local function getClick()
        local event, side, x, y = os.pullEvent("monitor_touch")
        shell.run("loading.lua")
    end
    while true do
        getClick()
        if getClick() then
            break
        end
    end
end