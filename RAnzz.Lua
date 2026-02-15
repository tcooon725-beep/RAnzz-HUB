-- Script by RAnzz (V5 - Optimization & New Logic)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local MinimizeBtn = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame") -- Container untuk tombol agar bisa dihide

-- Pembersihan GUI Lama (Sesuai Request Simpan/Upgrade)
local oldGui = game.CoreGui:FindFirstChild("RAnzz_Executor_V5")
if oldGui then oldGui:Destroy() end

ScreenGui.Name = "RAnzz_Executor_V5"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -160)
MainFrame.Size = UDim2.new(0, 220, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Title
Title.Parent = MainFrame
Title.Text = "RAnzz HUB V5"
Title.Size = UDim2.new(0.7, 0, 0, 40)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button Logic
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
MinimizeBtn.Text = "—"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 5)
minCorner.Parent = MinimizeBtn

ContentFrame.Name = "Content"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentFrame.Visible = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 40), "Out", "Quart", 0.3, true)
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 340), "Out", "Quart", 0.3, true)
        MinimizeBtn.Text = "—"
    end
end)

-- Tombol-tombol
local DestroyWallBtn = Instance.new("TextButton")
local GodModeBtn = Instance.new("TextButton")
local InstantBtn = Instance.new("TextButton")
local DupeBtn = Instance.new("TextButton") 
local TpMainBtn = Instance.new("TextButton")
local TpBaseBtn = Instance.new("TextButton")

local function styleButton(btn, pos, color, text)
    btn.Parent = ContentFrame
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
end

styleButton(DestroyWallBtn, UDim2.new(0.05, 0, 0.05, 0), Color3.fromRGB(180, 40, 40), "Destroy VIP Wall")
styleButton(GodModeBtn, UDim2.new(0.05, 0, 0.18, 0), Color3.fromRGB(40, 150, 40), "God Mode: OFF")
styleButton(InstantBtn, UDim2.new(0.05, 0, 0.31, 0), Color3.fromRGB(40, 80, 180), "Instant Interact")
styleButton(DupeBtn, UDim2.new(0.05, 0, 0.44, 0), Color3.fromRGB(150, 40, 150), "Real Dupe (Server)") 
styleButton(TpMainBtn, UDim2.new(0.05, 0, 0.57, 0), Color3.fromRGB(200, 160, 0), "TP to Gate")
styleButton(TpBaseBtn, UDim2.new(0.05, 0, 0.70, 0), Color3.fromRGB(40, 140, 140), "TP to Base")

--- LOGIC UPDATE V5 ---

-- 1. God Mode dengan tambahan "Fast"
local godModeActive = false
GodModeBtn.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    GodModeBtn.Text = "God Mode: " .. (godModeActive and "ON" or "OFF")
    task.spawn(function()
        while godModeActive do
            for _, model in pairs(game.Workspace:GetDescendants()) do
                -- Menambahkan 'Fast' ke daftar deteksi tsunami/bahaya
                local dangerousNames = {"Normal", "Medium", "Big", "Toxic", "Cepat", "Fast"}
                for _, name in pairs(dangerousNames) do
                    if model.Name == name then
                        for _, part in pairs(model:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanTouch = false end
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- 2. TP to Gate (Update dari TP to Main)
TpMainBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Gate" and (obj:IsA("Model") or obj:IsA("BasePart")) then
            local targetPos = obj:IsA("Model") and obj:GetModelCFrame() or obj.CFrame
            player.Character.HumanoidRootPart.CFrame = targetPos + Vector3.new(0, 3, 0)
            break
        end
    end
end)

-- 3. TP to Base (Ganti dari TP Rare)
TpBaseBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Base" and (obj:IsA("Model") or obj:IsA("BasePart")) then
            local targetPos = obj:IsA("Model") and obj:GetModelCFrame() or obj.CFrame
            player.Character.HumanoidRootPart.CFrame = targetPos + Vector3.new(0, 3, 0)
            break
        end
    end
end)

-- Fungsi lain tetap dipertahankan
DestroyWallBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name == "VipPart" then obj:Destroy() end
    end
end)

InstantBtn.MouseButton1Click:Connect(function()
    for _, prompt in pairs(game:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0 end
    end
end)

DupeBtn.MouseButton1Click:Connect(function()
    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then
        local events = game:GetService("ReplicatedStorage"):GetDescendants()
        for _, v in pairs(events) do
            if v:IsA("RemoteEvent") and (v.Name:lower():find("drop")) then
                v:FireServer(tool)
            end
        end
        tool:Clone().Parent = game.Players.LocalPlayer.Backpack
        DupeBtn.Text = "Dupe Success!"
        task.wait(1)
        DupeBtn.Text = "Real Dupe (Server)"
    end
end)
