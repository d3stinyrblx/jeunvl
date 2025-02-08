local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:FindFirstChildOfClass("Humanoid")
local root = char:FindFirstChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "UltraBSD"

local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Size = UDim2.new(0, 400, 0, 350)
frame.Position = UDim2.new(0.5, -200, 0.5, -175)
frame.Active = true
frame.Draggable = true

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "Ultra BSD"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local closeButton = Instance.new("TextButton", frame)
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local container = Instance.new("ScrollingFrame", frame)
container.Size = UDim2.new(1, 0, 1, -30)
container.Position = UDim2.new(0, 0, 0, 30)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 500)

function createButton(text, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Text = text
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(callback)
end

local function notify(msg, color)
    local notif = Instance.new("TextLabel", gui)
    notif.Text = msg
    notif.Font = Enum.Font.SourceSansBold
    notif.TextSize = 16
    notif.Size = UDim2.new(0, 250, 0, 50)
    notif.Position = UDim2.new(0.5, -125, 0.1, 0)
    notif.BackgroundColor3 = color
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.BackgroundTransparency = 0.3
    notif.ZIndex = 10
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -125, 0.15, 0)}):Play()
    task.wait(2)
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -125, 0, -60)}):Play()
    task.wait(0.5)
    notif:Destroy()
end

local flying = false
local speedBoost = false

createButton("Fly Mode (Toggle)", container, function()
    flying = not flying
    notify(flying and "Fly Mode Enabled!" or "Fly Mode Disabled!", flying and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0))

    if flying then
        local BV = Instance.new("BodyVelocity", root)
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.MaxForce = Vector3.new(5000, 5000, 5000)
        
        local BG = Instance.new("BodyGyro", root)
        BG.CFrame = root.CFrame
        BG.MaxTorque = Vector3.new(5000, 5000, 5000)

        local flyLoop = RunService.RenderStepped:Connect(function()
            BV.Velocity = (workspace.CurrentCamera.CFrame.LookVector * (speedBoost and 100 or 50))
            BG.CFrame = workspace.CurrentCamera.CFrame
        end)

        while flying do task.wait() end
        flyLoop:Disconnect()
        BV:Destroy()
        BG:Destroy()
    end
end)

createButton("Speed Boost (Toggle)", container, function()
    speedBoost = not speedBoost
    notify(speedBoost and "Speed Boost Enabled!" or "Speed Boost Disabled!", speedBoost and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0))
    humanoid.WalkSpeed = speedBoost and 50 or 16
end)

createButton("Spiderman Mode", container, function()
    notify("Spiderman Mode Enabled!", Color3.fromRGB(0, 255, 0))
    
    local BG = Instance.new("BodyGyro", root)
    BG.MaxTorque = Vector3.new(5000, 5000, 5000)

    local BV = Instance.new("BodyVelocity", root)
    BV.MaxForce = Vector3.new(5000, 5000, 5000)

    local function stickToWalls()
        local ray = Ray.new(root.Position, root.CFrame.LookVector * 5)
        local hit, pos, normal = workspace:FindPartOnRay(ray, char)

        if hit then
            root.CFrame = CFrame.new(pos, pos + normal)
            BG.CFrame = root.CFrame
            BV.Velocity = root.CFrame.LookVector * 30
        else
            BV.Velocity = Vector3.new(0, -50, 0)
        end
    end

    local spiderLoop = RunService.RenderStepped:Connect(stickToWalls)

    task.wait(10)
    notify("Spiderman Mode Disabled!", Color3.fromRGB(255, 0, 0))
    spiderLoop:Disconnect()
    BG:Destroy()
    BV:Destroy()
end)

createButton("Rejoin", container, function()
    notify("Rejoining...", Color3.fromRGB(0, 255, 0))
    TeleportService:Teleport(game.PlaceId, player)
end)
