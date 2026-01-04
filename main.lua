--// RAnzz Prison Life Ultimate GUI
--// By RAnzzHub

if game.CoreGui:FindFirstChild("RANZZ_GUI") then
    game.CoreGui.RANZZ_GUI:Destroy()
end

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ANTI KICK
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
    local method = getnamecallmethod()
    if method == "Kick" then
        return
    end
    return old(self,...)
end)

-- GUI
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "RANZZ_GUI"
Gui.ResetOnSpawn = false

-- LOGO BUTTON
local Logo = Instance.new("TextButton", Gui)
Logo.Size = UDim2.new(0,50,0,50)
Logo.Position = UDim2.new(0,50,0,200)
Logo.Text = "R"
Logo.TextScaled = true
Logo.BackgroundColor3 = Color3.fromRGB(255,0,0)
Logo.TextColor3 = Color3.new(1,1,1)
Logo.Active = true
Logo.Draggable = true
Logo.Font = Enum.Font.GothamBlack
Instance.new("UICorner",Logo).CornerRadius = UDim.new(1,0)

-- MAIN FRAME
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,520,0,360)
Main.Position = UDim2.new(0.5,-260,0.5,-180)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)

-- TOP BAR
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,40)
Top.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner",Top).CornerRadius = UDim.new(0,14)

local Min = Instance.new("TextButton", Top)
Min.Size = UDim2.new(0,40,0,40)
Min.Position = UDim2.new(1,-45,0,0)
Min.Text = "-"
Min.TextScaled = true
Min.BackgroundTransparency = 1
Min.TextColor3 = Color3.new(1,1,1)

-- SIDEBAR
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0,120,1,-40)
Side.Position = UDim2.new(0,0,0,40)
Side.BackgroundColor3 = Color3.fromRGB(25,25,25)

local function TabButton(text,pos)
    local b = Instance.new("TextButton",Side)
    b.Size = UDim2.new(1,0,0,40)
    b.Position = UDim2.new(0,0,0,pos)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    return b
end

local HomeBtn = TabButton("HOME",0)
local MainBtn = TabButton("MAIN",45)
local TpBtn   = TabButton("TP",90)

-- PAGES
local Pages = Instance.new("Folder",Main)

local function Page()
    local f = Instance.new("Frame",Pages)
    f.Size = UDim2.new(1,-120,1,-40)
    f.Position = UDim2.new(0,120,0,40)
    f.Visible = false
    f.BackgroundTransparency = 1
    return f
end

local Home = Page()
local MainP = Page()
local Tp = Page()
Home.Visible = true

-- HOME CONTENT
local Ava = Instance.new("ImageLabel",Home)
Ava.Size = UDim2.new(0,100,0,100)
Ava.Position = UDim2.new(0,30,0,20)
Ava.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420)
Instance.new("UICorner",Ava)

local Info = Instance.new("TextLabel",Home)
Info.Position = UDim2.new(0,30,0,130)
Info.Size = UDim2.new(1,-60,0,80)
Info.Text = "Username: "..LocalPlayer.Name.."\nUserId: "..LocalPlayer.UserId
Info.TextColor3 = Color3.new(1,1,1)
Info.BackgroundTransparency = 1
Info.TextXAlignment = Left
Info.TextYAlignment = Top

local By = Instance.new("TextLabel",Home)
By.Position = UDim2.new(0,30,1,-40)
By.Size = UDim2.new(1,-60,0,30)
By.Text = "By RAnzz"
By.TextColor3 = Color3.fromRGB(255,0,0)
By.BackgroundTransparency = 1
By.Font = Enum.Font.GothamBlack

-- ESP / AIM SYSTEM
local ESP = false
local Aim = false
local Aimlock = false
local FOV = 120
local LockRadius = 500

-- FOV CIRCLE
local Circle = Drawing.new("Circle")
Circle.Thickness = 2
Circle.NumSides = 100
Circle.Color = Color3.fromRGB(255,0,0)
Circle.Radius = FOV
Circle.Visible = false

