print("Awaiting commands from MCU")

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
        size = tonumber(size) - 1

        if command == "401" then
            direction = true
            while (1 > 0) do
                a = 0
                repeat
                    i = 0
                    repeat
                        turtle.dig()
                        turtle.forward()
                        table.insert("turtle.back()")
                        i = i + 1
                    until (i > size - 1)
                    if a < size then
                        checkDirection(direction)
                        turtle.dig()
                        turtle.forward()
                        table.insert("turtle.back()")
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
                table.insert("turtle.Left()")
                j = 0
                repeat
                    turtle.forward()
                    j = j + 1
                    print(j)
                until (j >= size)
                turtle.turnRight()
                table.insert("turtle.Left()")
                turtle.digDown()
                turtle.down()
                table.insert("turtle.up()")
                direction = true
            end
        end
    end
end