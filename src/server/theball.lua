local Mdule = {}
local remote = game.ReplicatedStorage.shadowB


remote.OnServerEvent:Connect(function(player,MousePusition)
local ball = game.ReplicatedStorage.shadowball:Clone()
ball.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
	ball.Parent = workspace
	ball.Massless = true
	
local force = Instance.new("BodyForce")
force.Force = Vector3.new(0, workspace.Gravity * ball:GetMass(), 0)
force.Parent = ball

ball.Velocity = CFrame.new(player.Character.HumanoidRootPart.Position, MousePusition).LookVector * 50

ball.Touched:Connect(function(hit)
if hit.Parent:FindFirstChildOfClass("Humanoid") and not hit:IsDescendantOf(player.Character) then
    hit.Parent:FindFirstChildOfClass("Humanoid"):TakeDamage(25)
			ball:Destroy()
			
		elseif hit and not hit:IsDescendantOf(player.Character) then
			ball:Destroy()
end
end)

end)
return Mdule