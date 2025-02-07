local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local part = character:WaitForChild("Head")
local flying = false
local flySpeed = 50
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
bodyVelocity.Velocity = Vector3.new(0, 0, 0)

local lastSpacebarTime = 0
local spacebarDoubleClickTime = 0.5
local spacebarPressed = false

local function startFlying()
    if not flying then
        flying = true
        bodyVelocity.Parent = humanoid
        bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
    end
end

local function stopFlying()
    if flying then
        flying = false
        bodyVelocity.Parent = nil
    end
end

part.Touched:Connect(function(otherPart)
    local otherPlayer = game.Players:GetPlayerFromCharacter(otherPart.Parent)
    if otherPlayer and otherPlayer.Name ~= player.Name then
        for i = 1, 5 do
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Aaah! " .. otherPlayer.Name .. " touched me! PDIDDY ALERT!", "All")
            wait(1)
        end
    end
end)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        spacebarPressed = true
        local currentTime = tick()
        if spacebarPressed and currentTime - lastSpacebarTime <= spacebarDoubleClickTime then
            if flying then
                stopFlying()
            else
                startFlying()
            end
        end
        lastSpacebarTime = currentTime
    elseif input.KeyCode == Enum.KeyCode.F and spacebarPressed then
        if flying then
            stopFlying()
        else
            startFlying()
        end
    end
end)

game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageReceived.OnClientEvent:Connect(function(message)
    if message:lower() == "bro im in heaven" then
        if not flying then
            startFlying()
        end
    elseif message:lower() == "i forgot how to fly" then
        if flying then
            stopFlying()
        end
    end
end)
