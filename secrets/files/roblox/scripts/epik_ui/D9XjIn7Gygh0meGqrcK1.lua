local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JeunvlEpikUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local isMobile = UserInputService.TouchEnabled
local uiSize = isMobile and UDim2.new(0, 280, 0, 380) or UDim2.new(0, 340, 0, 480)

local mainFrame = Instance.new("Frame")
mainFrame.Size = uiSize
mainFrame.Position = UDim2.new(0.5, -uiSize.X.Offset / 2, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 15)

local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Jeunvl's Epik UI"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -45, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimizeButton.Text = "–"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextScaled = true
minimizeButton.Parent = titleBar

local minimizedIcon = Instance.new("TextButton")
minimizedIcon.Size = UDim2.new(0, 50, 0, 50)
minimizedIcon.Position = UDim2.new(0.05, 0, 0.9, 0) -- Bottom left
minimizedIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
minimizedIcon.Text = "J"
minimizedIcon.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizedIcon.TextScaled = true
minimizedIcon.Font = Enum.Font.GothamBold
minimizedIcon.Parent = screenGui
minimizedIcon.Visible = false
minimizedIcon.Draggable = true
minimizedIcon.Active = true

local uiCornerIcon = Instance.new("UICorner", minimizedIcon)
uiCornerIcon.CornerRadius = UDim.new(1, 0)

local uiStrokeIcon = Instance.new("UIStroke", minimizedIcon)
uiStrokeIcon.Thickness = 2
uiStrokeIcon.Color = Color3.fromRGB(255, 255, 255)

-- Smooth Animations
local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = uiSize, Position = minimizedIcon.Position}):Play()
        minimizedIcon.Visible = false
        mainFrame.Visible = true
    else
        minimizedIcon.Position = mainFrame.Position
        minimizedIcon.Visible = true
        mainFrame.Visible = false
    end
    isMinimized = not isMinimized
end)

minimizedIcon.MouseButton1Click:Connect(function()
    minimizedIcon.Visible = false
    mainFrame.Visible = true
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = uiSize, Position = minimizedIcon.Position}):Play()
    isMinimized = false
end)

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, 0, 1, -50)
scrollingFrame.Position = UDim2.new(0, 0, 0, 50)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
scrollingFrame.ScrollBarThickness = 5
scrollingFrame.Parent = mainFrame

local function createButton(text, parent, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 10)

    button.MouseButton1Click:Connect(callback)
    return button
end

local categories = {
    {"Movement", {"Noclip", "Infinite Jump", "User Edit", "Gravity", "Fly"}},
    {"Teleport", {"Rejoin", "Server Hop", "Join User", "Small Server", "TP"}},
    {"Chat", {"Spam", "Unspam", "BubbleChat"}},
    {"Misc", {"Anti-AFK", "No Lag"}}
}

for _, category in ipairs(categories) do
    local catLabel = Instance.new("TextLabel")
    catLabel.Size = UDim2.new(1, -10, 0, 30)
    catLabel.Position = UDim2.new(0, 5, 0, scrollingFrame.CanvasSize.Y.Offset + 5)
    catLabel.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    catLabel.Text = category[1]
    catLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    catLabel.TextScaled = true
    catLabel.Font = Enum.Font.GothamBold
    catLabel.Parent = scrollingFrame

    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, scrollingFrame.CanvasSize.Y.Offset + 35)

    for _, cmd in ipairs(category[2]) do
        local btn = createButton(cmd, scrollingFrame, function()
            loadstring(game:HttpGet("http://api.doorwave.us.kg/epik-ui/functions/" .. cmd:lower():gsub(" ", "-") .. ".lua"))()
        end)
        btn.Position = UDim2.new(0, 5, 0, scrollingFrame.CanvasSize.Y.Offset + 5)
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, scrollingFrame.CanvasSize.Y.Offset + 45)
    end
end
