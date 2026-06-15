-- THE LOCK SYSTEM
local correctPassword = "XenoBlink2026" -- This matches what you put in Pastebin

-- This forces a popup box to appear in Roblox asking the user for the password
local userPassword = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):WaitForChild("Chat"):FindFirstChild("Frame") -- (Or any simple custom text box UI you make)

-- For a basic test, let's just use a variable. 
-- In your actual UI textbox, you will set _G.EnteredPassword to whatever they type.
if _G.EnteredPassword == correctPassword then
    print("Password Correct! Loading Xeno features...")
    
    -- ==========================================
    -- PASTE THE REST OF YOUR ACTUAL SCRIPT HERE
    -- (Your Blink, Fast Reload, No Fall Damage)
    -- ==========================================

else
    -- If they type the wrong password, or don't have one, the script shuts off.
    game:GetService("Players").LocalPlayer:Kick("Wrong Password! Get it free at your-lootlabs-link-here")
end-- BOOGS TERMINAL • ULTIMA OVERLORD SUITE V26.2
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ProximityPromptService = game:GetService("ProximityPromptService")
local HttpService = game:GetService("HttpService")

-- Configuration Flag Matrix
_G.ESP_Master = false
_G.ESP_Names = false
_G.ESP_Distance = false
_G.ESP_HealthBars = false
_G.ESP_Chams = false 
_G.ESP_TeamCheck = false 
_G.NightVision_Active = false

_G.SilentAim_Active = false
_G.SilentAim_FOV = 130
_G.Target_Priority = "Distance" 
_G.Triggerbot_Active = false
_G.Hitbox_Expander = false

_G.Speed_Active = false
_G.Fly_Active = false
_G.Spinbot_Active = false
_G.No_Fall_Damage = true  -- DEFAULT ON
_G.Instant_Prompts = false
_G.Anti_Flip_Cars = false  
_G.Reload_Fast_Macro = false 
_G.Infinite_Jump = false 
_G.Noclip_Active = false 

-- High-Tier Automation Flags
_G.Metatable_Hook_Active = false
_G.Network_Throttling = false

-- Dynamic Keybind Defaults
local MenuKey = Enum.KeyCode.RightControl 
local SpeedKey = Enum.KeyCode.LeftShift 

-- Deep HUD Execution Isolation
local TargetParent = nil
if gethdgui then TargetParent = gethdgui()
elseif gethui then TargetParent = gethui()
else TargetParent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui") end

if TargetParent:FindFirstChild("BoogsTerminalV26") then TargetParent.BoogsTerminalV26:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BoogsTerminalV26"
ScreenGui.Parent = TargetParent
ScreenGui.ResetOnSpawn = false

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 60, 60)
FOVCircle.Filled = false
FOVCircle.Transparency = 0.6
FOVCircle.Visible = false

-- SYSTEM HUD OVERLAY INTERFACE
local MainDashboard = Instance.new("Frame")
MainDashboard.Size = UDim2.new(0, 520, 0, 360)
MainDashboard.Position = UDim2.new(0.3, 0, 0.25, 0)
MainDashboard.BackgroundColor3 = Color3.fromRGB(11, 12, 15)
MainDashboard.BorderSizePixel = 0
MainDashboard.Active = true
MainDashboard.Draggable = true
MainDashboard.Visible = true 
MainDashboard.Parent = ScreenGui

Instance.new("UICorner", MainDashboard).CornerRadius = UDim.new(0, 10)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == MenuKey then
        MainDashboard.Visible = not MainDashboard.Visible
    end
end)

local HeaderBar = Instance.new("Frame")
HeaderBar.Size = UDim2.new(1, 0, 0, 40)
HeaderBar.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
HeaderBar.BorderSizePixel = 0
HeaderBar.Parent = MainDashboard
Instance.new("UICorner", HeaderBar).CornerRadius = UDim.new(0, 10)

local BrandLabel = Instance.new("TextLabel")
BrandLabel.Size = UDim2.new(0.6, 0, 1, 0)
BrandLabel.Position = UDim2.new(0, 15, 0, 0)
BrandLabel.BackgroundTransparency = 1
BrandLabel.Text = "BOOGS TERMINAL • v26.2 OMNI-SHIELD [RCtrl]"
BrandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BrandLabel.Font = Enum.Font.GothamBold
BrandLabel.TextSize = 12
BrandLabel.TextXAlignment = Enum.TextXAlignment.Left
BrandLabel.Parent = HeaderBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(140, 145, 155)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = HeaderBar
CloseButton.MouseButton1Click:Connect(function() 
    ScreenGui:Destroy() 
    FOVCircle:Destroy()
end)

-- MULTI-TAB VIEWPORT CONFIGURATION
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 15, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainDashboard

