local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.Name = "FlyingUI"
screenGui.ResetOnSpawn = false

local uiFrame = Instance.new("Frame")
uiFrame.Parent = screenGui
uiFrame.Size = UDim2.new(0, 300, 0, 200)
uiFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
uiFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
uiFrame.BorderSizePixel = 0
uiFrame.ZIndex = 10
uiFrame.ClipsDescendants = true
uiFrame.BackgroundTransparency = 0.2

local corner = Instance.new("UICorner")
corner.Parent = uiFrame
corner.CornerRadius = UDim.new(0, 15)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = uiFrame
minimizeButton.Size = UDim2.new(0, 50, 0, 50)
minimizeButton.Position = UDim2.new(1, -60, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "F"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 24
minimizeButton.Font = Enum.Font.SourceSans
minimizeButton.AutoButtonColor = false

local corner2 = Instance.new("UICorner")
corner2.Parent = minimizeButton
corner2.CornerRadius = UDim.new(0, 25)

local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
	if isMinimized then
		uiFrame:TweenSize(UDim2.new(0, 300, 0, 200), "Out", "Quad", 0.5, true)
		minimizeButton.Text = "F"
	else
		uiFrame:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Quad", 0.5, true)
		minimizeButton.Text = ""
	end
	isMinimized = not isMinimized
end)

local notificationFrame = Instance.new("Frame")
notificationFrame.Parent = screenGui
notificationFrame.Size = UDim2.new(0, 300, 0, 50)
notificationFrame.Position = UDim2.new(0.5, -150, 0, 20)
notificationFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
notificationFrame.BorderSizePixel = 0
notificationFrame.BackgroundTransparency = 0.3
notificationFrame.ZIndex = 11

local corner3 = Instance.new("UICorner")
corner3.Parent = notificationFrame
corner3.CornerRadius = UDim.new(0, 10)

local notificationLabel = Instance.new("TextLabel")
notificationLabel.Parent = notificationFrame
notificationLabel.Size = UDim2.new(1, 0, 1, 0)
notificationLabel.Position = UDim2.new(0, 0, 0, 0)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Text = "Jeunvl's Fly has been enabled"
notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
notificationLabel.TextSize = 20
notificationLabel.Font = Enum.Font.SourceSans

TweenService:Create(notificationFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
wait(3)
notificationFrame:Destroy()

local flying = false
local flightSpeed = 50
local flyHeight = 20

local bodyGyro, bodyVelocity

local function enableFly()
	if not flying then
		flying = true

		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
		bodyGyro.CFrame = player.Character.HumanoidRootPart.CFrame
		bodyGyro.Parent = player.Character.HumanoidRootPart

		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
		bodyVelocity.Velocity = Vector3.new(0, flightSpeed, 0)
		bodyVelocity.Parent = player.Character.HumanoidRootPart

		local notification = Instance.new("Frame")
		notification.Size = UDim2.new(0, 300, 0, 50)
		notification.Position = UDim2.new(0.5, -150, 0, 20)
		notification.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		notification.BackgroundTransparency = 0.3
		notification.ZIndex = 11
		local corner3 = Instance.new("UICorner")
		corner3.Parent = notification
		corner3.CornerRadius = UDim.new(0, 10)
		local notificationLabel = Instance.new("TextLabel")
		notificationLabel.Parent = notification
		notificationLabel.Size = UDim2.new(1, 0, 1, 0)
		notificationLabel.BackgroundTransparency = 1
		notificationLabel.Text = "Jeunvl's Fly has been enabled"
		notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		notificationLabel.TextSize = 20
		notificationLabel.Font = Enum.Font.SourceSans
		notification.Parent = screenGui

		TweenService:Create(notification, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
		wait(3)
		notification:Destroy()
	end
end

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F then
		enableFly()
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local humanoidRootPart = player.Character.HumanoidRootPart
		humanoidRootPart.Velocity = Vector3.new(0, flightSpeed, 0)
	end
end)
