local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
else
    local function getClick()
        local event, side, x, y = os.pullEvent("monitor_touch")
        print("Click at x: " .. x .. " y: " .. y)
    end
    while true do
        getClick()
    end
end