RunService.RenderStepped:Connect(function()
    Circle.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
end)

-- ESP FUNCTION
local function ApplyESP(plr)
    if plr == LocalPlayer then return end
    local function Char(c)
        if c:FindFirstChild("Head") then
            local bill = Instance.new("BillboardGui",c.Head)
            bill.Size = UDim2.new(0,200,0,60)
            bill.AlwaysOnTop = true
            bill.Name = "RANZZ_ESP"

            local name = Instance.new("TextLabel",bill)
            name.Size = UDim2.new(1,0,0,20)
            name.Text = plr.Name
            name.BackgroundTransparency = 1
            name.TextColor3 = Color3.new(1,0,0)

            local bar = Instance.new("Frame",bill)
            bar.Position = UDim2.new(0,0,0,25)
            bar.Size = UDim2.new(1,0,0,10)
            bar.BackgroundColor3 = Color3.fromRGB(80,0,0)

            local fill = Instance.new("Frame",bar)
            fill.BackgroundColor3 = Color3.fromRGB(255,0,0)
            fill.Size = UDim2.new(1,0,1,0)

            RunService.RenderStepped:Connect(function()
                if c:FindFirstChild("Humanoid") then
                    fill.Size = UDim2.new(c.Humanoid.Health/c.Humanoid.MaxHealth,0,1,0)
                end
            end)
        end
    end
    if plr.Character then Char(plr.Character) end
    plr.CharacterAdded:Connect(Char)
end

-- AUTO ESP
Players.PlayerAdded:Connect(ApplyESP)
for _,p in pairs(Players:GetPlayers()) do ApplyESP(p) end

-- BUTTON MAIN
local function ToggleBtn(parent,text,y,callback)
    local b = Instance.new("TextButton",parent)
    b.Size = UDim2.new(0,200,0,40)
    b.Position = UDim2.new(0,20,0,y)
    b.Text = text.." : OFF"
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(function()
        callback(b)
    end)
end

ToggleBtn(MainP,"ESP",20,function(b)
    ESP = not ESP
    b.Text = "ESP : "..(ESP and "ON" or "OFF")
    for _,v in pairs(workspace:GetDescendants()) do
        if v.Name == "RANZZ_ESP" then
            v.Enabled = ESP
        end
    end
end)

ToggleBtn(MainP,"AIMBOT",70,function(b)
    Aim = not Aim
    Circle.Visible = Aim
    b.Text = "AIMBOT : "..(Aim and "ON" or "OFF")
end)

ToggleBtn(MainP,"AIMLOCK",120,function(b)
    Aimlock = not Aimlock
    b.Text = "AIMLOCK : "..(Aimlock and "ON" or "OFF")
end)

-- TP FUNCTION
local function TPFind(name)
    for _,v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find(name) and v:IsA("BasePart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0,3,0)
            break
        end
    end
end

local tps = {
    {"TP Hammer","hammer"},
    {"TP Toilet","toilet"},
    {"TP Criminal Base","sand"},
    {"TP Police Base","computer"},
    {"TP Yard","yard"},
    {"TP AK47","ak"},
    {"TP Knife","knife"},
}

for i,v in ipairs(tps) do
    local b = Instance.new("TextButton",Tp)
    b.Size = UDim2.new(0,200,0,35)
    b.Position = UDim2.new(0,20,0,20 + (i-1)*40)
    b.Text = v[1]
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(function()
        TPFind(v[2])
    end)
end

-- TAB SWITCH
local function Show(p)
    for _,v in pairs(Pages:GetChildren()) do v.Visible = false end
    p.Visible = true
end
HomeBtn.MouseButton1Click:Connect(function() Show(Home) end)
MainBtn.MouseButton1Click:Connect(function() Show(MainP) end)
TpBtn.MouseButton1Click:Connect(function() Show(Tp) end)

-- OPEN / CLOSE
Logo.MouseButton1Click:Connect(function()
    Main.Visible = true
    Logo.Visible = false
end)
Min.MouseButton1Click:Connect(function()
    Main.Visible = false
    Logo.Visible = true
end)
