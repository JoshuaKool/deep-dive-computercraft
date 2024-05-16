local monitor = peripheral.find("monitor")
monitor.clear()
monitor.setBackgroundColor(colors.black)

if monitor == nil then
    print("No monitor found")
    return
else
    local y = 1
    local x = 2
    monitor.setTextScale(0.5)
    monitor.setCursorPos(x, y)
    monitor.write("Welcome to the turtle program!")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=1 LocalApicld=0 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=2 LocalApicld=1 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=3 LocalApicld=2 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=4 LocalApicld=3 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=5 LocalApicld=255 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=6 LocalApicld=255 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=7 LocalApicld=255 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("BlackBoxACPICPU: Processorld=8 LocalApicld=255 Enabled")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Loading Program")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Loading statistic")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Loading data")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Good luck")
    sleep(1)
    monitor.clear()
end
sleep(2)
monitor.clear()
os.run({}, "statistics.lua")