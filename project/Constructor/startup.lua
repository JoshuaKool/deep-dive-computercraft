for i = 1, 16 do
  turtle.select(i)
  if turtle.refuel(0) then
      turtle.refuel()
      print("Refueled with item in slot "..i)
  end
end

if turtle.getFuelLevel() <= 0 then
    print("Fuel level is insufficient.")
end

rednet.open("left")

local repetitions = 10
local forwardBlocks = 10
local totalSteps = 0

while true do
    local senderID, message, protocol = rednet.receive(5)

    if message == nil then
      print("No message received.")
    else
      print(message)
    end

    if message == "301" then
      for i = 1, repetitions do
        turtle.turnLeft()
        turtle.digDown()
        turtle.placeDown()
        turtle.turnRight()

        for j = 1, forwardBlocks do
          if not turtle.forward() then
            turtle.dig()
            turtle.forward()
            totalSteps = totalSteps + 1
          end
        end
      end
    end

    if message == "302" then
      print(totalSteps)
      for i = 1, totalSteps do
          turtle.back()
          turtle.digDown()
      end
      totalSteps = 0
  end
end

rednet.close("left")