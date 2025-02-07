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

local Title = Instance.new("TextLabel", Frame)
Title.Text = "OH NOES"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderColor3 = Color3.fromRGB(0, 255, 0)
Title.BorderSizePixel = 2
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.FredokaOne

local InputBox = Instance.new("TextBox", Frame)
InputBox.PlaceholderText = "Enter Username"
InputBox.Size = UDim2.new(1, -20, 0, 30)
InputBox.Position = UDim2.new(0, 10, 0, 50)
InputBox.TextScaled = true
InputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputBox.BorderColor3 = Color3.fromRGB(0, 255, 0)
InputBox.BorderSizePixel = 2
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.Gotham

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

local MinimizeButton = Instance.new("TextButton", Frame)
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
MinimizeButton.BorderSizePixel = 2
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold

local MiniFrame = Instance.new("Frame", ScreenGui)
MiniFrame.Size = UDim2.new(0, 50, 0, 50)
MiniFrame.Position = UDim2.new(0.9, 0, 0.1, 0)
MiniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MiniFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MiniFrame.BorderSizePixel = 3
MiniFrame.Visible = false
MiniFrame.Active = true
MiniFrame.Draggable = true

local ExpandButton = Instance.new("TextButton", MiniFrame)
ExpandButton.Text = "J"
ExpandButton.Size = UDim2.new(1, 0, 1, 0)
ExpandButton.TextScaled = true
ExpandButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ExpandButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
ExpandButton.BorderSizePixel = 2
ExpandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExpandButton.Font = Enum.Font.GothamBold

MinimizeButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    MiniFrame.Visible = true
end)

ExpandButton.MouseButton1Click:Connect(function()
    Frame.Visible = true
    MiniFrame.Visible = false
end)

local function FindPlayer(name)
    for _, player in pairs(Players:GetPlayers()) do
        if string.lower(player.Name) == string.lower(name) then
            return player
        end
    end
    return nil
end

local function Jumpscare(target)
    if target and target.Character then
        local targetPlayer = target
        local targetCharacter = targetPlayer.Character
        local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")

        if targetHumanoid then
            targetHumanoid.CameraOffset = Vector3.new(0, 0, 0)
            targetHumanoid.WalkSpeed = 0
            Camera.CameraSubject = targetHumanoid
        end

        local ScareGui = Instance.new("ScreenGui", targetPlayer:WaitForChild("PlayerGui"))
        local ScareFrame = Instance.new("Frame", ScareGui)
        ScareFrame.Size = UDim2.new(1, 0, 1, 0)
        ScareFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

        local ScareImage = Instance.new("ImageLabel", ScareFrame)
        ScareImage.Size = UDim2.new(1, 0, 1, 0)
        ScareImage.Image = "rbxassetid://1234567890" 
        ScareImage.BackgroundTransparency = 1

        task.wait(2)
        ScareGui:Destroy()
        targetHumanoid.WalkSpeed = 16

        targetCharacter:BreakJoints()
        task.wait(1)
        targetPlayer:LoadCharacter()
    end
end

SubmitButton.MouseButton1Click:Connect(function()
    local username = InputBox.Text
    if username ~= "" then
        local TargetPlayer = FindPlayer(username)
        if TargetPlayer then
            Jumpscare(TargetPlayer)
        end
    end
end)