local NavLayout = Instance.new("UIListLayout")
NavLayout.Padding = UDim.new(0, 4)
NavLayout.Parent = Sidebar
local NavPadding = Instance.new("UIPadding")
NavPadding.PaddingTop = UDim.new(0, 10)
NavPadding.PaddingLeft = UDim.new(0, 8)
NavPadding.PaddingRight = UDim.new(0, 8)
NavPadding.Parent = Sidebar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -150, 1, -50)
TabContainer.Position = UDim2.new(0, 145, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainDashboard

local visibleTabs = {}
local function CreateViewTab(tabName)
    local Frame = Instance.new("ScrollingFrame")
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.ScrollBarThickness = 2
    Frame.ScrollBarImageColor3 = Color3.fromRGB(40, 42, 50)
    Frame.Visible = false
    Frame.Parent = TabContainer

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 6)
    ListLayout.Parent = Frame
    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Frame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
    end)
    visibleTabs[tabName] = Frame
    return Frame
end

local TabVisuals  = CreateViewTab("Visuals")
local TabCombat   = CreateViewTab("Combat")
local TabPhysical = CreateViewTab("Utility")

local function ShowTab(tabName)
    for name, frame in pairs(visibleTabs) do frame.Visible = (name == tabName) end
end

local function AddNavButton(text, targetTab)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(190, 195, 205)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 11
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function() ShowTab(targetTab) end)
end

AddNavButton("Visual Overlay", "Visuals")
AddNavButton("Combat Matrix", "Combat")
AddNavButton("Engine Core", "Utility")
ShowTab("Visuals")

local function BuildToggleCard(parentTab, titleText, globalFlag, callback)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -5, 0, 40)
    Card.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
    Card.Parent = parentTab
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 5)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = titleText
    Label.TextColor3 = Color3.fromRGB(220, 225, 230)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Card

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 42, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -52, 0.25, 0)
    ToggleBtn.BackgroundColor3 = _G[globalFlag] and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(35, 38, 48)
    ToggleBtn.Text = _G[globalFlag] and "ON" or "OFF"
    ToggleBtn.TextColor3 = _G[globalFlag] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 155, 165)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 9
    ToggleBtn.Parent = Card
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 4)

    ToggleBtn.MouseButton1Click:Connect(function()
        local state = not _G[globalFlag]
        _G[globalFlag] = state
        ToggleBtn.Text = state and "ON" or "OFF"
        ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(35, 38, 48)
        ToggleBtn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 155, 165)
        if callback then callback(state) end
    end)
end

local function BuildActionCard(parentTab, titleText, clickCallback)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -5, 0, 40)
    Card.BackgroundColor3 = Color3.fromRGB(26, 30, 40)
    Card.Parent = parentTab
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 5)

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Size = UDim2.new(1, 0, 1, 0)
    ActionBtn.BackgroundTransparency = 1
    ActionBtn.Text = titleText
    ActionBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.TextSize = 11
    ActionBtn.Parent = Card
    ActionBtn.MouseButton1Click:Connect(clickCallback)
end

-- TILES
BuildToggleCard(TabVisuals, "Master ESP Engine", "ESP_Master")
BuildToggleCard(TabVisuals, "-> Identity Labels", "ESP_Names")
BuildToggleCard(TabVisuals, "-> Distance Scalars", "ESP_Distance")
BuildToggleCard(TabVisuals, "-> Health Bars", "ESP_HealthBars")
BuildToggleCard(TabVisuals, "-> Modern Chams", "ESP_Chams")
BuildToggleCard(TabVisuals, "-> Ignore Teammates", "ESP_TeamCheck")
BuildToggleCard(TabVisuals, "Night Vision", "NightVision_Active")

BuildToggleCard(TabCombat, "Silent Aim (R-Click)", "SilentAim_Active", function(v) FOVCircle.Visible = v end)
BuildToggleCard(TabCombat, "-> Metatable Hook", "Metatable_Hook_Active")
BuildToggleCard(TabCombat, "Triggerbot", "Triggerbot_Active")
BuildToggleCard(TabCombat, "Hitbox Expander", "Hitbox_Expander")
BuildToggleCard(TabCombat, "Animation Fast-Reload", "Reload_Fast_Macro")
BuildToggleCard(TabCombat, "Anti-Aim Spinbot", "Spinbot_Active")

BuildToggleCard(TabPhysical, "GLOBAL FALL PROTECTION", "No_Fall_Damage")
BuildToggleCard(TabPhysical, "Shift-WalkSpeed", "Speed_Active")
BuildToggleCard(TabPhysical, "3D Aero-Fly", "Fly_Active")
BuildToggleCard(TabPhysical, "Infinite Jump", "Infinite_Jump")
BuildToggleCard(TabPhysical, "Noclip Matrix", "Noclip_Active")
BuildToggleCard(TabPhysical, "Instant Prompts", "Instant_Prompts")
BuildToggleCard(TabPhysical, "Auto-Flip Vehicles", "Anti_Flip_Cars")
BuildToggleCard(TabPhysical, "Network Throttling", "Network_Throttling")

