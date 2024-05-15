local monitor = peripheral.find("monitor")

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
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("1")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Loading control buttons")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Succes")
    sleep(1)
    monitor.clear()
end

shell.run("button.lua")