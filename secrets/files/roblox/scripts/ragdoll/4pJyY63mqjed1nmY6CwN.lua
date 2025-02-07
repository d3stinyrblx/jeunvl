local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local userInputService = game:GetService("UserInputService")
local ragdollButton = Instance.new("TextButton")
local ragdolled = false

local function ragdoll()
    if not ragdolled then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                bodyVelocity.Velocity = Vector3.new(math.random(), math.random(), math.random()) * 100
                bodyVelocity.Parent = part
            end
        end
        ragdolled = true
        ragdollButton.Text = "Unragdoll"
    end
end

local function unragdoll()
    if ragdolled then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                for _, object in pairs(part:GetChildren()) do
                    if object:IsA("BodyVelocity") then
                        object:Destroy()
                    end
                end
            end
        end
        ragdolled = false
        ragdollButton.Text = "Ragdoll"
    end
end

ragdollButton.Size = UDim2.new(0, 150, 0, 50)
ragdollButton.Position = UDim2.new(0.5, -75, 0.9, -25)
ragdollButton.Text = "Ragdoll"
ragdollButton.Parent = player.PlayerGui:WaitForChild("ScreenGui")

ragdollButton.MouseButton1Click:Connect(function()
    if ragdolled then
        unragdoll()
    else
        ragdoll()
    end
end)

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.S and userInputService:IsKeyDown(Enum.KeyCode.R) then
        ragdoll()
    elseif input.KeyCode == Enum.KeyCode.S and userInputService:IsKeyDown(Enum.KeyCode.U) then
        unragdoll()
    end
end)
