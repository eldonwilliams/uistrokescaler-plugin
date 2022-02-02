-- Note for GitHub release, this script should be disabled! It will get enabled once inserted.

local CollectionService = game:GetService('CollectionService')

local STUDIO_SCREEN_SIZE = require(script:WaitForChild("Normalize"))  -- change 0, 0 to your studio resolution
local camera = workspace.CurrentCamera
local instanceAddedSignal = nil  -- stores a connection


local function GetAverage(vector: Vector2): number
	return (vector.X + vector.Y) / 2
end


local studioAverage = GetAverage(STUDIO_SCREEN_SIZE)
local currentScreenAverage = GetAverage(camera.ViewportSize)


local function AdjustThickness(ui: UIStroke)
	if (not ui:GetAttribute("origThickness")) then
		ui:SetAttribute("origThickness", ui.Thickness)
	end
	local ratio = ui:GetAttribute("origThickness") / studioAverage
	ui.Thickness = currentScreenAverage * ratio
end


local function ModifyUiStrokes()
	currentScreenAverage = GetAverage(camera.ViewportSize)  -- re-calculate the screen average as it could've changed

	for _, ui: UIStroke in ipairs(CollectionService:GetTagged('UIStroke')) do
		AdjustThickness(ui)
	end

	if instanceAddedSignal then
		instanceAddedSignal:Disconnect()
	end
	instanceAddedSignal = CollectionService:GetInstanceAddedSignal('UIStroke'):Connect(AdjustThickness)
end

for _, stroke: UIStroke in ipairs(CollectionService:GetTagged('UIStroke')) do
	stroke:SetAttribute("origThickness", stroke.Thickness)
end

ModifyUiStrokes()
camera:GetPropertyChangedSignal('ViewportSize'):Connect(ModifyUiStrokes)