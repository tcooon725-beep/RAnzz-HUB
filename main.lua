local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. WINDOW SETUP
local Window = Rayfield:CreateWindow({
   Name = "Vamel BEGZTSHD | Premium",
   LoadingTitle = "Vamel Script Hub",
   LoadingSubtitle = "by Vamel",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "VamelConfigs",
      FileName = "VamelHub"
   },
   Discord = {
      Enabled = true,
      Invite = "g7U4xdQUR",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Vamel Key System",
      Subtitle = "Join Discord for Key",
      Note = "Link Discord otomatis disalin!",
      FileName = "VamelKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"DJYDHDJDY", "EIHDHDHD", "JWHDG5WYE", "SJEYGWIS7", "I27D6HCEI", "WI83YXHSJ", "SOS8CYH3JS", "WO8EYXHSJW", "Eiej", "Skdjndj", "DJJDJ", "DISEI7E", "IEUDUDU", "K2UDU", "EJQ9E8J", "WI8SUOQO", "QPIDJN9WU", "ABZVXFWJ", "WKDHCX", "WLSJBZBX", "WKIDHDJ"} 
   }
})

-- Auto Copy Discord
setclipboard("https://discord.gg/g7U4xdQUR")

-- 2. TABS
local TabFling = Window:CreateTab("Fling & TP", "zap") 
local TabLocal = Window:CreateTab("Local Player", "user")
local TabVisual = Window:CreateTab("Visuals/ESP", "eye")
local TabLogs = Window:CreateTab("Logs", "file-text")

-- 3. FLING SECTION (Improved)
local targetPlayer = ""

TabFling:CreateInput({
   Name = "Target Username",
   PlaceholderText = "Nama Player (Bisa singkat)",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      targetPlayer = Text
   end,
})

TabFling:CreateButton({
   Name = "Execute Advanced Fling",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local target = nil
      
      -- Pencarian player yang lebih cerdas
      for _, v in pairs(game.Players:GetPlayers()) do
         if v.Name:lower():sub(1, #targetPlayer) == targetPlayer:lower() or v.DisplayName:lower():sub(1, #targetPlayer) == targetPlayer:lower() then
            target = v
            break
         end
      end

      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         local char = lp.Character
         local oldPos = char.HumanoidRootPart.CFrame
         
         Rayfield:Notify({Title = "Flinging", Content = "Menyerang: " .. target.Name, Duration = 3})

         -- Anti-Die saat Fling
         local bodyVel = Instance.new("BodyAngularVelocity")
         bodyVel.AngularVelocity = Vector3.new(0, 99999, 0)
         bodyVel.MaxTorque = Vector3.new(0, 99999, 0)
         bodyVel.Parent = char.HumanoidRootPart
         
         -- Teleport & Rotate Logic
         local t = tick()
         while tick() - t < 2 do -- Durasi fling 2 detik
            task.wait()
            if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(tick()*5000), 0)
            end
         end
         
         bodyVel:Destroy()
         char.HumanoidRootPart.CFrame = oldPos
      else
         Rayfield:Notify({Title = "Error", Content = "Player tidak ditemukan!", Duration = 3})
      end
   end,
})

-- 4. LOCAL PLAYER SECTION
TabLocal:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

TabLocal:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

TabLocal:CreateButton({
   Name = "God Mode (Simple)",
   Callback = function()
      -- Mode ini membuat kamu tidak bisa mati di beberapa game, tapi hati-hati bisa merusak kontrol
      local player = game.Players.LocalPlayer
      if player.Character then
          local hum = player.Character:FindFirstChildOfClass("Humanoid")
          if hum then
              hum.MaxHealth = math.huge
              hum.Health = math.huge
          end
      end
      Rayfield:Notify({Title = "God Mode", Content = "Health diatur ke Infinity!", Duration = 2})
   end,
})

-- 5. PROTECTION & UTILITY
TabLocal:CreateSection("Utility")

TabLocal:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = true,
   Callback = function(Value)
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
         if Value then
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         end
      end)
   end,
})

-- 6. LOGS
TabLogs:CreateLabel("User ID: " .. game.Players.LocalPlayer.UserId)
TabLogs:CreateLabel("Account Age: " .. game.Players.LocalPlayer.AccountAge .. " days")
TabLogs:CreateButton({
   Name = "Destroy UI",
   Callback = function()
      Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "Success!",
   Content = "Script berhasil dimuat.",
   Duration = 5
})
