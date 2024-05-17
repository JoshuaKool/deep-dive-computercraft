local monitor = peripheral.wrap("right")
monitor.clear()

if monitor == nil then
    print("No monitor found")
    return
else
    local y = 1
    local x = 2
    monitor.setTextScale(0.5)
    monitor.setCursorPos(x, y)
    monitor.write("Initializing all connected MCU peripherals...")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=1 Local APIC ID=0 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=2 Local APIC ID=1 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=3 Local APIC ID=2 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=4 Local APIC ID=3 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=5 Local APIC ID=255 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=6 Local APIC ID=255 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=7 Local APIC ID=255 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("ACPI CPU Management: Processor ID=8 Local APIC ID=255 Status=Active")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Requiring all modules")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Loading system statistics...")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("Initializing data repositories")
    sleep(0.25)
    y = y + 1
    monitor.setCursorPos(x, y)
    monitor.write("System initialization complete")
    sleep(1)
    monitor.clear()
end
sleep(2)
monitor.clear()

local monitor = peripheral.wrap("right")
monitor.clear()
term.clear()

monitor.setCursorPos(1, 1)
local monitor = peripheral.wrap("right")
monitor.write("All systems are online and awaiting instructions.")

local monitor = peripheral.wrap("top")
monitor.write("MCU /")
monitor.setCursorPos(1, 2)
monitor.write("Master Control")
monitor.setCursorPos(1, 3)
monitor.write("Unit")
monitor.setTextScale(0.5)

term.setCursorPos(1, 1)
print("MCU terminal online and awaiting instructions.")
term.setCursorPos(1, 2)

function helpMenu()
    local monitor = peripheral.wrap("top")
    monitor.write("MCU /")
    monitor.setCursorPos(1, 2)
    monitor.write("Master Control")
    monitor.setCursorPos(1, 3)
    monitor.write("Unit")
    monitor.setTextScale(0.5)

    local monitor = peripheral.wrap("right")
    monitor.clear()
    monitor.setTextScale(0.5)
    monitor.setCursorPos(1, 1)
    monitor.write("Usage: MCU <command>")
    monitor.setCursorPos(1, 2)
    monitor.write("Commands:")
    monitor.setCursorPos(1, 3)
    monitor.write("  101 - activate dropper")
    monitor.setCursorPos(1, 4)
    monitor.write("  102 - deactive dropper")
    monitor.setCursorPos(1, 5)
    monitor.write("  201 - raise dam 1 [SAN]")
    monitor.setCursorPos(1, 6)
    monitor.write("  202 - lower dam 2 [NAS]")
    monitor.setCursorPos(1, 7)
    monitor.write("  203 - raise dam 2 [NAS]")
    monitor.setCursorPos(1, 8)
    monitor.write("  203 - lower dam 2 [NAS]")
    monitor.setCursorPos(1, 9)
    monitor.write("  301 - Start Constructor")
    monitor.setCursorPos(1, 10)
    monitor.write("  302 - Constructor: Remove Vertical Drills")
    monitor.setCursorPos(1, 11)
    monitor.write("  401 - Start vertical drills for excav")
    monitor.setCursorPos(1, 12)
    monitor.write("  501 - Start drills [SPD MODE]")
    monitor.setCursorPos(1, 13)
    monitor.write("  502 - Start drills [ACR MODE]")
    monitor.setCursorPos(1, 14)
    monitor.write("  503 - Stop the drilling process")
    monitor.setCursorPos(1, 15)
    monitor.write("  504 - Return drills to the starting point")
    monitor.setCursorPos(1, 16)
    monitor.write("  505 - Emergency shutdown")    
end

if peripheral.isPresent("right") then
    local monitor = peripheral.wrap("right")
    monitor.setTextScale(0.5)
else
    print("No monitor found on the right side.")
end

local valid_inputs = {
    ["101"] = true,
    ["102"] = true,
    ["201"] = true,
    ["202"] = true,
    ["203"] = true,
    ["204"] = true,
    ["301"] = true,
    ["302"] = true,
    ["401"] = true,
    ["501"] = true,
    ["502"] = true,
    ["504"] = true,
}

while true do
    local input = read()
    if input == "cmds" then
        helpMenu()
    elseif input == "cls" then
        term.clear()
        term.setCursorPos(1, 1) 
        if peripheral.isPresent("right") then
            local monitor = peripheral.wrap("right")
            monitor.clear()
            local monitor = peripheral.wrap("top")
            monitor.clear()
            monitor.setCursorPos(1, 1)
        end
    elseif input == "restart" then
        os.reboot()
    elseif input == "401" then
        print("Enter grid size for ecvaction:")
        local size = tonumber(read())
        if peripheral.isPresent("back") then
            rednet.open("back")
            rednet.broadcast(input .. " " .. size)
            print("Executing code " .. input .. " with grid layout of " .. size .. "x" .. size .. " to all connected devices.")
            monitor.write("Executing code " .. input .. " with grid layout of " .. size .. "x" .. size .. " to all connected devices.")
            rednet.close("back")
        else
            print("No modem found on the back side.")
        end
    elseif valid_inputs[input] then
        if peripheral.isPresent("back") then
            rednet.open("back")
            rednet.broadcast(input)
            print("Executing code " .. input .. " to all connected devices.")
            rednet.close("back")
        else
            print("No modem found on the back side.")
        end
    else 
        print("Invalid command. Type 'cmds' for a list of commands.")
    end
end