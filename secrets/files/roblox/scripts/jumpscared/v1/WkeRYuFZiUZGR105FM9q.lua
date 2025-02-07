local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "JumpscareUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
Frame.BorderSizePixel = 3
Frame.Active = true
Frame.Draggable = true
local Corner = Instance.new("UICorner", Frame)
Corner.CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "OH NOES"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderColor3 = Color3.fromRGB(0, 255, 0)
Title.BorderSizePixel = 2
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.FredokaOne
local CornerTitle = Instance.new("UICorner", Title)
CornerTitle.CornerRadius = UDim.new(0, 16)

local InputBox = Instance.new("TextBox", Frame)
InputBox.Name = "tank u"
InputBox.PlaceholderText = "Enter Username"
InputBox.Size = UDim2.new(1, -20, 0, 30)
InputBox.Position = UDim2.new(0, 10, 0, 50)
InputBox.TextScaled = true
InputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputBox.BorderColor3 = Color3.fromRGB(0, 255, 0)
InputBox.BorderSizePixel = 2
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.Gotham
local CornerInput = Instance.new("UICorner", InputBox)
CornerInput.CornerRadius = UDim.new(0, 8)

local SubmitButton = Instance.new("TextButton", Frame)
SubmitButton.Text = "Submit"
SubmitButton.Size = UDim2.new(1, -20, 0, 40)
SubmitButton.Position = UDim2.new(0, 10, 0, 90)
SubmitButton.TextScaled = true
SubmitButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SubmitButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
SubmitButton.BorderSizePixel = 2
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Font = Enum.Font.GothamBold
local CornerSubmit = Instance.new("UICorner", SubmitButton)
CornerSubmit.CornerRadius = UDim.new(0, 8)

local Footer = Instance.new("TextLabel", Frame)
Footer.Text = "Get jumpscared by: Jeunvl"
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.TextScaled = true
Footer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Footer.BorderColor3 = Color3.fromRGB(0, 255, 0)
Footer.BorderSizePixel = 2
Footer.TextColor3 = Color3.fromRGB(200, 200, 200)
Footer.Font = Enum.Font.Gotham
local CornerFooter = Instance.new("UICorner", Footer)
CornerFooter.CornerRadius = UDim.new(0, 8)

local MinimizeButton = Instance.new("TextButton", Frame)
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
MinimizeButton.BorderSizePixel = 2
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
local CornerMinimize = Instance.new("UICorner", MinimizeButton)
CornerMinimize.CornerRadius = UDim.new(0, 8)

local MiniFrame = Instance.new("Frame", ScreenGui)
MiniFrame.Size = UDim2.new(0, 50, 0, 50)
MiniFrame.Position = UDim2.new(0.9, 0, 0.1, 0)
MiniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MiniFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MiniFrame.BorderSizePixel = 3
MiniFrame.Visible = false
MiniFrame.Active = true
MiniFrame.Draggable = true
local CornerMiniFrame = Instance.new("UICorner", MiniFrame)
CornerMiniFrame.CornerRadius = UDim.new(0, 8)

local ExpandButton = Instance.new("TextButton", MiniFrame)
ExpandButton.Text = "+"
ExpandButton.Size = UDim2.new(0, 30, 0, 30)
ExpandButton.Position = UDim2.new(0.5, -15, 0, 5)
ExpandButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ExpandButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
ExpandButton.BorderSizePixel = 2
ExpandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExpandButton.Font = Enum.Font.GothamBold
local CornerExpand = Instance.new("UICorner", ExpandButton)
CornerExpand.CornerRadius = UDim.new(0, 8)

local JumpscareImage = Instance.new("ImageLabel", ScreenGui)
JumpscareImage.Size = UDim2.new(1, 0, 1, 0)
JumpscareImage.Position = UDim2.new(0, 0, 0, 0)
JumpscareImage.BackgroundTransparency = 1
JumpscareImage.Image = "rbxassetid://7255938910" -- Replace with the jumpscare image asset ID
JumpscareImage.Visible = false

SubmitButton.MouseButton1Click:Connect(function()
	local userName = InputBox.Text
	local targetPlayer = Players:FindFirstChild(userName)
	if targetPlayer then
		JumpscareImage.Visible = true
		wait(2)
		JumpscareImage.Visible = false
		targetPlayer.Character:BreakJoints() -- Makes the target die
		LocalPlayer.Character:BreakJoints() -- Makes you die
		wait(2)
		-- respawn both players
		LocalPlayer:LoadCharacter()
		targetPlayer:LoadCharacter()
	end
end)

MinimizeButton.MouseButton1Click:Connect(function()
	Frame.Visible = false
	MiniFrame.Visible = true
end)

ExpandButton.MouseButton1Click:Connect(function()
	Frame.Visible = true
	MiniFrame.Visible = false
end)
