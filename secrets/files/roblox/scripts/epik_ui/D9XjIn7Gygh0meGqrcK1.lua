local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local playerGui = player.PlayerGui

local flying = false
local noclipEnabled = false
local spinning = false
local bubbleChatEnabled = false
local copiedAvatar = nil
local targetPlayer = nil
local jumpPower = 50
local walkSpeed = 16
local multipleJumps = false
local currentJumps = 0
local maxJumps = 2
local antiAfk = false

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.Name = "ToolUI"

local uiFrame = Instance.new("Frame")
uiFrame.Parent = screenGui
uiFrame.Size = UDim2.new(0, 300, 0, 700)
uiFrame.Position = UDim2.new(0.5, -150, 0.5, -350)
uiFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
uiFrame.BorderSizePixel = 0
uiFrame.BackgroundTransparency = 0.2
uiFrame.ZIndex = 10
uiFrame.ClipsDescendants = true
local corner = Instance.new("UICorner")
corner.Parent = uiFrame
corner.CornerRadius = UDim.new(0, 15)
local outline = Instance.new("UIStroke")
outline.Parent = uiFrame
outline.Color = Color3.fromRGB(0, 255, 0)
outline.Thickness = 3

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = uiFrame
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
titleLabel.Text = "Jeunvl's Epik UI"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.TextStrokeTransparency = 0.8
titleLabel.Font = Enum.Font.GothamBold
titleLabel.ZIndex = 11

local footerLabel = Instance.new("TextLabel")
footerLabel.Parent = uiFrame
footerLabel.Size = UDim2.new(1, 0, 0, 50)
footerLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
footerLabel.Position = UDim2.new(0, 0, 1, -50)
footerLabel.Text = "Created by: Jeunvl <3"
footerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
footerLabel.TextSize = 16
footerLabel.TextStrokeTransparency = 0.8
footerLabel.Font = Enum.Font.Gotham

local mainToolsCategory = Instance.new("Frame")
mainToolsCategory.Parent = uiFrame
mainToolsCategory.Size = UDim2.new(1, 0, 0, 300)
mainToolsCategory.Position = UDim2.new(0, 0, 0, 50)
mainToolsCategory.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainToolsCategory.ZIndex = 11

local bypassCategory = Instance.new("Frame")
bypassCategory.Parent = uiFrame
bypassCategory.Size = UDim2.new(1, 0, 0, 300)
bypassCategory.Position = UDim2.new(0, 0, 0, 350)
bypassCategory.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
bypassCategory.ZIndex = 11

local flyButton = Instance.new("TextButton")
flyButton.Parent = mainToolsCategory
flyButton.Size = UDim2.new(1, 0, 0, 50)
flyButton.Position = UDim2.new(0, 0, 0, 0)
flyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.Gotham
flyButton.TextSize = 20

local noclipButton = Instance.new("TextButton")
noclipButton.Parent = mainToolsCategory
noclipButton.Size = UDim2.new(1, 0, 0, 50)
noclipButton.Position = UDim2.new(0, 0, 0, 60)
noclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noclipButton.Text = "No-Clip"
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Font = Enum.Font.Gotham
noclipButton.TextSize = 20

local bubbleChatButton = Instance.new("TextButton")
bubbleChatButton.Parent = mainToolsCategory
bubbleChatButton.Size = UDim2.new(1, 0, 0, 50)
bubbleChatButton.Position = UDim2.new(0, 0, 0, 120)
bubbleChatButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
bubbleChatButton.Text = "Bubble Chat"
bubbleChatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
bubbleChatButton.Font = Enum.Font.Gotham
bubbleChatButton.TextSize = 20

local spinButton = Instance.new("TextButton")
spinButton.Parent = mainToolsCategory
spinButton.Size = UDim2.new(1, 0, 0, 50)
spinButton.Position = UDim2.new(0, 0, 0, 180)
spinButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
spinButton.Text = "Spin"
spinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spinButton.Font = Enum.Font.Gotham
spinButton.TextSize = 20

local rejoinButton = Instance.new("TextButton")
rejoinButton.Parent = mainToolsCategory
rejoinButton.Size = UDim2.new(1, 0, 0, 50)
rejoinButton.Position = UDim2.new(0, 0, 0, 240)
rejoinButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
rejoinButton.Text = "Rejoin"
rejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinButton.Font = Enum.Font.Gotham
rejoinButton.TextSize = 20

