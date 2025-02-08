-- Ultra BSD

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:FindFirstChildOfClass("Humanoid")
local root = char:FindFirstChild("HumanoidRootPart")

-- UI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "UltraBSD"

local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.Active = true
frame.Draggable = true

-- Add rounded corners
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
closeButton.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Scrollable Container for Categories
local container = Instance.new("ScrollingFrame", frame)
container.Size = UDim2.new(1, 0, 1, -30)
container.Position = UDim2.new(0, 0, 0, 30)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 600)

local UIListLayout = Instance.new("UIListLayout", container)
UIListLayout.Padding = UDim.new(0, 5)

-- Function to Create Category Header
local function createCategory(name)
    local category = Instance.new("TextLabel", container)
    category.Text = name
    category.Font = Enum.Font.SourceSansBold
    category.TextSize = 16
    category.BackgroundTransparency = 1
    category.Size = UDim2.new(1, 0, 0, 30)
    category.TextColor3 = Color3.fromRGB(255, 165, 0)
end

-- Function to Create Buttons
local function createButton(text, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Text = text
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Rounded corners
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(callback)
end

-- Notification Function
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

    -- Animation
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -125, 0.15, 0)}):Play()
    task.wait(2)
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -125, 0, -60)}):Play()
    task.wait(0.5)
    notif:Destroy()
end

-- Movement Category
createCategory("Movement")

createButton("Spiderman Mode", container, function()
    notify("Spiderman Mode Enabled!", Color3.fromRGB(0, 255, 0))
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
end)

createButton("No Gravity", container, function()
    notify("No Gravity Enabled!", Color3.fromRGB(0, 255, 0))
    workspace.Gravity = 0
end)

createButton("Restore Gravity", container, function()
    notify("Gravity Restored", Color3.fromRGB(255, 165, 0))
    workspace.Gravity = 196.2
end)

-- Fun Category
createCategory("Fun")

createButton("Explode Self", container, function()
    notify("Boom!", Color3.fromRGB(255, 0, 0))
    local explosion = Instance.new("Explosion")
    explosion.Position = root.Position
    explosion.Parent = workspace
end)

createButton("Giant Mode", container, function()
    notify("You are now a giant!", Color3.fromRGB(0, 255, 0))
    humanoid.BodyHeightScale.Value = 2
    humanoid.BodyWidthScale.Value = 2
    humanoid.BodyDepthScale.Value = 2
end)

createButton("Ant Mode", container, function()
    notify("You are now tiny!", Color3.fromRGB(0, 255, 0))
    humanoid.BodyHeightScale.Value = 0.5
    humanoid.BodyWidthScale.Value = 0.5
    humanoid.BodyDepthScale.Value = 0.5
end)

-- Animation Category
createCategory("Animations")

local animBox = Instance.new("TextBox", container)
animBox.Size = UDim2.new(1, 0, 0, 40)
animBox.PlaceholderText = "Enter Animation ID"
animBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
animBox.TextColor3 = Color3.fromRGB(255, 255, 255)

createButton("Play Animation", container, function()
    local animID = animBox.Text
    if animID and animID ~= "" then
        notify("Playing Animation", Color3.fromRGB(0, 255, 0))
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. animID
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if animator then
            local animTrack = animator:LoadAnimation(anim)
            animTrack:Play()
        else
            notify("Animation failed!", Color3.fromRGB(255, 0, 0))
        end
    else
        notify("Enter a valid Animation ID!", Color3.fromRGB(255, 0, 0))
    end
end)

-- Misc Category
createCategory("Miscellaneous")

createButton("Rejoin", container, function()
    notify("Rejoining...", Color3.fromRGB(0, 255, 0))
    TeleportService:Teleport(game.PlaceId, player)
end)createButton("Ant Mode", container, function()
    notify("You are now tiny!", Color3.fromRGB(0, 255, 0))
    char:FindFirstChild("HumanoidRootPart").Size = Vector3.new(1, 1, 1)
    humanoid.BodyHeightScale.Value = 0.5
    humanoid.BodyWidthScale.Value = 0.5
    humanoid.BodyDepthScale.Value = 0.5
end)

local animBox = Instance.new("TextBox", container)
animBox.Size = UDim2.new(1, 0, 0, 40)
animBox.PlaceholderText = "Enter Animation ID"
animBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
animBox.TextColor3 = Color3.fromRGB(255, 255, 255)

createButton("Play Animation", container, function()
    local animID = animBox.Text
    if animID and animID ~= "" then
        notify("Playing Animation", Color3.fromRGB(0, 255, 0))
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. animID
        local animTrack = humanoid:LoadAnimation(anim)
        animTrack:Play()
    else
        notify("Enter a valid Animation ID!", Color3.fromRGB(255, 0, 0))
    end
end)

createButton("Rejoin", container, function()
    notify("Rejoining...", Color3.fromRGB(0, 255, 0))
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)
