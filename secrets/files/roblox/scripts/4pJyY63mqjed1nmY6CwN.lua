local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

if UserInputService.GamepadEnabled then
    return
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KickUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.6, 0, 0.4, 0)
frame.Position = UDim2.new(0.2, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0.2, 0)
textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
textBox.PlaceholderText = "Enter Username"
textBox.Parent = frame

local reasonBox = Instance.new("TextBox")
reasonBox.Size = UDim2.new(0.8, 0, 0.2, 0)
reasonBox.Position = UDim2.new(0.1, 0, 0.4, 0)
reasonBox.PlaceholderText = "Enter Reason"
reasonBox.Parent = frame

local kickButton = Instance.new("TextButton")
kickButton.Size = UDim2.new(0.8, 0, 0.2, 0)
kickButton.Position = UDim2.new(0.1, 0, 0.7, 0)
kickButton.Text = "Kick Player"
kickButton.Parent = frame

local RemoteEvent = ReplicatedStorage:FindFirstChild("KickPlayerEvent") or Instance.new("RemoteEvent")
RemoteEvent.Name = "KickPlayerEvent"
RemoteEvent.Parent = ReplicatedStorage

kickButton.MouseButton1Click:Connect(function()
    local playerName = textBox.Text
    local reason = reasonBox.Text
    if playerName ~= "" and reason ~= "" then
        RemoteEvent:FireServer(playerName, reason)
    end
end)

RemoteEvent.OnServerEvent:Connect(function(player, targetName, reason)
    local target = Players:FindFirstChild(targetName)
    if target then
        target:Kick("You have been kicked from the server. Reason: " .. reason)
    end
end)

local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
