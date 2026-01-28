-- FishIt Main Loader - Delta Executor Compatible
if not game:IsLoaded() then game.Loaded:Wait() end

local FishIt = {
    Version = "2.1",
    GameName = "Fishing Simulator / Fish It Variant",
    Modules = {}
}

-- Load utility functions
function FishIt:LoadModule(ModuleScript)
    local success, err = pcall(function()
        local module = require(ModuleScript)
        self.Modules[ModuleScript.Name] = module
        module:Init(self)
    end)
    if not success then
        warn("[FishIt] Module Load Error:", ModuleScript.Name, err)
    end
end

-- Auto-inject
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/your_repo/FishIt_AutoFarm.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/your_repo/FishIt_Teleports.lua"))()
    
    -- UI Injection (Optional)
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
    local Window = Library:CreateWindow("FishIt Delta")
    
    local FarmingTab = Window:AddTab("Auto Farm")
    FarmingTab:AddToggle("AutoFish", {Text = "Auto Fish", Default = false}):OnChanged(function(value)
        FishIt.Modules.AutoFarm.ToggleFishing(value)
    end)
    
    FarmingTab:AddToggle("SellFish", {Text = "Auto Sell", Default = false}):OnChanged(function(value)
        FishIt.Modules.AutoFarm.ToggleSelling(value)
    end)
    
    Library:Notify("FishIt Loaded - Delta Executor")
end)

return FishIt