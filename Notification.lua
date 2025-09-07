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
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

local Icons = {
	success = "✅",
	error = "❌",
	warning = "⚠️",
	info = "ℹ️"
}

function Notification:Notify(text, mode, duration)
	mode = (mode or "info"):lower()
	duration = duration or 3
	local emoji = Icons[mode] or "ℹ️"

	local Frame = Instance.new('Frame')
	Frame.Size = UDim2.new(0, 360, 0, 30)
	Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Frame.BorderSizePixel = 0
	Frame.Parent = Container

	local UICorner = Instance.new('UICorner')
	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Frame

	local IconLabel = Instance.new('TextLabel')
	IconLabel.Size = UDim2.new(0, 24, 0, 24)
	IconLabel.Position = UDim2.new(0, 4, 0.5, -12)
	IconLabel.BackgroundTransparency = 1
	IconLabel.Font = Enum.Font.SourceSansBold
	IconLabel.TextSize = 18
	IconLabel.Text = emoji
	IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	IconLabel.Parent = Frame

	local TextLabel = Instance.new('TextLabel')
	TextLabel.Size = UDim2.new(1, -32, 1, 0)
	TextLabel.Position = UDim2.new(0, 32, 0, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.SourceSansBold
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.Text = text
	TextLabel.RichText = true
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	Frame.BackgroundTransparency = 1
	TextLabel.TextTransparency = 1
	IconLabel.TextTransparency = 1

	TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
	TweenService:Create(TextLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
	TweenService:Create(IconLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

	task.delay(duration, function()
		TweenService:Create(Frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(TextLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(IconLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		task.wait(0.6)
		Frame:Destroy()
	end)
end

return Notification
