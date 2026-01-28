-- Auto Farm Module
local module = {}
local RunService = game:GetService("RunService")

function module:Init(Main)
    self.Main = Main
    self.Fishing = false
    self.Selling = false
    self.Connection = nil
    
    -- Locate fishing points (adaptasi diperlukan berdasarkan game)
    self.FishingPoints = workspace:FindFirstChild("FishingSpots") or workspace:FindFirstChild("FishAreas")
end

function module:ToggleFishing(State)
    self.Fishing = State
    if self.Connection then self.Connection:Disconnect() end
    
    if State then
        self.Connection = RunService.Heartbeat:Connect(function()
            -- Simulasi: tekan tombol fish
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
            task.wait(0.5)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
            
            -- Tunggu animasi/timer
            task.wait(math.random(3, 7))
            
            -- Reel in
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
            task.wait(0.2)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
        end)
    end
end

function module:ToggleSelling(State)
    self.Selling = State
    if State then
        spawn(function()
            while self.Selling do
                -- Cari NPC penjual
                local SellNPC = workspace:FindFirstChild("SellNPC") or workspace:FindFirstChild("Merchant")
                if SellNPC then
                    game.Players.LocalPlayer.Character:MoveTo(SellNPC.PrimaryPart.Position)
                    task.wait(1)
                    fireproximityprompt(SellNPC:FindFirstChildOfClass("ProximityPrompt"), 0)
                end
                task.wait(5)
            end
        end)
    end
end

return module