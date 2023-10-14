local mdule = {}
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local remote = game.ReplicatedStorage.shadowB
local debounce = false

local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input,gpe)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gpe and not debounce then
debounce = true
remote:FireServer(mouse.Hit.p)
wait(.5)
debounce = false
end
end)
return mdule