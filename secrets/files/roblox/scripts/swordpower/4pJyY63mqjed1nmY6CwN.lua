local player = game.Players.LocalPlayer
local gearID = 121946387

local function giveGear()
    local tool = game:GetService("InsertService"):LoadAsset(gearID):GetChildren()[1]
    if tool then
        tool.Parent = player.Backpack
    end
end

giveGear()
