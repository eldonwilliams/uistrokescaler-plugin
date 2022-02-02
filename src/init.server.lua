local CollectionService: CollectionService = game:GetService("CollectionService")

-- Config
local runnerScript: LocalScript = script:FindFirstChild("Runner")
local insertLocation: Instance = game:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts")
--

local toolbar: PluginToolbar = plugin:CreateToolbar("UI Stroke Scaler")

local tagUIStrokes: PluginToolbarButton = toolbar:CreateButton("addTags", "Adds the 'UIStroke' tag to all UIStroke objects in your game.", "rbxthumb://type=Asset&id=413362821&w=150&h=150", "Add Tags")
tagUIStrokes.ClickableWhenViewportHidden = true
local insertScript: PluginToolbarButton = toolbar:CreateButton("insertRunner", "Adds the script that makes this plugin function, or replaces it.", "rbxthumb://type=Asset&id=5428180457&w=150&h=150", "Add Runner Script")
insertScript.ClickableWhenViewportHidden = true
local setNormalize: PluginToolbarButton = toolbar:CreateButton("setNormalize", "Automatically sets the normalize viewport size to the current viewport size.", "rbxthumb://type=Asset&id=64940935&w=150&h=150", "Auto Normalize")
setNormalize.ClickableWhenViewportHidden = false
local editNormalize: PluginToolbarButton = toolbar:CreateButton("editNormalize", "Allows you to manually edit the modulescript that says what size UI was designed with.", "rbxthumb://type=Asset&id=5016313067&w=150&h=150", "Edit Normalize")
editNormalize.ClickableWhenViewportHidden = true

tagUIStrokes.Click:Connect(function()
	tagUIStrokes:SetActive(false)
	local added: number = 0
	for _, uistroke in ipairs(game:GetDescendants()) do
		if (not uistroke:IsA("UIStroke")) then
			continue
		end
		
		added += 1
		CollectionService:AddTag(uistroke, 'UIStroke')
	end
	print("Added the tag 'UIStroke' to", added, "objects.")
end)

local function getNormalizeModule(): ModuleScript
	if (script:FindFirstChild("Normalize")) then
		return script:FindFirstChild("Normalize")
	end

	local moduleScript: ModuleScript = Instance.new("ModuleScript", script)
	moduleScript.Name = "Normalize"
	moduleScript.Source = string.format("return Vector3.new(%s, %s)", workspace.CurrentCamera.ViewportSize.X, workspace.CurrentCamera.ViewportSize.Y)
	return moduleScript
end

insertScript.Click:Connect(function()
	insertScript:SetActive(false)
	if (insertLocation:FindFirstChild(runnerScript.Name)) then
		insertLocation:FindFirstChild(runnerScript.Name):Destroy()
		print("Removed old script")
	end
	local clonedRunner: LocalScript = runnerScript:Clone()
	clonedRunner.Parent = insertLocation
	local clonedNormalizeModule: ModuleScript = getNormalizeModule():Clone()
	clonedNormalizeModule.Parent = clonedRunner
	clonedRunner.Disabled = false
	print("Added runner script")
end)

setNormalize.Click:Connect(function()
	setNormalize:SetActive(false)
	getNormalizeModule().Source = string.format("return Vector3.new(%s, %s)", workspace.CurrentCamera.ViewportSize.X, workspace.CurrentCamera.ViewportSize.Y)
end)

editNormalize.Click:Connect(function()
	editNormalize:SetActive(false)
	plugin:OpenScript(getNormalizeModule())
end)