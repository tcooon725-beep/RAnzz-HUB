local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. WINDOW SETUP
local Window = Rayfield:CreateWindow({
   Name = "Vamel Premium | Ultimate Hub",
   LoadingTitle = "Vamel Script Hub",
   LoadingSubtitle = "by Vamel",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "VamelConfigs",
      FileName = "VamelHub"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Vamel Key System",
      Subtitle = "Join Discord for Key",
      Note = "Key: VAMEL_ON_TOP", -- Contoh Key Sekali Pakai/Sederhana
      FileName = "VamelKey",
      SaveKey = false, -- Diatur false agar user harus input lagi jika ingin 'sekali pakai'
      GrabKeyFromSite = false,
      Key = {"VAMEL_ON_TOP"} 
   }
})

-- 2. TABS
local TabFling = Window:CreateTab("Fling & Kill", "zap") 
local TabVisual = Window:CreateTab("Visuals/ESP", "eye")
local TabLocal = Window:CreateTab("Player Settings", "user")

-- 3. ADVANCED FLING (Working Version)
local targetPlayer = ""

TabFling:CreateInput({
   Name = "Target Username",
   PlaceholderText = "Nama Player...",
   Callback = function(Text)
      targetPlayer = Text
   end,
})

TabFling:CreateButton({
   Name = "Execute Power Fling",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local target = nil
      
      for _, v in pairs(game.Players:GetPlayers()) do
         if v.Name:lower():sub(1, #targetPlayer) == targetPlayer:lower() or v.DisplayName:lower():sub(1, #targetPlayer) == targetPlayer:lower() then
            target = v
            break
         end
      end

      if target and target.Character and lp.Character then
         local root = lp.Character:FindFirstChild("HumanoidRootPart")
         local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
         
         if root and targetRoot then
            local oldPos = root.CFrame
            Rayfield:Notify({Title = "Flinging", Content = "Menghancurkan: " .. target.Name, Duration = 3})

            -- Fling Logic (Spin + High Velocity)
            local bV = Instance.new("BodyVelocity")
            bV.Velocity = Vector3.new(500, 500, 500) -- Membuat getaran kuat
            bV.Parent = root
            
            local bAV = Instance.new("BodyAngularVelocity")
            bAV.AngularVelocity = Vector3.new(0, 99999, 0)
            bAV.MaxTorque = Vector3.new(0, 99999, 0)
            bAV.Parent = root
            
            local t = tick()
            while tick() - t < 1.5 do -- Durasi singkat agar tidak ikut mati
               task.wait()
               root.CFrame = targetRoot.CFrame * CFrame.new(math.random(-1,1), 0, math.random(-1,1))
            end
            
            bV:Destroy()
            bAV:Destroy()
            root.CFrame = oldPos
            root.Velocity = Vector3.new(0,0,0)
         end
      else
         Rayfield:Notify({Title = "Error", Content = "Target tidak ditemukan!", Duration = 3})
      end
   end,
})

-- 4. ESP VISUALS
TabVisual:CreateToggle({
   Name = "Enable ESP Box",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      while _G.ESP do
         task.wait(0.1)
         for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
               if not plr.Character:FindFirstChild("Highlight") then
                  local highlight = Instance.new("Highlight")
                  highlight.Name = "Highlight"
                  highlight.Parent = plr.Character
                  highlight.FillTransparency = 0.5
                  highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
               end
            end
         end
         if not _G.ESP then
            for _, plr in pairs(game.Players:GetPlayers()) do
               if plr.Character and plr.Character:FindFirstChild("Highlight") then
                  plr.Character.Highlight:Destroy()
               end
            end
         end
      end
   end,
})

-- 5. GOD MODE & LOCAL PLAYER
TabLocal:CreateButton({
   Name = "God Mode (Anti-Die)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character
      if character and character:FindFirstChild("Humanoid") then
         -- Teknik menghapus humanoid untuk memutus script damage game
         local cam = workspace.CurrentCamera
         local oldCF = character.PrimaryPart.CFrame
         local newHum = character.Humanoid:Clone()
         character.Humanoid:Destroy()
         newHum.Parent = character
         player.Character = nil
         player.Character = character
         workspace.CurrentCamera.CameraSubject = character.Humanoid
         Rayfield:Notify({Title = "God Mode", Content = "Aktif! Kamu sekarang kebal damage.", Duration = 4})
      end
   end,
})

TabLocal:CreateSlider({
   Name = "Speed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

Rayfield:Notify({Title = "Vamel Hub Loaded", Content = "Gunakan secara bijak!", Duration = 5})
