local Notification = {}
Notification.__index = Notification

local TweenService = game:GetService('TweenService')
local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'NotificationGui'
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')

local Container = Instance.new('Frame')
Container.Size = UDim2.new(0, 360, 0, 0)
Container.Position = UDim2.new(0.5, -180, 0.85, 0)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

local UIListLayout = Instance.new('UIListLayout')
UIListLayout.Padding = UDim.new(0, 1)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

local Icons = {
    info = 6031094676,
    success = 6031094685,
    error = 6031094680,
    warn = 6031094682
}

function Notification:Notify(text, mode, duration)
    mode = string.lower(mode or 'info')
    duration = duration or 3

    local iconId = Icons[mode] or Icons['info']

    local Frame = Instance.new('Frame')
    Frame.Size = UDim2.new(0, 360, 0, 30)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BorderSizePixel = 0
    Frame.Parent = Container

    local UICorner = Instance.new('UICorner')
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame

    local Icon = Instance.new('ImageLabel')
    Icon.Size = UDim2.new(0, 24, 0, 24)
    Icon.Position = UDim2.new(0, 4, 0.5, -12)
    Icon.BackgroundTransparency = 1
    Icon.Image = 'rbxassetid://'..iconId
    Icon.Parent = Frame

    local TextLabel = Instance.new('TextLabel')
    TextLabel.Size = UDim2.new(1, -32, 1, 0)
    TextLabel.Position = UDim2.new(0, 32, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextSize = 18
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Text = text .. " !"
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame

    Frame.BackgroundTransparency = 1
    TextLabel.TextTransparency = 1
    Icon.ImageTransparency = 1

    TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(TextLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()

    task.delay(duration, function()
        TweenService:Create(Frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(TextLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        TweenService:Create(Icon, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        task.wait(0.6)
        Frame:Destroy()
    end)
end

return Notification
