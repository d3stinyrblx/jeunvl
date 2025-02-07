local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JeunvlEpikUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0, 50, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner", TitleBar)
UICornerTitle.CornerRadius = UDim.new(0, 15)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "Jeunvl's Epik UI"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextScaled = true
TitleLabel.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -45, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeButton.Text = "–"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextScaled = true
MinimizeButton.Parent = TitleBar

local UICornerMinimize = Instance.new("UICorner", MinimizeButton)
UICornerMinimize.CornerRadius = UDim.new(0, 10)

local MinimizedIcon = Instance.new("TextButton")
MinimizedIcon.Size = UDim2.new(0, 50, 0, 50)
MinimizedIcon.Position = MainFrame.Position
MinimizedIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizedIcon.Text = "J"
MinimizedIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedIcon.TextScaled = true
MinimizedIcon.Parent = ScreenGui
MinimizedIcon.Visible = false
MinimizedIcon.Draggable = true
MinimizedIcon.Active = true

local UICornerIcon = Instance.new("UICorner", MinimizedIcon)
UICornerIcon.CornerRadius = UDim.new(1, 0)

local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 500), Position = MinimizedIcon.Position}):Play()
        MinimizedIcon.Visible = false
        MainFrame.Visible = true
    else
        MinimizedIcon.Position = MainFrame.Position
        MinimizedIcon.Visible = true
        MainFrame.Visible = false
    end
    isMinimized = not isMinimized
end)

MinimizedIcon.MouseButton1Click:Connect(function()
    MinimizedIcon.Visible = false
    MainFrame.Visible = true
    game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 500), Position = MinimizedIcon.Position}):Play()
    isMinimized = false
end)

local function createButton(text, parent, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Parent = parent

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 10)

    button.MouseButton1Click:Connect(callback)
    return button
end

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 50)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.Parent = MainFrame

local categories = {
    {"Movement", {"Noclip", "Infinite Jump", "User Edit", "Gravity", "Fly"}},
    {"Teleport", {"Rejoin", "Server Hop", "Join User", "Small Server", "TP"}},
    {"Chat", {"Spam", "Unspam", "BubbleChat"}},
    {"Misc", {"Anti-AFK", "No Lag"}}
}

for _, category in ipairs(categories) do
    local catLabel = Instance.new("TextLabel")
    catLabel.Size = UDim2.new(1, -10, 0, 30)
    catLabel.Position = UDim2.new(0, 5, 0, ScrollingFrame.CanvasSize.Y.Offset + 5)
    catLabel.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    catLabel.Text = category[1]
    catLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    catLabel.TextScaled = true
    catLabel.Parent = ScrollingFrame

    local corner = Instance.new("UICorner", catLabel)
    corner.CornerRadius = UDim.new(0, 10)

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.CanvasSize.Y.Offset + 35)

    for _, cmd in ipairs(category[2]) do
        local btn = createButton(cmd, ScrollingFrame, function()
            loadstring(game:HttpGet("http://api.doorwave.us.kg/epik-ui/functions/" .. cmd:lower():gsub(" ", "-") .. ".lua"))()
        end)
        btn.Position = UDim2.new(0, 5, 0, ScrollingFrame.CanvasSize.Y.Offset + 5)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.CanvasSize.Y.Offset + 45)
    end
end

if game:GetService("UserInputService").TouchEnabled then
    local dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragInput = nil
                end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput then
            update(input)
        end
    end)
end
