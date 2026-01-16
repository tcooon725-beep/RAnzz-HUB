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
      Subtitle = "Enter your license key",
      Note = "Check Discord for the latest keys!",
      FileName = "VamelKey",
      SaveKey = true, 
      GrabKeyFromSite = false,
      -- Added your provided keys here
      Key = {
         "BEGZTSHD", "DJYDHDJDY", "EIHDHDHD", "JWHDG5WYE", "SJEYGWIS7", 
         "I27D6HCEI", "WI83YXHSJ", "SOS8CYH3JS", "WO8EYXHSJW", "Eiej", 
         "Skdjndj", "DJJDJ", "DISEI7E", "IEUDUDU", "K2UDU", "EJQ9E8J", 
         "WI8SUOQO", "QPIDJN9WU", "ABZVXFWJ", "WKDHCX", "WLSJBZBX", "WKIDHDJ"
      } 
   }
})

-- 2. TABS
local TabFling = Window:CreateTab("Fling & Kill", "zap") 
local TabVisual = Window:CreateTab("Visuals/ESP", "eye")
local TabLocal = Window:CreateTab("Player Settings", "user")

---

-- 3. ADVANCED FLING
local targetPlayer = ""

TabFling:CreateInput({
   Name = "Target Username",
   PlaceholderText = "Enter name...",
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
            Rayfield:Notify({Title = "Flinging", Content = "Targeting: " .. target.Name, Duration = 3})

            local bV = Instance.new("BodyVelocity")
            bV.Velocity = Vector3.new(500, 500, 500)
            bV.Parent = root
            
            local bAV = Instance.new("BodyAngularVelocity")
            bAV.AngularVelocity = Vector3.new(0, 99999, 0)
            bAV.MaxTorque = Vector3.new(0, 99999, 0)
            bAV.Parent = root
            
            local t = tick()
            while tick() - t < 1.5 do 
               task.wait()
               root.CFrame = targetRoot.CFrame * CFrame.new(math.random(-1,1), 0, math.random(-1,1))
            end
            
            bV:Destroy()
            bAV:Destroy()
            root.CFrame = oldPos
            root.Velocity = Vector3.new(0,0,0)
         end
      else
         Rayfield:Notify({Title = "Error", Content = "Target not found!", Duration = 3})
      end
   end,
})

-- 4. ESP VISUALS (Optimized)
TabVisual:CreateToggle({
   Name = "Enable ESP Box",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      if _G.ESP then
         task.spawn(function()
            while _G.ESP do
               for _, plr in pairs(game.Players:GetPlayers()) do
                  if plr ~= game.Players.LocalPlayer and plr.Character then
                     if not plr.Character:FindFirstChild("Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "Highlight"
                        highlight.Parent = plr.Character
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
         for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Highlight") then
               plr.Character.Highlight:Destroy()
            end
         end
      end
   end,
})

-- 5. LOCAL PLAYER
TabLocal:CreateButton({
   Name = "God Mode",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
         Rayfield:Notify({Title = "God Mode", Content = "Attempted God Mode activation.", Duration = 4})
      end
   end,
})

TabLocal:CreateSlider({
   Name = "Speed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

Rayfield:Notify({Title = "Vamel Hub Loaded", Content = "Ready to use!", Duration = 5})
