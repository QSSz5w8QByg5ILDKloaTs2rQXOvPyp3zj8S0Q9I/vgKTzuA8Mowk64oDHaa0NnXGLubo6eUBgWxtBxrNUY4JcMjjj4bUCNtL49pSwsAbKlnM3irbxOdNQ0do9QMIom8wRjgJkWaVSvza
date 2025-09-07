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
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

local Icons = {
    ["error"] = "❌",
    ["success"] = "✅",
    ["warn"] = "⚠️",
    ["warning"] = "⚠️",
    ["info"] = "ℹ️"
}

local Colors = {
    ["error"] = Color3.fromRGB(255, 60, 60),
    ["success"] = Color3.fromRGB(80, 255, 120),
    ["warn"] = Color3.fromRGB(255, 220, 80),
    ["warning"] = Color3.fromRGB(255, 220, 80),
    ["info"] = Color3.fromRGB(100, 180, 255)
}

function Notification:Notify(text: string, method: string, duration: number)
    method = string.lower(method)
    local icon = Icons[method] or "ℹ️"
    local duration = duration or 3
    local glowColor = Colors[method] or Color3.fromRGB(200, 200, 200)

    local Frame = Instance.new("Frame")
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Size = UDim2.new(0, 280, 0, 32)
    Frame.BorderSizePixel = 0
    Frame.Parent = Container
    Frame.BackgroundTransparency = 0.2
    Frame.ClipsDescendants = true

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Frame

    local Glow = Instance.new("Frame")
    Glow.Size = UDim2.new(1, 0, 1, 0)
    Glow.Position = UDim2.new(0, 0, 0, 0)
    Glow.BackgroundColor3 = glowColor
    Glow.BackgroundTransparency = 0.75
    Glow.BorderSizePixel = 0
    Glow.ZIndex = 0
    Glow.Parent = Frame

    local GlowCorner = Instance.new("UICorner")
    GlowCorner.CornerRadius = UDim.new(0, 6)
    GlowCorner.Parent = Glow

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -8, 1, 0)
    Label.Position = UDim2.new(0, 4, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = string.format("<font size='11'>%s</font> %s !", icon, text)
    Label.Font = Enum.Font.GothamBold
    Label.RichText = true
    Label.TextSize = 13
    Label.TextColor3 = Color3.fromRGB(235, 235, 235)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    Frame.BackgroundTransparency = 1
    Label.TextTransparency = 1
    Glow.Size = UDim2.new(1, 0, 1, 0)

    TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.2
    }):Play()
    TweenService:Create(Label, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()

    TweenService:Create(Glow, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 0, 1, 0)
    }):Play()

    task.delay(duration, function()
        local fadeOut1 = TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            BackgroundTransparency = 1
        })
        local fadeOut2 = TweenService:Create(Label, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            TextTransparency = 1
        })
        fadeOut1:Play()
        fadeOut2:Play()
        task.wait(0.4)
        Frame:Destroy()
    end)
end

return Notification
