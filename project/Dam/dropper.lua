-- Lua
rednet.open("back") -- Open the modem on the back of the computer

while true do
    local senderId, message, protocol = rednet.receive(5)
    message = tonumber(message)

    if senderId == nil and message == nil then
        print("No message received.")
    else
        print("Received message from senderId: "..senderId..", message: "..message)
    end
    
    if message == 101 then
        print("Received command 101 from computer " .. senderId)
        -- Add your code here to perform the action associated with command 101
    end
end

rednet.close("back") -- Close the modem