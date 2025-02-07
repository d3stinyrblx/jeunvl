local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local function giveSword(player)
    local sword = game:GetService("InsertService"):LoadAsset(422024417):FindFirstChildOfClass("Tool")

    if sword then
        sword.Parent = player.Backpack

        local function onHit(otherPart)
            local character = otherPart.Parent
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                humanoid.Health = 0
            end
        end

        sword.Handle.Touched:Connect(onHit)
    end
end

ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageReceived.OnServerEvent:Connect(function(player, message)
    if message:lower() == "i had the power" then
        giveSword(player)
        StarterGui:SetCore("SendNotification", {
            Title = "Sword Given";
            Text = "You have received the power!";
            Duration = 3;
        })
    end
end)
