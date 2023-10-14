--services
local module = {}

local PLRS = game:GetService("Players")
local context = game:GetService("ContextActionService")
local UIS = game:GetService("UserInputService")
local RunS = game:GetService("RunService")
--actual variables now
local cam = workspace.CurrentCamera
local player = PLRS.LocalPlayer
local camOffset = Vector3.new(2, 2, 8)

--the main functinon (holly molly it was a nightmare/fever dream)
player.CharacterAdded:Connect(function(character)
	--variables ofc
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local camAngleX = 0
local CamAngleY = 0

	humanoid.AutoRotate = false
local function playerInput(actionName, inputState, inputObject)
 if inputState == Enum.UserInputState.Change then
camAngleX -= inputObject.Delta.X 
CamAngleY = math.clamp(CamAngleY - inputObject.Delta.Y * 0.4, -75, 75)
end
	end
	
context:BindAction("PlayerInput", playerInput, false, Enum.UserInputType.MouseMovement, Enum.UserInputType.Touch)

RunS:BindToRenderStep("CameraUpdate", Enum.RenderPriority.Camera.Value, function()
    local startCframe = CFrame.new(root.CFrame.Position) * CFrame.Angles(0, math.rad(camAngleX), 0) * CFrame.Angles(math.rad(CamAngleY), 0, 0)
    local camCframe = startCframe:PointToWorldSpace(camOffset)
    local camfocus = startCframe:PointToWorldSpace(Vector3.new(camOffset.X, camOffset.Y, -100000))

cam.CFrame = CFrame.lookAt(camCframe, camfocus)

local lookCframe = CFrame.lookAt(root.Position, cam.CFrame:PointToWorldSpace(Vector3.new(0,0,-100000)))
root.CFrame = CFrame.fromMatrix(root.Position, lookCframe.XVector, root.CFrame.YVector)
end)



end)
--locks the mouse and makes the cam scriptable 
local function focus(actionName, inputState, inputObject)
	if inputState == Enum.UserInputState.Begin then
		cam.CameraType = Enum.CameraType.Scriptable

		UIS.MouseBehavior = Enum.MouseBehavior.LockCenter

		context:UnbindAction("FocusControl")
	end
end

context:BindAction("FocusControl", focus, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch, Enum.UserInputType.Focus)
	
return module