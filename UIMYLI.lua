function MyUILibrary:CreateWindow(properties)
    local window = Instance.new("Frame")
    window.Size = properties.Size or UDim2.new(0, 300, 0, 400)
    window.Position = properties.Position or UDim2.new(0.5, -150, 0.5, -200)
    window.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    
    -- Title
    local titleBar = Instance.new("TextLabel", window)
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleBar.Text = properties.Title or "Window Title"
    titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Subtitle
    local subtitleBar = Instance.new("TextLabel", window)
    subtitleBar.Size = UDim2.new(1, 0, 0, 20)
    subtitleBar.Position = UDim2.new(0, 0, 0, 30)
    subtitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    subtitleBar.Text = properties.SubTitle or "Window Subtitle"
    subtitleBar.TextColor3 = Color3.fromRGB(200, 200, 200)

    -- Mobile Dragging
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    window.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return window
end

function MyUILibrary:CreateTab(properties)
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = properties.Size or UDim2.new(0, 300, 0, 200)
    tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    local scrollingFrame = Instance.new("ScrollingFrame", tabFrame)
    scrollingFrame.Size = UDim2.new(1, 0, 1, -30)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)  -- Adjust based on content
    
    local tabTitle = Instance.new("TextLabel", tabFrame)
    tabTitle.Size = UDim2.new(1, 0, 0, 30)
    tabTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabTitle.Text = properties.Title or "Tab Title"
    tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    tabFrame.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return tabFrame
end

function MyUILibrary:CreateNotification(properties)
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 300, 0, 100)
    notification.Position = UDim2.new(0.5, -150, 0, -100)
    notification.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    
    local title = Instance.new("TextLabel", notification)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = properties.Title or "Notification Title"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local content = Instance.new("TextLabel", notification)
    content.Size = UDim2.new(1, 0, 0, 30)
    content.Position = UDim2.new(0, 0, 0, 30)
    content.Text = properties.Content or "Notification Content"
    content.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local subContent = Instance.new("TextLabel", notification)
    subContent.Size = UDim2.new(1, 0, 0, 30)
    subContent.Position = UDim2.new(0, 0, 0, 60)
    subContent.Text = properties.SubContent or "Notification SubContent"
    subContent.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Tween in
    notification:TweenPosition(UDim2.new(0.5, -150, 0, 50), "Out", "Sine", 1)
    
    -- Destroy after duration
    delay(properties.Duration or 5, function()
        if properties.SubContent then
            subContent:Destroy()
        end
        notification:TweenPosition(UDim2.new(0.5, -150, 0, -100), "In", "Sine", 1, true, function()
            notification:Destroy()
        end)
    end)
    
    notification.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return notification
end

function MyUILibrary:CreateParagraph(properties)
    local paragraph = Instance.new("Frame")
    paragraph.Size = UDim2.new(0, 300, 0, 150)
    paragraph.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    
    local title = Instance.new("TextLabel", paragraph)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = properties.Title or "Paragraph Title"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local content = Instance.new("TextLabel", paragraph)
    content.Size = UDim2.new(1, 0, 0, 120)
    content.Position = UDim2.new(0, 0, 0, 30)
    content.Text = properties.Content or "Paragraph Content"
    content.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Optional removal of content
    if not properties.Content then
        content:Destroy()
    end
    
    paragraph.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return paragraph
end

function MyUILibrary:CreateButton(properties)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Text = properties.Title or "Button"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    if properties.Description then
        local description = Instance.new("TextLabel", button)
        description.Size = UDim2.new(1, 0, 0, 20)
        description.Position = UDim2.new(0, 0, 1, 0)
        description.Text = properties.Description or "Button Description"
        description.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    
    button.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return button
end

