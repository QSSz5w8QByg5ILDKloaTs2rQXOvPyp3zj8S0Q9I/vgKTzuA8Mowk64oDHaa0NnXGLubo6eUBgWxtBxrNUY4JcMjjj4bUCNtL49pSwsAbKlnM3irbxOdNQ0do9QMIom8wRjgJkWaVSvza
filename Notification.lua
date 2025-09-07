local Notification = {}
Notification.__index = Notification

local TweenService = game:GetService('TweenService')

local Icons = {
	['warn'] = '⚠️',
	['success'] = '✅',
	['info'] = 'ℹ️',
	['error'] = '❌',
}

local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'NotificationGui'
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')

local Queue = {}
local BASE_Y = 0.85
local SPACING = 40

local function updatePositions()
	for i, frame in ipairs(Queue) do
		local targetY = BASE_Y - ((i-1) * (SPACING/500))
		local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -175, targetY, 0)})
		tween:Play()
	end
end

function Notification:Notify(text, mode, duration)
	mode = mode:lower()
	local icon = Icons[mode] or 'ℹ️'
	duration = duration or 3

	local Frame = Instance.new('Frame')
	Frame.Size = UDim2.new(0, 350, 0, 35)
	Frame.Position = UDim2.new(0.5, -175, BASE_Y, 0)
	Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Frame.BackgroundTransparency = 0.2
	Frame.BorderSizePixel = 0
	Frame.Parent = ScreenGui

	local UICorner = Instance.new('UICorner')
	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = Frame

	local IconLabel = Instance.new('TextLabel')
	IconLabel.Size = UDim2.new(0, 30, 1, 0)
	IconLabel.BackgroundTransparency = 1
	IconLabel.Font = Enum.Font.SourceSansBold
	IconLabel.TextSize = 22
	IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	IconLabel.Text = icon
	IconLabel.Parent = Frame

	local TextLabel = Instance.new('TextLabel')
	TextLabel.Size = UDim2.new(1, -60, 1, 0)
	TextLabel.Position = UDim2.new(0, 35, 0, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Text = text
	TextLabel.RichText = true
	TextLabel.Parent = Frame

	local ExLabel = Instance.new('TextLabel')
	ExLabel.Size = UDim2.new(0, 30, 1, 0)
	ExLabel.Position = UDim2.new(1, -30, 0, 0)
	ExLabel.BackgroundTransparency = 1
	ExLabel.Font = Enum.Font.SourceSansBold
	ExLabel.TextSize = 22
	ExLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExLabel.Text = '!'
	ExLabel.Parent = Frame

	Frame.BackgroundTransparency = 1
	IconLabel.TextTransparency = 1
	TextLabel.TextTransparency = 1
	ExLabel.TextTransparency = 1

	TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
	TweenService:Create(IconLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
	TweenService:Create(TextLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
	TweenService:Create(ExLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

	table.insert(Queue, 1, Frame)
	updatePositions()

	task.delay(duration, function()
		TweenService:Create(Frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		TweenService:Create(IconLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(TextLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(ExLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		task.wait(0.6)
		Frame:Destroy()
		for i, f in ipairs(Queue) do
			if f == Frame then
				table.remove(Queue, i)
				break
			end
		end
		updatePositions()
	end)
end

return Notification
