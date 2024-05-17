rednet.open("left")

turtle.refuel()

while true do
    id, message = rednet.receive(5)
    
    if id == nil and message == nil then
        print("No message received.")
    else
        print("Received message from ID: "..id)
        print("Message: "..message)

        local messageInt = tonumber(message)

        if messageInt == 502 then
            while true do
                turtle.select(1)
                turtle.refuel()
                turtle.select(2)
                turtle.dig()
                turtle.place()
                turtle.select(3)
                turtle.back()
                turtle.place()
                turtle.dig()
                sleep(4.1)
                for i = 1, 6 do
                    turtle.forward()
                    turtle.dig()
                end
                turtle.back()
            end
        elseif messageInt == 405 then
            break
        end
    end
end

rednet.close("left")