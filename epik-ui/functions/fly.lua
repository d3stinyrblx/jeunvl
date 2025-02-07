-- Jeunvl's Fly UI
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local flySpeed = 50
local flying = false
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FlyUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 270, 0, 180)
frame.Position = UDim2.new(0.5, -135, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(60, 60, 60)
frame.BackgroundTransparency = 0.1
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.Font = Enum.Font.GothamBold
title.Text = "Jeunvl's Fly UI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.TextWrapped = true

local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 3)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14

local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(0.9, 0, 0, 35)
flyButton.Position = UDim2.new(0.05, 0, 0.25, 0)
flyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
flyButton.Font = Enum.Font.GothamBold
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 14
flyButton.TextWrapped = true

local unflyButton = Instance.new("TextButton", frame)
unflyButton.Size = UDim2.new(0.9, 0, 0, 35)
unflyButton.Position = UDim2.new(0.05, 0, 0.50, 0)
unflyButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
unflyButton.Font = Enum.Font.GothamBold
unflyButton.Text = "Unfly"
unflyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
unflyButton.TextSize = 14
unflyButton.TextWrapped = true

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(0.9, 0, 0, 20)
speedLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Speed: " .. flySpeed
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 12

local speedSlider = Instance.new("TextBox", frame)
speedSlider.Size = UDim2.new(0.9, 0, 0, 25)
speedSlider.Position = UDim2.new(0.05, 0, 0.85, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedSlider.Font = Enum.Font.Gotham
speedSlider.Text = tostring(flySpeed)
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
speedSlider.TextSize = 14
speedSlider.TextWrapped = true

local footer = Instance.new("TextLabel", frame)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.Gotham
footer.Text = "made on secrets <3"
footer.TextColor3 = Color3.fromRGB(255, 255, 255)
footer.TextSize = 12
footer.TextWrapped = true

local function fly()
    local character = player.Character
    if character and not flying then
        flying = true
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
            bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            local userInputConnection
            userInputConnection = UIS.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W then
                    bodyVelocity.Velocity = Vector3.new(0, 0, -flySpeed)
                elseif input.KeyCode == Enum.KeyCode.S then
                    bodyVelocity.Velocity = Vector3.new(0, 0, flySpeed)
                elseif input.KeyCode == Enum.KeyCode.A then
                    bodyVelocity.Velocity = Vector3.new(-flySpeed, 0, 0)
                elseif input.KeyCode == Enum.KeyCode.D then
                    bodyVelocity.Velocity = Vector3.new(flySpeed, 0, 0)
                end
            end)
            UIS.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
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
