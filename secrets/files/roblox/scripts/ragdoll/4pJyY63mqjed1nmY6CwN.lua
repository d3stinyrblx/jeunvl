local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local function ragdollCharacter(character)
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        humanoid.PlatformStand = true
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("Motor6D") then
                part:Destroy()
            end
        end
    end
end

local function unRagdollCharacter(character)
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        humanoid.PlatformStand = false
    end
end

if UserInputService.TouchEnabled then
    local mobileButton = Instance.new("TextButton")
    mobileButton.Size = UDim2.new(0, 100, 0, 100)
    mobileButton.Position = UDim2.new(0.5, -50, 0.8, -50)
    mobileButton.Text = ""
    mobileButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    mobileButton.BorderRadius = UDim.new(0, 50)
    mobileButton.Parent = player.PlayerGui:WaitForChild("ScreenGui")

    mobileButton.MouseButton1Click:Connect(function()
        if player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid.PlatformStand then
                unRagdollCharacter(player.Character)
            else
                ragdollCharacter(player.Character)
            end
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.R then
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            if player.Character then
                ragdollCharacter(player.Character)
            end
        elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
            if player.Character then
                unRagdollCharacter(player.Character)
            end
        end
    end
end)
