print("Awaiting commands from MCU")

local reverseTable = {}

while true do
    if turtle.getFuelLevel() > 0 then
        print("Fuel level is sufficient.")
        break
    end

    local command = io.read()

    if command == "refuel" then
        for i = 1, 16 do
            turtle.select(i)
            if turtle.refuel(0) then
                turtle.refuel()
                print("Refueled with item in slot "..i)
                break
            end
        end
    else 
        print("Invalid command.")
        break
    end
end

function checkDirection(direction)
    if direction == true then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end
end

if peripheral.isPresent("left") then
    rednet.open("left")
    os.sleep(1)
    if not rednet.isOpen("left") then
        print("Failed to open rednet connection on the left side.")
        return
    end
else
    print("No modem found on the left side.")
    return
end

while true do
    local senderId, message = rednet.receive(5)
    
    if senderId == nil and message == nil then
        print("No message received.")
    else
        print("Received message from senderId: "..senderId..", message: "..message)
    end
        
    if message ~= nil then
        local command, size = string.match(message, "(%d+) (%d+)")
        command = tonumber(command)
        size = tonumber(size)
        if size then
            size = size - 1
        end

        print(message)

        if command == 401 then
            direction = true
            while (1 > 0) do
                a = 0
                repeat
                    i = 0
                    repeat
                        turtle.dig()
                        if not turtle.forward() then
                            break
                        end
                        i = i + 1
                    until (i > size - 1)
                    if a < size then
                        checkDirection(direction)
                        turtle.dig()
                        if not turtle.forward() then
                            break
                        end
                        checkDirection(direction)
                        if direction == true then
                            direction = false
                        else
                            direction = true
                        end
                    else
                        print("Stopped")
                    end
                    a = a + 1
                until (a > size)
                turtle.turnRight()
                j = 0
                repeat
                    if not turtle.forward() then
                        break
                    end
                    j = j + 1
                    print(j)
                until (j >= size)
                turtle.turnRight()
                turtle.digDown()
                local success = turtle.detectDown()
                if success then
                    break
                end
                turtle.down()
                table.insert(reverseTable, "turtle.up()")
                direction = true
            end
        end
        if message == "504" then    
            for i = #reverseTable, 1, -1 do
                loadstring(reverseTable[i])()
            end
            print("Succesfully returned, system is now ready for phase 2")
        end
    end
end