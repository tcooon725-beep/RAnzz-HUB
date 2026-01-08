--// RAnzz Invisible Man v1.0
--// Toggle Invisible | Prank Mode 😈

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Invisible = false
local Saved = {}

-- ===== UI BUTTON (HP SUPPORT) =====
local gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
gui.Name = "InvisibleUI"

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0,120,0,35)
btn.Position = UDim2.new(0,10,0,200)
btn.Text = "INVISIBLE : OFF"
btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
btn.TextColor3 = Color3.new(1,1,1)
btn.BorderSizePixel = 0
btn.TextSize = 14

-- ===== FUNCTION =====
local function SetInvisible(state)
	local char = LocalPlayer.Character
	if not char then return end

	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then
			if state then
				Saved[v] = v.Transparency
				v.Transparency = 1
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			else
				if Saved[v] ~= nil then
					v.Transparency = Saved[v]
				end
				if v:IsA("BasePart") then
					v.CanCollide = true
				end
			end
		end
	end

	Invisible = state
	btn.Text = state and "INVISIBLE : ON" or "INVISIBLE : OFF"
end

-- ===== BUTTON CLICK =====
btn.MouseButton1Click:Connect(function()
	SetInvisible(not Invisible)
end)

-- ===== KEYBOARD (PC) =====
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.H then
		SetInvisible(not Invisible)
	end
end)

-- ===== RESPAWN FIX =====
LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	if Invisible then
		SetInvisible(true)
	end
end)