local hitboxButton = Instance.new("TextButton")
hitboxButton.Parent = mainToolsCategory
hitboxButton.Size = UDim2.new(1, 0, 0, 50)
hitboxButton.Position = UDim2.new(0, 0, 0, 300)
hitboxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hitboxButton.Text = "Hitbox"
hitboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hitboxButton.Font = Enum.Font.Gotham
hitboxButton.TextSize = 20

local copyAvatarButton = Instance.new("TextButton")
copyAvatarButton.Parent = mainToolsCategory
copyAvatarButton.Size = UDim2.new(1, 0, 0, 50)
copyAvatarButton.Position = UDim2.new(0, 0, 0, 360)
copyAvatarButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
copyAvatarButton.Text = "Copy Avatar"
copyAvatarButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyAvatarButton.Font = Enum.Font.Gotham
copyAvatarButton.TextSize = 20

local tpButton = Instance.new("TextButton")
tpButton.Parent = mainToolsCategory
tpButton.Size = UDim2.new(1, 0, 0, 50)
tpButton.Position = UDim2.new(0, 0, 0, 420)
tpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tpButton.Text = "Teleport"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.Font = Enum.Font.Gotham
tpButton.TextSize = 20

local changeSpeedButton = Instance.new("TextButton")
changeSpeedButton.Parent = bypassCategory
changeSpeedButton.Size = UDim2.new(1, 0, 0, 50)
changeSpeedButton.Position = UDim2.new(0, 0, 0, 0)
changeSpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
changeSpeedButton.Text = "Change Speed"
changeSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
changeSpeedButton.Font = Enum.Font.Gotham
changeSpeedButton.TextSize = 20

local changeJumpButton = Instance.new("TextButton")
changeJumpButton.Parent = bypassCategory
changeJumpButton.Size = UDim2.new(1, 0, 0, 50)
changeJumpButton.Position = UDim2.new(0, 0, 0, 60)
changeJumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
changeJumpButton.Text = "Change Jump Power"
changeJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
changeJumpButton.Font = Enum.Font.Gotham
changeJumpButton.TextSize = 20

local multipleJumpsButton = Instance.new("TextButton")
multipleJumpsButton.Parent = bypassCategory
multipleJumpsButton.Size = UDim2.new(1, 0, 0, 50)
multipleJumpsButton.Position = UDim2.new(0, 0, 0, 120)
multipleJumpsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
multipleJumpsButton.Text = "Multiple Jumps"
multipleJumpsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
multipleJumpsButton.Font = Enum.Font.Gotham
multipleJumpsButton.TextSize = 20

local noLagButton = Instance.new("TextButton")
noLagButton.Parent = bypassCategory
noLagButton.Size = UDim2.new(1, 0, 0, 50)
noLagButton.Position = UDim2.new(0, 0, 0, 180)
noLagButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noLagButton.Text = "No Lag"
noLagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noLagButton.Font = Enum.Font.Gotham
noLagButton.TextSize = 20

local antiAfkButton = Instance.new("TextButton")
antiAfkButton.Parent = bypassCategory
antiAfkButton.Size = UDim2.new(1, 0, 0, 50)
antiAfkButton.Position = UDim2.new(0, 0, 0, 240)
antiAfkButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
antiAfkButton.Text = "Anti AFK Kick"
antiAfkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
antiAfkButton.Font = Enum.Font.Gotham
antiAfkButton.TextSize = 20

local flying = false
local noclipEnabled = false
local bubbleChatEnabled = false
local spinning = false
local walkSpeed = 16
local jumpPower = 50
local multipleJumps = false
local currentJumps = 0
local antiAfk = false

multipleJumpsButton.MouseButton1Click:Connect(function()
    multipleJumps = not multipleJumps
    currentJumps = 0
end)

noLagButton.MouseButton1Click:Connect(function()
end)

antiAfkButton.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if antiAfk then
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeed
            humanoid.JumpPower = jumpPower
        end
    end
end)

local function fly()
    if flying then
    else
    end
end

local function noclip()
    if noclipEnabled then
    else
    end
end

local function bubbleChat()
    if bubbleChatEnabled then
    else
    end
end

local function spin()
    if spinning then
    else
    end
end

game:GetService("UserInputService").JumpRequest:Connect(function()
    if multipleJumps and currentJumps < 2 then
        currentJumps = currentJumps + 1
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Physics)
    end
end)
