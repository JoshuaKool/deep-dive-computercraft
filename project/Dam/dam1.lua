print("Awaiting commands from MCU")

local reverseTable = {}

rednet.open("left")

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

while true do
    local senderId, message = rednet.receive(5)
    
    if senderId == nil and message == nil then
        print("No message received.")
    else
        print("Received message from senderId: "..senderId..", message: "..message)
    end
        
    if message ~= nil then
        local command = tonumber(message)
        
        if command == 201 then
            print("Received command 201 from computer " .. senderId)
            turtle.up()
        elseif command == 202 then
            turtle.down()
        end
    end
end

rednet.close("left")