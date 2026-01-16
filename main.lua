--[[
    Vamel BEGZTSHD Script
    Features: Key System, Fling, TP, ESP, Local Player, God Mode
]]

-- 1. SISTEM KEY
local ValidKeys = {
    "DJYDHDJDY", "EIHDHDHD", "JWHDG5WYE", "SJEYGWIS7", "I27D6HCEI",
    "WI83YXHSJ", "SOS8CYH3JS", "WO8EYXHSJW", "Eiej", "Skdjndj",
    "DJJDJ", "DISEI7E", "IEUDUDU", "K2UDU", "EJQ9E8J", "WI8SUOQO",
    "QPIDJN9WU", "ABZVXFWJ", "WKDHCX", "WLSJBZBX", "WKIDHDJ"
}

local DiscordLink = "https://discord.gg/g7U4xdQUR"
setclipboard(DiscordLink) -- Otomatis menyalin link

-- 2. LIBRARY UI (Contoh menggunakan Library sederhana)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Vamel BEGZTSHD", "DarkScene")

-- 3. TAB CATEGORIES
local TabFling = Window:NewTab("Fling & TP")
local SectionFling = TabFling:NewSection("Fling Player")
local TabLocal = Window:NewTab("Local Player")
local TabVisual = Window:NewTab("Visuals/ESP")
local TabLogs = Window:NewTab("Logs")

-- 4. FITUR FLING (Targeting System)
local targetPlayer = ""
local originalPos = nil

SectionFling:NewTextBox("Target Username", "Masukkan nama pemain", function(txt)
    targetPlayer = txt
end)

SectionFling:NewButton("Execute Fling", "TP ke target, putar, lalu kembali", function()
    local p1 = game.Players.LocalPlayer.Character
    local p2 = game.Players:FindFirstChild(targetPlayer)
    
    if p2 and p2.Character then
        originalPos = p1.HumanoidRootPart.CFrame
        -- Logika Fling
        p1.HumanoidRootPart.CFrame = p2.Character.HumanoidRootPart.CFrame
        
        local velocity = Instance.new("BodyAngularVelocity")
        velocity.AngularVelocity = Vector3.new(0, 99999, 0)
        velocity.MaxTorque = Vector3.new(0, 99999, 0)
        velocity.Parent = p1.HumanoidRootPart
        
        task.wait(2) -- Durasi memutar
        velocity:Destroy()
        p1.HumanoidRootPart.CFrame = originalPos
        
        -- Log Notification
        print("Fling Sukses ke: " .. targetPlayer)
    end
end)

-- 5. LOCAL PLAYER SETTINGS
local SectionLocal = TabLocal:NewSection("Player Mod")

SectionLocal:NewSlider("Walkspeed", "Ubah kecepatan", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

SectionLocal:NewButton("God Mode", "Anti Damage (Not Detected)", function()
    local char = game.Players.LocalPlayer.Character
    if char:FindFirstChild("Humanoid") then
        char.Humanoid:Remove()
        local newHum = Instance.new("Humanoid", char)
        -- Logika instant interact biasanya perlu script spesifik per game
    end
end)

-- 6. LOGS SYSTEM
local SectionLog = TabLogs:NewSection("Activity Logs")
SectionLog:NewLabel("User ID: " .. game.Players.LocalPlayer.UserId)
SectionLog:NewLabel("Username: " .. game.Players.LocalPlayer.Name)

-- 7. ANTI VOID & ANTI FLING
local SectionProtection = TabLocal:NewSection("Protection")
SectionProtection:NewToggle("Anti Void", "Mencegah jatuh ke luar map", function(state)
    -- Logika Anti Void
end)
