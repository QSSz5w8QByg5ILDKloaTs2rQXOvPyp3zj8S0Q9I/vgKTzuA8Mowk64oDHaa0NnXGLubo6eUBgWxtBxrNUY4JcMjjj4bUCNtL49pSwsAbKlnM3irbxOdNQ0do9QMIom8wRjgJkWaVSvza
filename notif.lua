local Notification = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NotificationUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Container = Instance.new("Frame")
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, 0, 1, 0)
Container.Position = UDim2.new(0, 0, 0, 0)
Container.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local Icons = {
    ["error"] = "❌",
    ["success"] = "✅",
    ["warn"] = "⚠️",
    ["warning"] = "⚠️",
    ["info"] = "ℹ️"
}

function Notification:Notify(text: string, method: string, duration: number)
    method = string.lower(method)
    local icon = Icons[method] or "ℹ️"
    local duration = duration or 3

    local Frame = Instance.new("Frame")
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Size = UDim2.new(0, 280, 0, 28)
    Frame.BorderSizePixel = 0
    Frame.Parent = Container
    Frame.BackgroundTransparency = 0.15

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -8, 1, 0)
    Label.Position = UDim2.new(0, 4, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = string.format("%s %s !", icon, text)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    Label.RichText = true
    Label.Text = string.format("<font size='11'>%s</font> %s !", icon, text)

    Frame.BackgroundTransparency = 1
    Label.TextTransparency = 1

    TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    task.delay(duration, function()
        TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        task.wait(0.35)
        Frame:Destroy()
    end)
end

return Notification
