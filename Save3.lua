-- Made by Worming

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- المتغيرات
local savedPositions = {nil, nil, nil}
local speed = 5

-- إنشاء الواجهة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WormingGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- المربع الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- زوايا مستديرة
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- العنوان
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Worming Teleport"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- دالة إنشاء خانة حفظ
local function createSaveSlot(index, yPos)
    -- الإطار
    local SlotFrame = Instance.new("Frame")
    SlotFrame.Size = UDim2.new(1, -20, 0, 50)
    SlotFrame.Position = UDim2.new(0, 10, 0, yPos)
    SlotFrame.BackgroundColor3 = Color3.fromRGB(255, 180, 100)
    SlotFrame.BackgroundTransparency = 0.5
    SlotFrame.BorderSizePixel = 1
    SlotFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
    SlotFrame.Parent = MainFrame

    local SlotCorner = Instance.new("UICorner")
    SlotCorner.CornerRadius = UDim.new(0, 8)
    SlotCorner.Parent = SlotFrame

    -- اسم الخانة
    local SlotName = Instance.new("TextLabel")
    SlotName.Size = UDim2.new(0, 60, 1, 0)
    SlotName.Position = UDim2.new(0, 5, 0, 0)
    SlotName.BackgroundTransparency = 1
    SlotName.Text = "Save " .. index
    SlotName.TextColor3 = Color3.fromRGB(255, 255, 255)
    SlotName.TextScaled = true
    SlotName.Font = Enum.Font.GothamBold
    SlotName.Parent = SlotFrame

    -- زر الحفظ
    local SaveBtn = Instance.new("TextButton")
    SaveBtn.Size = UDim2.new(0, 50, 0, 35)
    SaveBtn.Position = UDim2.new(0, 70, 0, 7)
    SaveBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    SaveBtn.Text = "Save"
    SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveBtn.TextScaled = true
    SaveBtn.Font = Enum.Font.GothamBold
    SaveBtn.Parent = SlotFrame

    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 6)
    SaveCorner.Parent = SaveBtn

    -- زر الذهاب
    local GoBtn = Instance.new("TextButton")
    GoBtn.Size = UDim2.new(0, 50, 0, 35)
    GoBtn.Position = UDim2.new(0, 125, 0, 7)
    GoBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    GoBtn.Text = "Go"
    GoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GoBtn.TextScaled = true
    GoBtn.Font = Enum.Font.GothamBold
    GoBtn.Parent = SlotFrame

    local GoCorner = Instance.new("UICorner")
    GoCorner.CornerRadius = UDim.new(0, 6)
    GoCorner.Parent = GoBtn

    -- وظيفة الحفظ
    SaveBtn.MouseButton1Click:Connect(function()
        savedPositions[index] = rootPart.CFrame
        SaveBtn.Text = "Saved!"
        wait(1)
        SaveBtn.Text = "Save"
    end)

    -- وظيفة الذهاب
    GoBtn.MouseButton1Click:Connect(function()
        if savedPositions[index] then
            local targetPos = savedPositions[index]
            local startPos = rootPart.CFrame
            
            -- حساب المسافة
            local distance = (targetPos.Position - startPos.Position).Magnitude
            local steps = math.floor(distance / speed)
            
            -- الحركة التدريجية
            for i = 1, steps do
                local alpha = i / steps
                rootPart.CFrame = startPos:Lerp(targetPos, alpha)
                wait(0.01)
            end
            
            rootPart.CFrame = targetPos
        end
    end)
end

-- إنشاء 3 خانات
createSaveSlot(1, 40)
createSaveSlot(2, 100)
createSaveSlot(3, 160)

-- عداد السرعة
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -20, 0, 50)
SpeedFrame.Position = UDim2.new(0, 10, 0, 215)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(255, 180, 100)
SpeedFrame.BackgroundTransparency = 0.5
SpeedFrame.BorderSizePixel = 1
SpeedFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
SpeedFrame.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedFrame

-- نص السرعة
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 60, 1, 0)
SpeedLabel.Position = UDim2.new(0, 5, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextScaled = true
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Parent = SpeedFrame

-- عرض السرعة
local SpeedValue = Instance.new("TextLabel")
SpeedValue.Size = UDim2.new(0, 40, 1, 0)
SpeedValue.Position = UDim2.new(0, 65, 0, 0)
SpeedValue.BackgroundTransparency = 1
SpeedValue.Text = tostring(speed)
SpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedValue.TextScaled = true
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.Parent = SpeedFrame

-- زر +
local PlusBtn = Instance.new("TextButton")
PlusBtn.Size = UDim2.new(0, 40, 0, 35)
PlusBtn.Position = UDim2.new(0, 110, 0, 7)
PlusBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
PlusBtn.Text = "+"
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.TextScaled = true
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.Parent = SpeedFrame

local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0, 6)
PlusCorner.Parent = PlusBtn

-- زر -
local MinusBtn = Instance.new("TextButton")
MinusBtn.Size = UDim2.new(0, 40, 0, 35)
MinusBtn.Position = UDim2.new(0, 160, 0, 7)
MinusBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
MinusBtn.Text = "-"
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.TextScaled = true
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.Parent = SpeedFrame

local MinusCorner = Instance.new("UICorner")
MinusCorner.CornerRadius = UDim.new(0, 6)
MinusCorner.Parent = MinusBtn

-- وظيفة +
PlusBtn.MouseButton1Click:Connect(function()
    speed = speed + 5
    SpeedValue.Text = tostring(speed)
end)

-- وظيفة -
MinusBtn.MouseButton1Click:Connect(function()
    if speed > 5 then
        speed = speed - 5
        SpeedValue.Text = tostring(speed)
    end
end)
