local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 200, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Kicker UI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24
title.BackgroundTransparency = 1
title.TextStrokeTransparency = 0.5
title.Font = Enum.Font.SourceSansBold
title.TextAlign = Enum.TextAlign.Center

local playerList = Instance.new("TextBox")
playerList.Parent = frame
playerList.Size = UDim2.new(1, -20, 0.3, 0)
playerList.Position = UDim2.new(0, 10, 0.2, 0)
playerList.PlaceholderText = "Enter username"
playerList.TextColor3 = Color3.fromRGB(0, 0, 0)
playerList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
playerList.BorderSizePixel = 2
playerList.BorderColor3 = Color3.fromRGB(0, 200, 0)
playerList.Font = Enum.Font.SourceSans
playerList.TextSize = 18

local kickButton = Instance.new("TextButton")
kickButton.Parent = frame
kickButton.Size = UDim2.new(1, -20, 0.3, 0)
kickButton.Position = UDim2.new(0, 10, 0.6, 0)
kickButton.Text = "Kick Player"
kickButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
kickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
kickButton.TextSize = 20
kickButton.Font = Enum.Font.SourceSansBold
kickButton.BorderSizePixel = 2
kickButton.BorderColor3 = Color3.fromRGB(0, 200, 0)
kickButton.TextStrokeTransparency = 0.5

local footer = Instance.new("TextLabel")
footer.Parent = frame
footer.Size = UDim2.new(1, 0, 0.2, 0)
footer.Position = UDim2.new(0, 0, 0.8, 0)
footer.Text = "Created By: Jeunvl <3"
footer.TextColor3 = Color3.fromRGB(255, 255, 255)
footer.TextSize = 14
footer.BackgroundTransparency = 1
footer.TextStrokeTransparency = 0.5
footer.Font = Enum.Font.SourceSans
footer.TextAlign = Enum.TextAlign.Center

local function kickPlayer()
    local playerName = playerList.Text
    if playerName ~= "" then
        local playerToKick = game.Players:FindFirstChild(playerName)
        if playerToKick then
            if playerToKick.UserId ~= game.Players.LocalPlayer.UserId then
                playerToKick:Kick("You have been kicked from the game.")
            else
                print("You cannot kick yourself!")
                playerList.Text = ""
            end
        else
            print("Player not found.")
        end
    end
end

kickButton.MouseButton1Click:Connect(function()
    kickPlayer()
end)

frame:TweenSize(UDim2.new(0, 300, 0, 250), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
