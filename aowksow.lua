local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local FishEvent = ReplicatedStorage:WaitForChild("FishingSystem"):WaitForChild("FishGiver")
local SellEvent = ReplicatedStorage:WaitForChild("FishingSystem"):WaitForChild("InventoryEvents"):WaitForChild("Inventory_SellAll")

local isFarming = false
local eventCount = 0

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KemplongXD"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 99999

local success = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not success then
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
end

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
OpenButton.Position = UDim2.new(0, 20, 0.4, 0)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Text = "🎣" 
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 25
OpenButton.ZIndex = 10
OpenButton.Active = true
OpenButton.Draggable = true 

local IconCorner = Instance.new("UICorner", OpenButton)
IconCorner.CornerRadius = UDim.new(0, 10)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) 
MainFrame.Size = UDim2.new(0, 220, 0, 110)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.ZIndex = 5

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 5)
Title.Size = UDim2.new(0.7, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "KemplongXD"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 6

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(1, -35, 0, 8)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.ZIndex = 6
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 5)

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "START AUTO"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.ZIndex = 6
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 5)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    isFarming = false
    ScreenGui:Destroy()
end)

ToggleButton.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    if isFarming then
        ToggleButton.Text = "STOP AUTO"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    else
        ToggleButton.Text = "START AUTO"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    end
end)

local autoConnection
autoConnection = RunService.Heartbeat:Connect(function()
    if not ScreenGui.Parent then
        autoConnection:Disconnect()
        return
    end
    
    if isFarming then
        FishEvent:FireServer({
            hookPosition = Vector3.new(40.371788024902, 0.15000000596046, -29.393039703369),
            power = 1
        })
        
        eventCount = eventCount + 1
        
        if eventCount >= 40 then
            pcall(function()
                SellEvent:InvokeServer()
            end)
            eventCount = 0
        end
    end
end)