function MyUILibrary:CreateToggle(properties)
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 200, 0, 50)
    toggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)  -- Default red (off)
    
    local title = Instance.new("TextLabel", toggle)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = properties.Title or "Toggle"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local toggleButton = Instance.new("TextButton", toggle)
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 150, 0, 0)
    toggleButton.Text = ""
    
    local corner = Instance.new("UICorner", toggleButton)
    corner.CornerRadius = UDim.new(1, 0)
    
    local toggled = false
    toggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)  -- Green (on)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)  -- Red (off)
        end
    end)
    
    toggle.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return toggle
end

function MyUILibrary:CreateSlider(properties)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0, 300, 0, 60)
    slider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    
    local title = Instance.new("TextLabel", slider)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = properties.Title or "Slider"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local description = Instance.new("TextLabel", slider)
    description.Size = UDim2.new(1, 0, 0, 20)
    description.Position = UDim2.new(0, 0, 0, 30)
    description.Text = properties.Description or "Slider Description"
    description.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    if not properties.Description then
        description:Destroy()
    end
    
    local sliderBar = Instance.new("Frame", slider)
    sliderBar.Size = UDim2.new(0.9, 0, 0, 10)
    sliderBar.Position = UDim2.new(0.05, 0, 0, 50)
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    
    local sliderHandle = Instance.new("Frame", sliderBar)
    sliderHandle.Size = UDim2.new(0, 20, 1, 0)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
    local corner = Instance.new("UICorner", sliderHandle)
    corner.CornerRadius = UDim.new(1, 0)
    
    local valueDisplay = Instance.new("TextLabel", slider)
    valueDisplay.Size = UDim2.new(0, 50, 0, 20)
    valueDisplay.Position = UDim2.new(1, -50, 0, 50)
    valueDisplay.Text = tostring(properties.Default or 0)
    valueDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local dragging = false
    sliderHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    sliderHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local scale = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            sliderHandle.Position = UDim2.new(scale, -10, 0, 0)
            local value = math.floor((properties.Min or 0) + (properties.Max or 100 - properties.Min or 0) * scale + 0.5)
            valueDisplay.Text = tostring(value)
        end
    end)
    
    slider.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return slider
end

function MyUILibrary:CreateDropdown(properties)
    local dropdown = Instance.new("Frame")
    dropdown.Size = UDim2.new(0, 300, 0, 60)
    dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    
    local title = Instance.new("TextLabel", dropdown)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = properties.Title or "Dropdown"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local description = Instance.new("TextLabel", dropdown)
    description.Size = UDim2.new(1, 0, 0, 20)
    description.Position = UDim2.new(0, 0, 0, 30)
    description.Text = properties.Description or "Dropdown Description"
    description.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    if not properties.Description then
        description:Destroy()
    end
    
    local dropdownButton = Instance.new("TextButton", dropdown)
    dropdownButton.Size = UDim2.new(1, 0, 0, 30)
    dropdownButton.Position = UDim2.new(0, 0, 0, 50)
    dropdownButton.Text = properties.Default or "Select..."
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local scrollingFrame = Instance.new("ScrollingFrame", dropdown)
    scrollingFrame.Size = UDim2.new(1, 0, 0, 100)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 80)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, #properties.Values * 0.1, 0)
    scrollingFrame.Visible = false
    
    for _, value in ipairs(properties.Values or {}) do
        local item = Instance.new("TextButton", scrollingFrame)
        item.Size = UDim2.new(1, 0, 0, 30)
        item.Text = value
        item.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        item.MouseButton1Click:Connect(function()
            if properties.Multi then
                if string.find(dropdownButton.Text, value) then
                    dropdownButton.Text = string.gsub(dropdownButton.Text, value .. ", ", "")
                else
                    dropdownButton.Text = dropdownButton.Text == "Select..." and value or dropdownButton.Text .. ", " .. value
                end
            else
                dropdownButton.Text = value
                scrollingFrame.Visible = false
            end
        end)
    end
    
    dropdownButton.MouseButton1Click:Connect(function()
        scrollingFrame.Visible = not scrollingFrame.Visible
    end)
    
    dropdown.Parent = properties.Parent or game.Players.LocalPlayer.PlayerGui
    return dropdown
end

