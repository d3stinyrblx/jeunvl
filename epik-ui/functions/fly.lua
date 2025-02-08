-- Jeunvl's Fly UI
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local flySpeed = 50
local flying = false
local bodyVelocity
local bodyGyro

StarterGui:SetCore("OnScreenKeyboardMode", Enum.OnScreenKeyboardMode.Dynamic)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyUI"
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 270, 0, 120)
frame.Position = UDim2.new(0.5, -135, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(60, 60, 60)
frame.BackgroundTransparency = 0.1
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(0.9, 0, 0.4, 0)
flyButton.Position = UDim2.new(0.05, 0, 0.1, 0)
flyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
flyButton.Font = Enum.Font.GothamBold
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 14

local flyCorner = Instance.new("UICorner", flyButton)
flyCorner.CornerRadius = UDim.new(0, 8)

local unflyButton = Instance.new("TextButton", frame)
unflyButton.Size = UDim2.new(0.9, 0, 0.4, 0)
unflyButton.Position = UDim2.new(0.05, 0, 0.55, 0)
unflyButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
unflyButton.Font = Enum.Font.GothamBold
unflyButton.Text = "Unfly"
unflyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
unflyButton.TextSize = 14

local unflyCorner = Instance.new("UICorner", unflyButton)
unflyCorner.CornerRadius = UDim.new(0, 8)

local function fly()
    local character = player.Character
    if character and not flying then
        flying = true
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            bodyVelocity = Instance.new("BodyVelocity", rootPart)
            bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)

            bodyGyro = Instance.new("BodyGyro", rootPart)
            bodyGyro.CFrame = rootPart.CFrame
            bodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)

            UIS.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W then
                    bodyVelocity.Velocity = Vector3.new(0, 0, -flySpeed)
                elseif input.KeyCode == Enum.KeyCode.S then
                    bodyVelocity.Velocity = Vector3.new(0, 0, flySpeed)
                elseif input.KeyCode == Enum.KeyCode.A then
                    bodyVelocity.Velocity = Vector3.new(-flySpeed, 0, 0)
                elseif input.KeyCode == Enum.KeyCode.D then
                    bodyVelocity.Velocity = Vector3.new(flySpeed, 0, 0)
                elseif input.KeyCode == Enum.KeyCode.Space then
                    bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
                elseif input.KeyCode == Enum.KeyCode.LeftControl then
                    bodyVelocity.Velocity = Vector3.new(0, -flySpeed, 0)
                end
            end)

            UIS.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftControl then
                    bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
                end
            end)
        end
    end
end

local function unfly()
    local character = player.Character
    if character and flying then
        flying = false
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end
end

flyButton.MouseButton1Click:Connect(fly)
unflyButton.MouseButton1Click:Connect(unfly)                if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
                    bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
                end
            end)
        end
    end
end

local function unfly()
    local character = player.Character
    if character and flying then
        flying = false
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            for _, v in pairs(humanoidRootPart:GetChildren()) do
                if v:IsA("BodyVelocity") then
                    v:Destroy()
                end
            end
        end
    end
end

flyButton.MouseButton1Click:Connect(fly)
unflyButton.MouseButton1Click:Connect(unfly)

speedSlider.FocusLost:Connect(function()
    local newSpeed = tonumber(speedSlider.Text)
    if newSpeed then
        flySpeed = newSpeed
        speedLabel.Text = "Speed: " .. flySpeed
    else
        speedSlider.Text = tostring(flySpeed)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