-- ACTIONS
BuildActionCard(TabPhysical, "Equip Spatial Blink Device", function()
    if not LocalPlayer.Backpack:FindFirstChild("Phase Blink") then
        local Tool = Instance.new("Tool")
        Tool.Name = "Phase Blink"
        Tool.RequiresHandle = false
        Tool.Activated:Connect(function()
            local mouse = LocalPlayer:GetMouse()
            if mouse.Target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local root = LocalPlayer.Character.HumanoidRootPart
                local offset = (mouse.Hit.Position - root.Position).Unit
                root.CFrame = CFrame.new(mouse.Hit.Position + (offset * 3))
                root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
            end
        end)
        Tool.Parent = LocalPlayer.Backpack
    end
end)

-- CORE TRACKING
local Camera = workspace.CurrentCamera
local function ConstructLegacyTracker(player)
    if player == LocalPlayer then return end
    local Box = Drawing.new("Square"); Box.Thickness = 1; Box.Color = Color3.fromRGB(255, 60, 60); Box.Visible = false
    local TextName = Drawing.new("Text"); TextName.Size = 13; TextName.Color = Color3.fromRGB(255, 255, 255); TextName.Center = true; TextName.Visible = false
    local internalLoop
    internalLoop = RunService.RenderStepped:Connect(function()
        if not player or not player.Parent then Box:Destroy(); TextName:Destroy(); internalLoop:Disconnect(); return end
        local char = player.Character; local root = char and char:FindFirstChild("HumanoidRootPart"); local hum = char and char:FindFirstChildOfClass("Humanoid")
        if _G.ESP_Master and root and hum and hum.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                Box.Size = Vector2.new(2000/pos.Z, 3000/pos.Z); Box.Position = Vector2.new(pos.X - Box.Size.X/2, pos.Y - Box.Size.Y/2); Box.Visible = true
                if _G.ESP_Names then TextName.Text = player.Name; TextName.Position = Vector2.new(pos.X, pos.Y - Box.Size.Y/2 - 15); TextName.Visible = true else TextName.Visible = false end
            else Box.Visible = false; TextName.Visible = false end
        else Box.Visible = false; TextName.Visible = false end
    end)
end
for _, p in pairs(Players:GetPlayers()) do InitLayer = function(p) ConstructLegacyTracker(p) end; InitLayer(p) end
Players.PlayerAdded:Connect(ConstructLegacyTracker)

-- TARGET SYSTEM
local function FetchTargetVector()
    local target, criteria = nil, _G.SilentAim_FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if dist < criteria then criteria = dist; target = p.Character.HumanoidRootPart end
            end
        end
    end
    return target
end

-- METATABLE HOOK
local Mouse = LocalPlayer:GetMouse()
local RawMetatable = getrawmetatable and getrawmetatable(game)
if RawMetatable and makewriteable then
    makewriteable(RawMetatable); local OldIndex = RawMetatable.__index
    RawMetatable.__index = newcclosure(function(self, key)
        if _G.Metatable_Hook_Active and self == Mouse and (key == "Hit" or key == "Target") then
            local t = FetchTargetVector(); if t then return (key == "Hit" and t.CFrame or t) end
        end
        return OldIndex(self, key)
    end)
end

-- RENDER TICK (INCLUDES TOTAL FALL DAMAGE REMOVAL)
RunService.RenderStepped:Connect(function()
    if FOVCircle.Visible then FOVCircle.Position = UserInputService:GetMouseLocation(); FOVCircle.Radius = _G.SilentAim_FOV end

    if _G.No_Fall_Damage and LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if root and hum then
            -- 1. State Locking (Blocks 'Landed' trigger)
            if hum:GetState() == Enum.HumanoidStateType.Freefall then
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end
            -- 2. Momentum Clamp (Blocks Velocity-based damage)
            if root.Velocity.Y < -15 then 
                root.Velocity = Vector3.new(root.Velocity.X, -2, root.Velocity.Z) 
            end
        end
    end

    if _G.Fly_Active and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        local vel = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, 1, 0) end
        root.Velocity = vel.Unit * 70
    end

    if _G.Spinbot_Active and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(50), 0)
    end

    if _G.NightVision_Active then Lighting.ExposureCompensation = 2.5 else Lighting.ExposureCompensation = 0 end

    if _G.Speed_Active and UserInputService:IsKeyDown(SpeedKey) then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 35
        end
    end
end)

-- BOOT SEQUENCE COMPLETE
