-- locais Inicias
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local lp = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VIM = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

-- limite de 1 Gui
if _G.ModWareConnections then
    for _, conn in ipairs(_G.ModWareConnections) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then
            conn:Disconnect()
        end
    end
end
_G.ModWareConnections = {}

local oldGui = lp.PlayerGui:FindFirstChild("ModWareGui")
if oldGui then
    oldGui:Destroy()
end

-- Team check
local function IsTeammate(p)
    if p == lp then return true end
    if not p.Character or not lp.Character then return false end
    local pTeam = p:GetAttribute("TeamID") or p:GetAttribute("Team") or p.Character:GetAttribute("Team")
    local lpTeam = lp:GetAttribute("TeamID") or lp:GetAttribute("Team") or lp.Character:GetAttribute("Team")
    if pTeam and lpTeam and pTeam == lpTeam then return true end
    if p.TeamColor == lp.TeamColor and p.TeamColor.Name ~= "White" then return true end
    return false
end

local MainColor = Color3.fromHex("#000000")
local MainColor1 = Color3.fromHex("#FFFFFF")
local MainColor2 = Color3.fromHex("#00FF7F")
local MainColor3 = Color3.fromHex("#00FFFF")
local MainColor4 = Color3.fromHex("#00FF00")
local MainColor5 = Color3.fromHex("#7CFC00")
local MainColor6 = Color3.fromHex("#FFD700")
local MainColor7 = Color3.fromHex("#FF0000")
local MainColor8 = Color3.fromHex("#FF8C00")
local MainColor9 = Color3.fromHex("#DC143C")
local MainColor10 = Color3.fromHex("#FF1493")
local MainColor11 = Color3.fromHex("#FF00FF")
local MainColor12 = Color3.fromHex("#4B0082")
_G.HubKeybind = Enum.KeyCode.Q

-- Screengui
local ScreenGui = Instance.new("ScreenGui", lp.PlayerGui)
ScreenGui.DisplayOrder = 999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Name = "ModWareGui"
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 460)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -230)
MainFrame.BackgroundTransparency = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
local MainHubCorner = Instance.new("UICorner", MainFrame)
MainHubCorner.CornerRadius = UDim.new(0, 6)
local MainStroke11 = Instance.new("UIStroke", MainFrame)
MainStroke11.Thickness = 2
MainStroke11.Color = MainColor
MainStroke11.Transparency = 0

-- Tool Tip
local TooltipFrame = Instance.new("Frame", ScreenGui)
TooltipFrame.Size = UDim2.new(0, 220, 0, 40)
TooltipFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TooltipFrame.BackgroundTransparency = 0.1
TooltipFrame.Visible = false
TooltipFrame.ZIndex = 999999

Instance.new("UICorner", TooltipFrame).CornerRadius = UDim.new(0, 6)

local TooltipStroke = Instance.new("UIStroke", TooltipFrame)
TooltipStroke.Color = MainColor1
TooltipStroke.Thickness = 1
TooltipStroke.Transparency = 0.8

local TooltipLabel = Instance.new("TextLabel", TooltipFrame)
TooltipLabel.Size = UDim2.new(1, -10, 1, -10)
TooltipLabel.Position = UDim2.new(0, 5, 0, 5)
TooltipLabel.BackgroundTransparency = 1
TooltipLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
TooltipLabel.Font = Enum.Font.Code
TooltipLabel.TextSize = 12
TooltipLabel.TextWrapped = true
TooltipLabel.TextXAlignment = Enum.TextXAlignment.Left

local DragBar = Instance.new("Frame", MainFrame)
DragBar.Size = UDim2.new(1, 0, 0, 35)
DragBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
DragBar.BorderSizePixel = 0
DragBar.Active = true

local DragCorner = Instance.new("UICorner", DragBar)
DragCorner.CornerRadius = UDim.new(0, 0)

local DragFill = Instance.new("Frame", DragBar)
DragFill.Size = UDim2.new(1, 0, 0, 10)
DragFill.Position = UDim2.new(0, 0, 1, -10)
DragFill.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
DragFill.BorderSizePixel = 0

local DragLabel = Instance.new("TextLabel", DragBar)
DragLabel.Size = UDim2.new(1, 0, 1, 0)
DragLabel.Text = "ModWare Hub"
DragLabel.TextColor3 = MainColor1
DragLabel.Font = Enum.Font.Code
DragLabel.TextSize = 18
DragLabel.BackgroundTransparency = 1
DragLabel.TextXAlignment = Enum.TextXAlignment.Left
DragLabel.Position = UDim2.new(0, 16, 0, 0)

local dragging, dragStart, startPos, activeTouchInput = false, nil, nil, nil

local dragBeganConn = DragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        activeTouchInput = input
    end
end)
table.insert(_G.ModWareConnections, dragBeganConn)

local inputChangedConn = UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == activeTouchInput or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
table.insert(_G.ModWareConnections, inputChangedConn)

local inputEndedConn = UserInputService.InputEnded:Connect(function(input) 
    if input == activeTouchInput or input.UserInputType == Enum.UserInputType.MouseButton1 then 
        dragging = false 
        activeTouchInput = nil
    end 
end)
table.insert(_G.ModWareConnections, inputEndedConn)

-- [ Coluna das Abas ]
local TabList = Instance.new("ScrollingFrame", MainFrame)
TabList.Size = UDim2.new(0, 120, 1, -55)
TabList.Position = UDim2.new(0, 10, 0, 45)
TabList.BackgroundTransparency = 1
TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabList.ScrollBarThickness = 0

local TabLayout = Instance.new("UIListLayout", TabList)
TabLayout.Padding = UDim.new(0, 8)

-- Container do Conteúdo
local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -145, 1, -55)
Container.Position = UDim2.new(0, 135, 0, 45)
Container.BackgroundTransparency = 1

local ActiveDropdownClose = nil

-- CreateTab
local function CreateTab(name)
    local TabBtn = Instance.new("TextButton", TabList)
    TabBtn.Size = UDim2.new(1, 0, 0, 32)
    TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.new(1, 1, 1)
    TabBtn.Font = Enum.Font.Code
    TabBtn.TextSize = 14

    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    
    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 12)
    
    local PagePadding = Instance.new("UIPadding", Page)
    PagePadding.PaddingLeft = UDim.new(0, 30)
    PagePadding.PaddingRight = UDim.new(0, 0)
    PagePadding.PaddingTop = UDim.new(0, 2)
    PagePadding.PaddingBottom = UDim.new(0, 0)

    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.ElasticBehavior = Enum.ElasticBehavior.Always
    Page.ScrollBarThickness = 0

    TabBtn.MouseButton1Click:Connect(function()
        if ActiveDropdownClose then ActiveDropdownClose() end
        for _, t in pairs(TabList:GetChildren()) do 
            if t:IsA("TextButton") then 
                t.BackgroundColor3 = Color3.fromRGB(25, 25, 25) 
                t.TextColor3 = Color3.new(1, 1, 1) 
            end 
        end
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        Page.Visible = true
        TabBtn.BackgroundColor3 = MainColor1
        TabBtn.TextColor3 = Color3.new(0, 0, 0)
    end)
    return Page
end

-- CreateButton
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 13
    Btn.Active = true
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return Btn
end

-- CreateTextbox (callback ao confirmar, sem disparar a cada tecla)
local function CreateTextbox(parent, text, placeholder, callback)
    local Frame = Instance.new("Frame")
    Frame.Name = "Textbox_" .. tostring(text)
    Frame.Parent = parent
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 10
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Size = UDim2.new(0.45, -5, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = tostring(text or "")
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    Label.TextTruncate = Enum.TextTruncate.AtEnd
    Label.ZIndex = 11

    local Box = Instance.new("TextBox")
    Box.Parent = Frame
    Box.Size = UDim2.new(0.52, -10, 0.7, 0)
    Box.Position = UDim2.new(0.47, 0, 0.15, 0)
    Box.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Box.BorderSizePixel = 0
    Box.Text = ""
    Box.PlaceholderText = tostring(placeholder or "Digite aqui...")
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    Box.Font = Enum.Font.Code
    Box.TextSize = 12
    Box.ClearTextOnFocus = false
    Box.TextXAlignment = Enum.TextXAlignment.Left
    Box.ZIndex = 11
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    local padding = Instance.new("UIPadding", Box)
    padding.PaddingLeft = UDim.new(0, 6)
    padding.PaddingRight = UDim.new(0, 6)

    local submitting = false
    local function FireCallback()
        if submitting then return end
        submitting = true
        local rawText = Box.Text
        if callback then
            task.spawn(function()
                local ok, err = pcall(callback, rawText)
                if not ok then warn("[ModWare] Textbox callback error:", err) end
            end)
        end
        task.defer(function() submitting = false end)
    end

    Box.FocusLost:Connect(function(enterPressed)
        FireCallback()
    end)
    return Frame, Box
end

-- CreateDropdown
local function CreateDropdown(parent, title, options, defaultSelections, isMulti, callback)
    options = (type(options) == "table" and #options > 0) and options or {"None"}
    local selectedTable = {}
    if isMulti then
        if type(defaultSelections) == "table" then
            for _, v in ipairs(defaultSelections) do selectedTable[v] = true end
        elseif defaultSelections ~= nil then
            selectedTable[defaultSelections] = true
        end
    else
        local def = defaultSelections
        if type(def) == "table" then def = def[1] end
        def = def or options[1] or "None"
        selectedTable[def] = true
    end

    local isOpen = false
    local optionListFrame
    local dropdownObj = {}

    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Parent = parent
    DropdownFrame.Size = UDim2.new(1, 0, 0, 38)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.ZIndex = 100

    local MainButton = Instance.new("TextButton")
    MainButton.Parent = DropdownFrame
    MainButton.Size = UDim2.new(1, 0, 0, 38)
    MainButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainButton.BorderSizePixel = 0
    MainButton.ZIndex = 101
    MainButton.TextWrapped = false
    MainButton.TextTruncate = Enum.TextTruncate.AtEnd
    MainButton.AutoButtonColor = true
    MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainButton.TextXAlignment = Enum.TextXAlignment.Left
    MainButton.Font = Enum.Font.Code
    MainButton.TextSize = 13
    Instance.new("UICorner", MainButton).CornerRadius = UDim.new(0, 6)
    local MainPadding = Instance.new("UIPadding", MainButton)
    MainPadding.PaddingLeft = UDim.new(0, 10)
    MainPadding.PaddingRight = UDim.new(0, 35)
    local MainStroke = Instance.new("UIStroke", MainButton)
    MainStroke.Color = Color3.fromRGB(45, 45, 45)
    MainStroke.Thickness = 1

    local Arrow = Instance.new("TextLabel")
    Arrow.Parent = MainButton
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.AnchorPoint = Vector2.new(1, 0)
    Arrow.Position = UDim2.new(1, 0, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    Arrow.Font = Enum.Font.Code
    Arrow.TextSize = 12
    Arrow.ZIndex = 102

    local function UpdateButtonText()
        if isMulti then
            local chosen = {}
            for _, option in ipairs(options) do
                if selectedTable[option] then table.insert(chosen, option) end
            end
            if #chosen == 0 then
                MainButton.Text = tostring(title) .. ": None"
            elseif #chosen == #options then
                MainButton.Text = tostring(title) .. ": All"
            elseif #chosen > 2 then
                MainButton.Text = tostring(title) .. ": " .. #chosen .. " Selected"
            else
                MainButton.Text = tostring(title) .. ": " .. table.concat(chosen, ", ")
            end
        else
            local chosen = "None"
            for _, option in ipairs(options) do
                if selectedTable[option] then chosen = option break end
            end
            MainButton.Text = tostring(title) .. ": " .. tostring(chosen)
        end
    end

    local function FireSelectionCallback()
        if not callback then return end
        if isMulti then
            local list = {}
            for _, option in ipairs(options) do
                if selectedTable[option] then table.insert(list, option) end
            end
            task.spawn(function()
                local ok, err = pcall(callback, list)
                if not ok then warn("[ModWare] Dropdown callback error:", err) end
            end)
        else
            local chosen = options[1]
            for _, option in ipairs(options) do
                if selectedTable[option] then chosen = option break end
            end
            task.spawn(function()
                local ok, err = pcall(callback, chosen)
                if not ok then warn("[ModWare] Dropdown callback error:", err) end
            end)
        end
    end

    local function CloseDropdown()
        if not isOpen then return end
        isOpen = false
        Arrow.Text = "▼"
        if ActiveDropdownClose == CloseDropdown then ActiveDropdownClose = nil end
        if optionListFrame then optionListFrame:Destroy(); optionListFrame = nil end
    end

    local currentFilter = ""
    local function renderOptions(container, optionButtons, filterText)
        currentFilter = tostring(filterText or "")
        for _, btn in ipairs(optionButtons) do
            if btn and btn.Parent then btn:Destroy() end
        end
        table.clear(optionButtons)
        local yOffset = 0
        local filter = string.lower(filterText or "")
        for _, option in ipairs(options) do
            if filter == "" or string.find(string.lower(tostring(option)), filter, 1, true) then
                local OptButton = Instance.new("TextButton")
                OptButton.Parent = container
                OptButton.Size = UDim2.new(1, 0, 0, 32)
                OptButton.Position = UDim2.new(0, 0, 0, yOffset)
                OptButton.BackgroundTransparency = 1
                OptButton.ZIndex = 10002
                OptButton.Text = (selectedTable[option] and "✓  " or "    ") .. tostring(option)
                OptButton.Font = Enum.Font.Code
                OptButton.TextSize = 13
                OptButton.TextXAlignment = Enum.TextXAlignment.Left
                OptButton.TextColor3 = selectedTable[option] and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,150)
                local pad = Instance.new("UIPadding", OptButton)
                pad.PaddingLeft = UDim.new(0, 10)
                OptButton.MouseButton1Click:Connect(function()
                    if isMulti then
                        selectedTable[option] = not selectedTable[option]
                        UpdateButtonText()
                        FireSelectionCallback()
                        renderOptions(container, optionButtons, currentFilter)
                    else
                        table.clear(selectedTable)
                        selectedTable[option] = true
                        UpdateButtonText()
                        FireSelectionCallback()
                        CloseDropdown()
                    end
                end)
                table.insert(optionButtons, OptButton)
                yOffset += 32
            end
        end
        container.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    end

    MainButton.MouseButton1Click:Connect(function()
        if isOpen then CloseDropdown(); return end
        if ActiveDropdownClose then ActiveDropdownClose() end
        isOpen = true
        Arrow.Text = "▲"
        ActiveDropdownClose = CloseDropdown

        optionListFrame = Instance.new("Frame")
        optionListFrame.Parent = DropdownFrame
        optionListFrame.Size = UDim2.new(1, 0, 0, 192)
        optionListFrame.Position = UDim2.new(0, 0, 1, 4)
        optionListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        optionListFrame.BorderSizePixel = 0
        optionListFrame.ZIndex = 9999
        optionListFrame.ClipsDescendants = true
        Instance.new("UICorner", optionListFrame).CornerRadius = UDim.new(0, 6)
        local stroke = Instance.new("UIStroke", optionListFrame)
        stroke.Color = Color3.fromRGB(50, 50, 50)
        stroke.Thickness = 1

        local SearchBox = Instance.new("TextBox")
        SearchBox.Parent = optionListFrame
        SearchBox.Size = UDim2.new(1, 0, 0, 32)
        SearchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        SearchBox.BorderSizePixel = 0
        SearchBox.ZIndex = 10001
        SearchBox.PlaceholderText = "Pesquisar opção..."
        SearchBox.Text = ""
        SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
        SearchBox.Font = Enum.Font.Code
        SearchBox.TextSize = 12
        SearchBox.ClearTextOnFocus = false
        local searchPadding = Instance.new("UIPadding", SearchBox)
        searchPadding.PaddingLeft = UDim.new(0, 10)

        local OptionsContainer = Instance.new("ScrollingFrame")
        OptionsContainer.Parent = optionListFrame
        OptionsContainer.Size = UDim2.new(1, 0, 1, -32)
        OptionsContainer.Position = UDim2.new(0, 0, 0, 32)
        OptionsContainer.BackgroundTransparency = 1
        OptionsContainer.BorderSizePixel = 0
        OptionsContainer.ZIndex = 10000
        OptionsContainer.ScrollBarThickness = 3
        OptionsContainer.CanvasSize = UDim2.new()
        local layout = Instance.new("UIListLayout", OptionsContainer)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        local optionButtons = {}
        renderOptions(OptionsContainer, optionButtons, "")
        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            if isOpen and optionListFrame and optionListFrame.Parent then
                renderOptions(OptionsContainer, optionButtons, SearchBox.Text)
            end
        end)
    end)

    function dropdownObj:Refresh(newOptions)
        options = (type(newOptions) == "table" and #newOptions > 0) and newOptions or {"None"}
        local filtered = {}
        for key, value in pairs(selectedTable) do
            if value then
                for _, opt in ipairs(options) do
                    if opt == key then filtered[key] = true end
                end
            end
        end
        selectedTable = filtered
        local hasSelection = next(selectedTable) ~= nil
        if not isMulti and not hasSelection then selectedTable[options[1]] = true end
        UpdateButtonText()
        if isOpen then CloseDropdown() end
    end

    UpdateButtonText()
    return dropdownObj
end

-- Create Slider: aceita chamadas antigas com callback ou step opcional.
local SliderCallbacks = {}

local function CreateSlider(parent, text, min, max, default, globalOrStep, stepOrCb, callback)
    local globalName, step, cb
    if type(globalOrStep) == "string" then
        globalName = globalOrStep
        if type(stepOrCb) == "number" then
            step, cb = stepOrCb, callback
        else
            step, cb = 1, stepOrCb or callback
        end
    elseif type(globalOrStep) == "function" then
        step, cb = 1, globalOrStep
    elseif type(globalOrStep) == "number" then
        step = globalOrStep
        cb = (type(stepOrCb) == "function" and stepOrCb) or callback
    else
        step, cb = 1, (type(stepOrCb) == "function" and stepOrCb) or callback
    end

    min, max = tonumber(min) or 0, tonumber(max) or 100
    if max < min then min, max = max, min end
    step = math.abs(tonumber(step) or 1)
    if step == 0 then step = 1 end
    default = tonumber(default) or min
    if globalName then
        if _G[globalName] ~= nil then default = tonumber(_G[globalName]) or default
        else _G[globalName] = default end
    end
    default = math.clamp(default, min, max)

    local SFrame = Instance.new("Frame")
    SFrame.Parent = parent
    SFrame.Size = UDim2.new(1, 0, 0, 48)
    SFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SFrame.Active = true
    SFrame.ZIndex = 10
    Instance.new("UICorner", SFrame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Parent = SFrame
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    Label.ZIndex = 11

    local Track = Instance.new("Frame")
    Track.Parent = SFrame
    Track.Size = UDim2.new(1, -20, 0, 6)
    Track.Position = UDim2.new(0, 10, 0, 32)
    Track.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Track.Active = true
    Track.ZIndex = 11
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Parent = Track
    Fill.BackgroundColor3 = MainColor1
    Fill.ZIndex = 12
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame")
    Knob.Parent = Track
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Active = true
    Knob.ZIndex = 13
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local decimalPlaces = 0
    if step < 1 then
        local str = string.format("%.8f", step):gsub("0+$", "")
        decimalPlaces = #(str:match("%.(%d+)") or "")
    end
    local function SetSliderValue(value, fireCb)
        value = math.clamp(tonumber(value) or min, min, max)
        local stepped = min + math.floor((value - min) / step + 0.5) * step
        stepped = math.clamp(stepped, min, max)
        local formatted = tonumber(string.format("%." .. decimalPlaces .. "f", stepped)) or min
        local ratio = (max == min) and 0 or math.clamp((formatted - min) / (max - min), 0, 1)
        Knob.Position = UDim2.new(ratio, 0, 0.5, 0)
        Fill.Size = UDim2.new(ratio, 0, 1, 0)
        Label.Text = tostring(text) .. ": " .. tostring(formatted)
        if globalName then _G[globalName] = formatted end
        if fireCb and cb then
            task.spawn(function()
                local ok, err = pcall(cb, formatted)
                if not ok then warn("[ModWare] Slider callback error:", err) end
            end)
        end
    end

    if globalName then
        SliderCallbacks[globalName] = function(value) SetSliderValue(value, true) end
    end
    local sliding = false
    local activeTouch
    local function Move(input)
        if Track.AbsoluteSize.X <= 0 then return end
        local ratio = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        SetSliderValue(min + (max - min) * ratio, true)
    end
    local function BeginSlide(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            activeTouch = input
            Move(input)
        end
    end
    Track.InputBegan:Connect(BeginSlide)
    Knob.InputBegan:Connect(BeginSlide)
    SFrame.InputBegan:Connect(BeginSlide)
    local ended = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input == activeTouch then
            sliding = false
            activeTouch = nil
        end
    end)
    table.insert(_G.ModWareConnections, ended)
    local changed = UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Move(input)
        end
    end)
    table.insert(_G.ModWareConnections, changed)
    SetSliderValue(default, false)
    return SFrame
end

-- Create Toggle
local ToggleCallbacks = {}

local function CreateToggle(parent, text, desc, global, callback)
    if type(global) == "function" then
        callback, global, desc = global, desc, nil
    elseif type(desc) == "function" then
        callback, global, desc = desc, global, nil
    end
    if type(global) ~= "string" then
        global = tostring(text):gsub("%W", "") .. "Enabled"
    end
    if _G[global] == nil then _G[global] = false end

    local TFrame = Instance.new("Frame")
    TFrame.Parent = parent
    TFrame.Size = UDim2.new(1, 0, 0, 38)
    TFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TFrame.Active = true
    TFrame.ZIndex = 10
    Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Parent = TFrame
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = tostring(text or "")
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextTruncate = Enum.TextTruncate.AtEnd
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    Label.ZIndex = 11

    local Switch = Instance.new("TextButton")
    Switch.Parent = TFrame
    Switch.Size = UDim2.new(0, 46, 0, 22)
    Switch.AnchorPoint = Vector2.new(1, 0.5)
    Switch.Position = UDim2.new(1, -8, 0.5, 0)
    Switch.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Switch.BorderSizePixel = 0
    Switch.Text = ""
    Switch.AutoButtonColor = false
    Switch.ZIndex = 12
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)
    local Stroke = Instance.new("UIStroke", Switch)
    Stroke.Color = Color3.fromRGB(120, 120, 120)
    Stroke.Thickness = 1

    local Knob = Instance.new("Frame")
    Knob.Parent = Switch
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, 3, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Knob.ZIndex = 13
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(0.5, 0)

    local currentState = _G[global] == true
    local function UpdateToggle(state, fireCallback)
        currentState = state == true
        _G[global] = currentState
        if currentState then
            Switch.BackgroundColor3 = MainColor1
            Stroke.Color = MainColor1
            Knob.BackgroundColor3 = MainColor
            Knob:TweenPosition(UDim2.new(1, -19, 0.5, -8), "Out", "Quad", 0.15, true)
        else
            Switch.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Stroke.Color = MainColor
            Knob.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            Knob:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.15, true)
        end
        if fireCallback and callback then
            task.spawn(function()
                local ok, err = pcall(callback, currentState)
                if not ok then warn("[ModWare] Toggle callback error:", err) end
            end)
        end
    end
    ToggleCallbacks[global] = function(value) UpdateToggle(value, true) end
    Switch.Activated:Connect(function()
        UpdateToggle(not currentState, true)
    end)
    UpdateToggle(currentState, false)
    return TFrame
end

-- CreateText
local function CreateText(parent, text, update, callback)
    local TFrame = Instance.new("Frame", parent)
    TFrame.Size = UDim2.new(1, 0, 0, 40)
    TFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TFrame.AutomaticSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", TFrame)
    Label.Size = UDim2.new(1, -10, 0, 0)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.AutomaticSize = Enum.AutomaticSize.Y
    Label.Text = text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    Label.TextWrapped = true

    if update then
        task.spawn(function()
            while Label.Parent do
                task.wait(0.1)
                local val = callback and callback() or ""
                Label.Text = text .. ": " .. tostring(val)
            end
        end)
    end
end

-- Keybind & Physics
local jumpConn = UserInputService.JumpRequest:Connect(function() if _G.InfJump and lp.Character then lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)
table.insert(_G.ModWareConnections, jumpConn)

local noclipConn = RunService.Stepped:Connect(function() if _G.Noclip and lp.Character then for _, v in pairs(lp.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end)
table.insert(_G.ModWareConnections, noclipConn)

-- CreateKeybind
local function CreateKeybind(parent, text, defaultKey, globalName, callback)
    local KFrame = Instance.new("Frame", parent)
    KFrame.Size = UDim2.new(1, 0, 0, 35)
    KFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", KFrame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", KFrame)
    Label.Size = UDim2.new(0.7, -10, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13

    local Box = Instance.new("TextButton", KFrame)
    Box.Size = UDim2.new(0.3, -10, 0, 23)
    Box.Position = UDim2.new(0.7, 0, 0.5, -11)
    Box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Box.Text = defaultKey.Name
    Box.TextColor3 = Color3.new(1, 1, 1)
    Box.Font = Enum.Font.Code
    Box.TextSize = 13
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)

    _G[globalName] = defaultKey

    Box.MouseButton1Click:Connect(function()
        Box.Text = "Press a key..."
        local conn
        conn = UserInputService.InputBegan:Connect(function(input, processed)
            if not processed and input.UserInputType == Enum.UserInputType.Keyboard then
                _G[globalName] = input.KeyCode
                Box.Text = input.KeyCode.Name
                if callback then callback(input.KeyCode) end
                conn:Disconnect()
            end
        end)
    end)
end

-- Botão Flutuante (Toggle)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 80, 0, 40)
OpenBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
OpenBtn.Text = "TOGGLE"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Font = Enum.Font.Code
OpenBtn.TextSize = 18
OpenBtn.Active = true
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

local dragBtn, dragStartBtn, startPosBtn, touchInputObject, isDragging = false, nil, nil, nil, false
OpenBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragBtn = true; isDragging = false; dragStartBtn = input.Position; startPosBtn = OpenBtn.Position; touchInputObject = input
    end
end)

local oChanged = UserInputService.InputChanged:Connect(function(input)
    if dragBtn and (input == touchInputObject or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStartBtn
        if delta.Magnitude > 5 then isDragging = true end
        if isDragging then OpenBtn.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y) end
    end
end)
table.insert(_G.ModWareConnections, oChanged)

local oEnded = UserInputService.InputEnded:Connect(function(input)
    if input == touchInputObject or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if dragBtn and not isDragging then MainFrame.Visible = not MainFrame.Visible end
        dragBtn = false; isDragging = false; touchInputObject = nil
    end
end)
table.insert(_G.ModWareConnections, oEnded)

local keyToggleConn = UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == _G.HubKeybind then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
table.insert(_G.ModWareConnections, keyToggleConn)

-- Send Notify
function SendNotify(title, message, duration)
    local frame = Instance.new("Frame", ScreenGui)
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, -10, 0.5, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.Code
    titleLabel.TextSize = 15
    titleLabel.Text = title

    local msgLabel = Instance.new("TextLabel", frame)
    msgLabel.Size = UDim2.new(1, -10, 0.5, -5)
    msgLabel.Position = UDim2.new(0, 10, 0.5, 0)
    msgLabel.BackgroundTransparency = 1
    msgLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    msgLabel.Font = Enum.Font.Code
    msgLabel.TextSize = 13
    msgLabel.Text = message

    frame.Position = UDim2.new(0.5, -150, 0, -100)
    frame:TweenPosition(UDim2.new(0.5, -150, 0, 20), "Out", "Quad", 0.4, true)

    task.delay(duration or 3, function()
        if frame and frame.Parent then
            frame:TweenPosition(UDim2.new(0.5, -150, 0, -100), "In", "Quad", 0.4, true)
            task.wait(0.5)
            frame:Destroy()
        end
    end)
end

SendNotify("ModWare Hub", "Hi", 3)

-- [ ModWare Tabs ]
local SettingsTab = CreateTab("Settings")
local PlayerTab = CreateTab("PlayerStats")
local AutomationTab = CreateTab("Automation")
local FarmTab = CreateTab("Farming")
local CombatTab = CreateTab("Combat")
local VisualTab = CreateTab("Visual")
local MoveTab = CreateTab("Move")
local MiscTab = CreateTab("Misc")
local ConfigTab = CreateTab("Config")

-- Unload
local function UnloadHub()
    if _G.ModWareConnections then
        for _, conn in ipairs(_G.ModWareConnections) do
            if typeof(conn) == "RBXScriptConnection" and conn.Connected then
                conn:Disconnect()
            end
        end
    end
    _G.ModWareConnections = {}

    if lp and lp.Character then
        local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.AutoRotate = true
        end
    end

    for key, _ in pairs(_G) do
        if type(key) == "string" and key ~= "HubKeybind" then
            _G[key] = nil
        end
    end

    if ScreenGui then
        ScreenGui:Destroy()
    end
end

local UnloadBtn = Instance.new("TextButton", SettingsTab)
UnloadBtn.Size = UDim2.new(1, 0, 0, 38)
UnloadBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
UnloadBtn.Text = "CLOSE ALL SCRIPT"
UnloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnloadBtn.Font = Enum.Font.Code
UnloadBtn.TextSize = 14
UnloadBtn.Active = true
Instance.new("UICorner", UnloadBtn).CornerRadius = UDim.new(0, 6)

UnloadBtn.MouseButton1Click:Connect(function()
    UnloadHub()
end)

-- Compact Gui
_G.CompactGui = false
CreateToggle(SettingsTab, "COMPACT GUI", "CompactGui", function(state)
    _G.CompactGui = state
    if state then
        MainFrame:TweenSize(UDim2.new(0, 440, 0, 320), "Out", "Quad", 0.4, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 600, 0, 460), "Out", "Quad", 0.4, true)
    end
end)

-- Gui Transparency
_G.EnableTransparency = false
CreateToggle(SettingsTab, "Gui Transparency", "EnableTransparency", function(state)
    _G.EnableTransparency = state
    if state then
        MainFrame.BackgroundTransparency = _G.TransparencyN
    else
        MainFrame.BackgroundTransparency = 0
    end
end)

CreateSlider(SettingsTab, "Transparency", 0, 0.5, 0.1, "TransparencyN", 0.1, function(val)
    _G.TransparencyN = val
    if _G.EnableTransparency then
        MainFrame.BackgroundTransparency = _G.TransparencyN
    end
end)

-- Keybind
CreateKeybind(SettingsTab, "HUB KEYBIND", Enum.KeyCode.Q, "HubKeybind", function(newKey)
    print("HUB NEW KEYBIND:", newKey.Name)
end)

-- Anti afk
_G.AntiAFK = true
CreateToggle(SettingsTab, "ANTI-AFK", "AntiAFK", function(state)
    if state then
        _G.AFKConnection = lp.Idled:Connect(function()
            VIM:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
            task.wait(0.5)
            VIM:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
        end)
        table.insert(_G.ModWareConnections, _G.AFKConnection)
    else
        if _G.AFKConnection then _G.AFKConnection:Disconnect() end
    end
end)

-- Full bright
_G.FullbrightEnabled = false
local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalBrightness = Lighting.Brightness
local originalShadows = Lighting.GlobalShadows

task.spawn(function()
    while true do
        task.wait(0.1)
        if not ScreenGui or not ScreenGui.Parent then break end
        if _G.FullbrightEnabled then
            pcall(function()
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                Lighting.Brightness = 3
                Lighting.GlobalShadows = false
            end)
        end
    end
end)

CreateToggle(SettingsTab, "FULLBRIGHT", "FullbrightEnabled", function(state)
    _G.FullbrightEnabled = state
    if not state then
        pcall(function()
            Lighting.Ambient = originalAmbient
            Lighting.OutdoorAmbient = originalOutdoorAmbient
            Lighting.Brightness = originalBrightness
            Lighting.GlobalShadows = originalShadows
        end)
    end
end)

-- Stats
CreateText(SettingsTab, "Physic FPS", true, function() return math.floor(workspace:GetRealPhysicsFPS()) end)
CreateText(SettingsTab, "Date", true, function() return os.date("%d/%m/%Y") end)
CreateText(SettingsTab, "Clock", true, function() return os.date("%H:%M:%S") end)
CreateText(SettingsTab, "Player Count", true, function() return #Players:GetPlayers() end)
CreateText(SettingsTab, "Nickname", true, function() return lp.Name end)
CreateText(SettingsTab, "Display Name", true, function() return lp.DisplayName end)
CreateText(SettingsTab, "Account Age", true, function() return lp.AccountAge .. " Days" end)
CreateText(SettingsTab, "User ID", true, function() return lp.UserId end)
CreateText(SettingsTab, "Membership", true, function() return lp.MembershipType.Name end)
CreateText(SettingsTab, "Server ID", true, function() return game.JobId end)

-- Configs
local currentConfigName = "default"
local selectedConfigInDropdown = "None"
local autoloadConfig = ""

local function GetSavedConfigsList()
    local files = {}
    if listfiles then
        pcall(function()
            for _, f in ipairs(listfiles("")) do
                local name = f:match("ModWare_Config_([%w_]+)%.json$")
                if name then
                    table.insert(files, name)
                end
            end
        end)
    end
    if #files == 0 then table.insert(files, "None") end
    return files
end

CreateTextbox(ConfigTab, "Config Name", "Text", function(val)
    if type(val) == "string" and val ~= "" then
        currentConfigName = val
    end
end)

local configDropdown = CreateDropdown(ConfigTab, "Config List", GetSavedConfigsList(), "None", false, function(chosen)
    selectedConfigInDropdown = chosen
end)

local function RefreshConfigList()
    local newList = GetSavedConfigsList()
    configDropdown:Refresh(newList)
end

CreateButton(ConfigTab, "Create", function()
    pcall(function()
        if writefile then
            local data = {}
            for k, v in pairs(_G) do
                if type(v) == "boolean" or type(v) == "number" then
                    data[k] = v
                end
            end
            writefile("ModWare_Config_" .. currentConfigName .. ".json", HttpService:JSONEncode(data))
            SendNotify("ModWare Hub", "Config '" .. currentConfigName .. "' Created!", 3)
            RefreshConfigList()
        end
    end)
end)

CreateButton(ConfigTab, "Save", function()
    pcall(function()
        local targetName = (selectedConfigInDropdown ~= "None" and selectedConfigInDropdown) or currentConfigName
        if writefile then
            local data = {}
            for k, v in pairs(_G) do
                if type(v) == "boolean" or type(v) == "number" then
                    data[k] = v
                end
            end
            writefile("ModWare_Config_" .. targetName .. ".json", HttpService:JSONEncode(data))
            SendNotify("ModWare Hub", "Config '" .. targetName .. "' Saved!", 3)
            RefreshConfigList()
        end
    end)
end)

CreateButton(ConfigTab, "Load", function()
    pcall(function()
        local targetName = (selectedConfigInDropdown ~= "None" and selectedConfigInDropdown) or currentConfigName
        local fileName = "ModWare_Config_" .. targetName .. ".json"
        if readfile and isfile and isfile(fileName) then
            local decoded = HttpService:JSONDecode(readfile(fileName))
            for k, v in pairs(decoded) do
                _G[k] = v
                if ToggleCallbacks[k] then
                    ToggleCallbacks[k](v)
                end
                if SliderCallbacks[k] then
                    SliderCallbacks[k](v)
                end
            end
            SendNotify("ModWare Hub", "Config '" .. targetName .. "' Loaded!", 3)
        else
            SendNotify("ModWare Hub", "Config Error", 3)
        end
    end)
end)

CreateButton(ConfigTab, "Delete ( Config )", function()
    pcall(function()
        local targetName = selectedConfigInDropdown
        if targetName and targetName ~= "None" then
            local fileName = "ModWare_Config_" .. targetName .. ".json"
            if delfile and isfile and isfile(fileName) then
                delfile(fileName)
                SendNotify("ModWare Hub", "Config '" .. targetName .. "' deleted!", 3)
                RefreshConfigList()
            end
        end
    end)
end)

CreateButton(ConfigTab, "Update Configs", function()
    RefreshConfigList()
    SendNotify("ModWare Hub", "List Updated", 2)
end)

CreateButton(ConfigTab, "Set Autoload", function()
    pcall(function()
        if selectedConfigInDropdown and selectedConfigInDropdown ~= "None" then
            autoloadConfig = selectedConfigInDropdown
            if writefile then
                writefile("ModWare_Autoload.txt", autoloadConfig)
                SendNotify("ModWare Hub", "AutoLoad For: " .. autoloadConfig, 3)
            end
        end
    end)
end)

-- Auto loads
task.spawn(function()
    pcall(function()
        if readfile and isfile and isfile("ModWare_Autoload.txt") then
            local autoName = readfile("ModWare_Autoload.txt")
            local fileName = "ModWare_Config_" .. autoName .. ".json"
            if isfile(fileName) then
                task.wait(0.5)
                local decoded = HttpService:JSONDecode(readfile(fileName))
                for k, v in pairs(decoded) do
                    _G[k] = v
                    if ToggleCallbacks[k] then
                        ToggleCallbacks[k](v)
                    end
                    if SliderCallbacks[k] then
                        SliderCallbacks[k](v)
                    end
                end
                SendNotify("ModWare Hub", "AutoLoad Enabled  (" .. autoName .. ")!", 3)
            end
        end
    end)
end)

-- tudo do orbit
_G.AutoWalkCritters = false
_G.CrittersDistance = 5
_G.CrittersSpeed = 16
_G.OrbitClockwise = false
_G.MovementMode = 2

_G.AutoDodgeArrow = true

local orbitTarget = nil
local targetTimer = 0

local savedHumanoid = nil
local savedSpeed = nil
local savedAutoRotate = nil

local orbitBinding = "Modders_CrittersOrbit"
local dodgingArrow = false
local shockwaveCooldown = false

local function RestoreOrbitCharacter()
    if savedHumanoid and savedHumanoid.Parent then
        savedHumanoid:Move(Vector3.zero, false)
        savedHumanoid.WalkSpeed = savedSpeed
        savedHumanoid.AutoRotate = savedAutoRotate
    end

    savedHumanoid = nil
    savedSpeed = nil
    savedAutoRotate = nil
end


CreateToggle(MoveTab, "Orbit Enemies", "AutoWalkCritters", "Type 1 = tween, Type 2 = Walk, Type 3 = Cframe", function(state)
    _G.AutoWalkCritters = state
    orbitTarget = nil
    targetTimer = 0

    if not state then
        RestoreOrbitCharacter()
    end
end)

CreateToggle(MoveTab, "Dodge Arrow", "AutoDodgeArrow", function(state)
    _G.AutoDodgeArrow = state
end)

CreateSlider(MoveTab, "Move Type", 1, 3, 2, function(value)
    _G.MovementMode = value
end)

CreateSlider(MoveTab, "Move Speed", 1, 20, 16, 0.50, function(value)
    _G.CrittersSpeed = value
end)

CreateSlider(MoveTab, "Orbit Range", 1, 20, 5, function(value)
    _G.CrittersDistance = value
end)

local function GetOrbitRoot(model)
    local root = model:FindFirstChild("HumanoidRootPart", true)
    if root and root:IsA("BasePart") then
        return root
    end
    return model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
end

local function IsOrbitTargetValid(model, folder)
    if not model or not folder or not model:IsA("Model") or not model:IsDescendantOf(folder) then
        return false
    end
    local humanoid = model:FindFirstChildWhichIsA("Humanoid", true)
    return (not humanoid or humanoid.Health > 0) and GetOrbitRoot(model) ~= nil
end

local function CheckProjectiles(root)
    local projectilesFolder = workspace:FindFirstChild("Projectiles")
    if not projectilesFolder then return end

    for _, obj in ipairs(projectilesFolder:GetChildren()) do
        local part = obj:IsA("Model") and GetOrbitRoot(obj) or (obj:IsA("BasePart") and obj)
        if part then
            local dist = (part.Position - root.Position).Magnitude

            if obj.Name == "Shockwave" and dist < 12 then
                if not shockwaveCooldown then
                    shockwaveCooldown = true
                    _G.OrbitClockwise = not _G.OrbitClockwise
                    
                    task.spawn(function()
                        task.wait(1.2)
                        shockwaveCooldown = false
                    end)
                end

            elseif obj.Name == "Arrow" and dist < 15 and _G.AutoDodgeArrow and not dodgingArrow then
                dodgingArrow = true
                task.spawn(function()
                    local oldCFrame = root.CFrame
                    local randomSideOffset = (root.CFrame.RightVector * (math.random(0, 1) == 1 and 3 or -3))
                    root.CFrame = oldCFrame + randomSideOffset
                    
                    task.wait(0.12)
                    
                    if root and oldCFrame then
                        root.CFrame = oldCFrame
                    end
                    
                    task.wait(0.2)
                    dodgingArrow = false
                end)
            end
        end
    end
end

RunService:UnbindFromRenderStep(orbitBinding)

RunService:BindToRenderStep(
    orbitBinding,
    Enum.RenderPriority.Character.Value + 1,
    function(dt)
        if not _G.AutoWalkCritters then
            if savedHumanoid then
                RestoreOrbitCharacter()
            end
            return
        end

        local character = lp.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")

        if not humanoid or not root or humanoid.Health <= 0 then
            RestoreOrbitCharacter()
            return
        end

        if savedHumanoid ~= humanoid then
            RestoreOrbitCharacter()
            savedHumanoid = humanoid
            savedSpeed = humanoid.WalkSpeed
            savedAutoRotate = humanoid.AutoRotate
        end

        humanoid.WalkSpeed = math.clamp(_G.CrittersSpeed, 1, 20)
        humanoid.AutoRotate = false

        local folder = workspace:FindFirstChild("Critters")
        if not folder then
            orbitTarget = nil
            humanoid:Move(Vector3.zero, false)
            return
        end

        targetTimer -= dt

        if targetTimer <= 0 or not IsOrbitTargetValid(orbitTarget, folder) then
            targetTimer = 0.1
            local nearest = nil
            local shortest = math.huge

            for _, model in ipairs(folder:GetChildren()) do
                if IsOrbitTargetValid(model, folder) then
                    local part = GetOrbitRoot(model)
                    local distance = (part.Position - root.Position).Magnitude
                    if distance < shortest then
                        shortest = distance
                        nearest = model
                    end
                end
            end
            orbitTarget = nearest
        end

        if not IsOrbitTargetValid(orbitTarget, folder) then
            humanoid:Move(Vector3.zero, false)
            return
        end

        local enemyRoot = GetOrbitRoot(orbitTarget)
        local enemyPosition = enemyRoot.Position

        local lookPosition = Vector3.new(enemyPosition.X, root.Position.Y, enemyPosition.Z)
        if (lookPosition - root.Position).Magnitude > 0.01 then
            root.CFrame = CFrame.lookAt(root.Position, lookPosition)
        end

        CheckProjectiles(root)

        local difference = root.Position - enemyPosition
        local horizontal = Vector3.new(difference.X, 0, difference.Z)
        local distance = horizontal.Magnitude
        local radius = math.clamp(_G.CrittersDistance, 1, 20)

        local outward = distance > 0.01 and horizontal.Unit or Vector3.new(1, 0, 0)
        
        local tangent
        if _G.OrbitClockwise then
            tangent = Vector3.new(outward.Z, 0, -outward.X)
        else
            tangent = Vector3.new(-outward.Z, 0, outward.X)
        end

        local radiusError = distance - radius
        local movement

        if radiusError > math.max(4, radius * 0.75) then
            movement = -outward
        else
            local correction = math.clamp(radiusError * 1.5, -3, 3)
            movement = tangent - outward * correction
        end

        local speed = math.clamp(_G.CrittersSpeed, 1, 20)

        if _G.MovementMode == 1 then
            local targetPos = root.Position + (movement.Unit * (speed * dt))
            local tweenInfo = TweenInfo.new(dt, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos, lookPosition)})
            tween:Play()

        elseif _G.MovementMode == 2 then
            humanoid:Move(movement.Unit, false)

        elseif _G.MovementMode == 3 then
            local targetPos = root.Position + (movement.Unit * (speed * dt))
            root.CFrame = CFrame.new(targetPos, lookPosition)
        end
    end
)

ScreenGui.Destroying:Connect(function()
    _G.AutoWalkCritters = false
    RunService:UnbindFromRenderStep(orbitBinding)
    RestoreOrbitCharacter()
end)

-- Auto hits
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

local rendering = require(ReplicatedStorage:WaitForChild("Game"):WaitForChild("rendering"))
local interpolationBuffer = require(ReplicatedStorage:WaitForChild("Game"):WaitForChild("rendering"):WaitForChild("interpolationBuffer"))
local Packets = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Packets"))

local function getServerTime()
    local ok, res = pcall(function()
        return require(ReplicatedStorage.Modules.Clock).getServerTime(true)
    end)
    return ok and res or tick()
end

--// CONFIGURAÇÕES
_G.AutosHit = false
_G.AutosHitRange = 20
_G.AutosSelectedTargets = {"Resources"} -- Padrão inicial como tabela

local autoHitOptions = {
    "Critters",
    "Deployables",
    "Resources",
    "Dropped Chests",
    "Rubble"
}

CreateToggle(AutomationTab, "Auto Hit: ", "AutosHit", function(state)
    _G.AutosHit = state
end)

CreateDropdown(AutomationTab, "Targets", autoHitOptions, {"Resources"}, true, function(selected)
    if type(selected) == "table" then
        _G.AutosSelectedTargets = selected
    elseif type(selected) == "string" then
        _G.AutosSelectedTargets = {selected}
    else
        _G.AutosSelectedTargets = {"Resources"}
    end
end)

CreateSlider(AutomationTab, "Auto Hit Range", 5, 20, 20, 1, function(val)
    _G.AutosHitRange = val
end)

task.spawn(function()
    local lastHit = 0
    while true do
        task.wait(0.05)
        if not _G.AutosHit then continue end

        local success, err = pcall(function()
            local now = getServerTime()
            if now - lastHit < 0.05 then return end
            
            local char = lp.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local hits = {}
            local maxRange = _G.AutosHitRange or 20
            local selected = _G.AutosSelectedTargets or {}

            local function scanFolder(folderName)
                local folder = workspace:FindFirstChild(folderName)
                if not folder then return end

                for _, v in ipairs(folder:GetChildren()) do
                    if v:IsA("Model") then
                        local id = v:GetAttribute("EntityID")
                        local part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                        if id and part then
                            local dist = (root.Position - part.Position).Magnitude
                            if dist <= maxRange then
                                table.insert(hits, {
                                    entityID = id,
                                    buffer = interpolationBuffer.getBuffer(rendering.clientBuffer)
                                })
                            end
                        end
                    end
                end
            end

            local function scanWorkspace(modelName)
                for _, v in ipairs(workspace:GetChildren()) do
                    if v:IsA("Model") and v.Name == modelName then
                        local id = v:GetAttribute("EntityID")
                        local part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                        if id and part then
                            local dist = (root.Position - part.Position).Magnitude
                            if dist <= maxRange then
                                table.insert(hits, {
                                    entityID = id,
                                    buffer = interpolationBuffer.getBuffer(rendering.clientBuffer)
                                })
                            end
                        end
                    end
                end
            end

            for _, targetName in ipairs(selected) do
                scanWorkspace(targetName)
                if targetName == "Critters" then
                    scanFolder("Critters")
                elseif targetName == "Deployables" then
                    scanFolder("Deployables")
                    scanFolder("Totems")
                elseif targetName == "Resources" then
                    scanFolder("Resources")
                    scanFolder("Breakaway")
                    scanFolder("Mounds")
                    scanFolder("ScavengerMounds")
                    scanWorkspace("Crystal Meteor Core")
                    scanWorkspace("Crystal Meteor Rock")
                    scanWorkspace("Small Rock")
                    scanWorkspace("Meteor Core")
                    scanWorkspace("Meteor Rock")
                elseif targetName == "Dropped Chests" then
                    scanFolder("dropChests")
                elseif targetName == "Rubble" then
                    scanFolder("Rubble")
                end
            end

            if #hits > 0 then
                lastHit = now
                Packets.SwingTool.send({
                    entityIDs = hits,
                    cframe = char:GetPivot(),
                    timestamp = now
                })
            end
        end)

        if not success then
            warn("[AutoHit]:", err)
        end
    end
end)

-- ==========================================
-- auto pickup 
-- ==========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Packets = require(ReplicatedStorage.Modules.Packets)

-- Configurações Globais do Auto Pickup
_G.AutoPickup = false
_G.PickupAll = false
_G.AutoPickupChests = false
_G.ChestPickupAll = false
_G.ShowPickupAOE = false
_G.PickupRadius = 30
_G.MaxPickupCount = 1500

local pickupCount = 0

-- Tabela que guarda múltiplos itens selecionados com segurança
local Whitelist = {
    ["Gold"] = true
}

-- Opções do Dropdown
local ItemList = {
    "Gold",
    "Raw Gold",
    "Haunted Spirit",
    "Spirit Key",
    "Steel",
    "Wood",
    "Leaves",
    "Log",
    "Raw Iron",
    "Raw Magnetite",
    "Raw Adurite",
    "Adurite",
    "Ice Cube",
    "Crystal Chunk",
    "Stone",
    "Hide",
    "Pink Diamond",
    "Carrot",
    "Lemon",
    "Cooked Egg",
    "Coal",
    "Fire Hide",
    "Pumpkin",
    "Iron",
    "Magnetite",
    "Raw Pink Diamond",
    "Raw Fish",
    "Void Shard",
    "Obsidian",
    "Berry",
    "Jelly",
    "Rope",
    "Bluefruit",
    "Cooked Meat",
    "Raw Meat",
    "Wood Plank",
    "Essence",
    "Raw Emerald",
    "Bloodfruit",
    "Coin",
    "Void Essence",
    "Vine",
    "Sand",
    "Glass",
    "Scute",
    "Cooked Fish",
    "Raw Squid",
    "Cooked Squid",
    "Raw Crab",
    "Cooked Crab",
    "Raw Baracuda",
    "Cooked Baracuda",
    "Raw Eel",
    "Cooked Eel",
    "Raw Morsel",
    "Cooked Morsel",
    "Carrot",
    "Cloudberry",
    "Strawberry",
    "Lemon",
    "Orange",
    "Apple",
    "Strangefruit",
    "Barley",
    "Banana",
    "Mango",
    "Oddberry",
    "Coconut",
    "Pumpkins",
    "Sunfruit",
    "Frostfruit",
    "Blossom",
    "Watermelon",
    "Egg",
    "Fried Egg",
    "Bread",
    "Burger",
    "Pie",
    "Fruit Cake",
    "Cornbread",
    "Meat Sandwich",
    "Jelly Sandwich",
    "Corn Mush",
    "Grain Mush",
    "Fried Cactus",
    "Corn",
    "Cactus Bit",
    "Peeper Popsicle",
    "Frozen Pumpkin",
    "Prickly Pear",
    "Swiftness Potion",
    "Ice Potion",
    "Haste Potion",
    "Healing Potion",
    "Strength Potion",
    "Weakness Potion",
    "Harming Potion",
    "Poison Potion",
    "Fire Resistance Potion",
    "Coin Stack",
    "Tropical Fish",
    "Old Boot",
    "Raw Chomper",
    "Gold Fish",
    "Gold Squid",
    "Void Fish",
    "Jelly Salmon",
    "Glowfish",
    "Strangefish",
    "Flaming Chomper",
    "Worm",
    "Shrimp",
    "Coin2",
    "Emerald"
}

-- Pasta visual do AOE Range
local PickupAOEFolder = workspace:FindFirstChild("PickupAOE") or Instance.new("Folder")
PickupAOEFolder.Name = "PickupAOE"
PickupAOEFolder.Parent = workspace

local function updateRing(position, radius)
    PickupAOEFolder:ClearAllChildren()
    local segments = 40
    for i = 1, segments do
        local angle = (i / segments) * math.pi * 2
        local x = math.cos(angle) * radius
        local z = math.sin(angle) * radius
        
        local part = Instance.new("Part")
        part.Anchored = true
        part.CanCollide = false
        part.CanQuery = false
        part.CanTouch = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromHex("#000000")
        part.Transparency = 0.2
        part.Size = Vector3.new(0.3, 0.3, radius * 0.15)
        part.CFrame = CFrame.new(position + Vector3.new(x, 0.05, z)) * CFrame.Angles(0, -angle, 0)
        part.Parent = PickupAOEFolder
    end
end

-- Função de verificação blindada compatível com o nome exato dos itens
local function isItemWhitelisted(item)
    local itemName = item.Name
    local attrName = item:GetAttribute("ItemName") or item:GetAttribute("ItemID") or item:GetAttribute("Name")
    
    if Whitelist[itemName] then return true end
    if attrName and Whitelist[tostring(attrName)] then return true end
    
    -- Normalização caso haja diferença de maiúsculas/minúsculas ou espaços
    local cleanName = string.gsub(itemName, "%s+", ""):lower()
    for k, v in pairs(Whitelist) do
        if v and string.gsub(tostring(k), "%s+", ""):lower() == cleanName then
            return true
        end
    end
    
    return false
end

-- ==========================================
-- [ ELEMENTOS DA UI ]
-- ==========================================

CreateToggle(AutomationTab, "Auto Pickup Whitelist", "AutoPickup", function(state)
    _G.AutoPickup = state
end)

CreateToggle(AutomationTab, "Pickup ALL Items", "PickupAll", function(state)
    _G.PickupAll = state
end)

CreateToggle(AutomationTab, "Auto Pickup Chests", "AutoPickupChests", function(state)
    _G.AutoPickupChests = state
end)

CreateToggle(AutomationTab, "Chest Pickup ALL", "ChestPickupAll", function(state)
    _G.ChestPickupAll = state
end)

CreateToggle(AutomationTab, "Show Pickup Range", "ShowPickupAOE", function(state)
    _G.ShowPickupAOE = state
    if not state then PickupAOEFolder:ClearAllChildren() end
end)

CreateSlider(AutomationTab, "Pickup Radius", 5, 30, 30, 1, function(val)
    _G.PickupRadius = val
end)

-- Dropdown corrigido e blindado para tratar a lista de seleções múltiplas
CreateDropdown(AutomationTab, "Select Item to Whitelist", ItemList, {"Gold"}, true, function(selectedData)
    Whitelist = {}
    if type(selectedData) == "table" then
        for _, itemName in pairs(selectedData) do
            if type(itemName) == "string" then
                Whitelist[itemName] = true
            end
        end
    elseif type(selectedData) == "string" then
        Whitelist[selectedData] = true
    end
end)

-- ==========================================
-- [ LOOP PRINCIPAL DE COLETA ]
-- ==========================================

local lastReset = tick()
RunService.Heartbeat:Connect(function()
    if not Player.Character then return end
    
    if tick() - lastReset >= 1 then
        pickupCount = 0
        lastReset = tick()
    end
    
    local charPos = Player.Character:GetPivot().Position
    
    -- Coleta no Workspace (Items)
    if workspace:FindFirstChild("Items") then
        for _, item in pairs(workspace.Items:GetChildren()) do
            if pickupCount >= _G.MaxPickupCount then break end
            local entityID = item:GetAttribute("EntityID")
            if not entityID then continue end
            
            local distance = (charPos - item:GetPivot().Position).Magnitude
            if distance > _G.PickupRadius then continue end
            
            if _G.PickupAll or (_G.AutoPickup and isItemWhitelisted(item)) then
                Packets.Pickup.send(entityID)
                pickupCount += 1
            end
        end
    end
    
    -- Coleta em Baús (Deployables)
    if (_G.AutoPickupChests or _G.ChestPickupAll) and workspace:FindFirstChild("Deployables") then
        local closestChest = nil
        local closestDist = math.huge
        
        for _, model in pairs(workspace.Deployables:GetChildren()) do
            local contents = model:FindFirstChild("Contents")
            if contents and #contents:GetChildren() > 0 then
                local dist = (charPos - model:GetPivot().Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestChest = contents
                end
            end
        end
        
        if closestChest and closestDist <= _G.PickupRadius then
            for _, item in pairs(closestChest:GetChildren()) do
                if pickupCount >= _G.MaxPickupCount then break end
                local entityID = item:GetAttribute("EntityID")
                if not entityID then continue end
                
                if _G.ChestPickupAll or (_G.AutoPickupChests and isItemWhitelisted(item)) then
                    Packets.Pickup.send(entityID)
                    pickupCount += 1
                end
            end
        end
    end
    
    -- Render do Anel AOE
    if _G.ShowPickupAOE and Player.Character:FindFirstChild("HumanoidRootPart") then
        local root = Player.Character.HumanoidRootPart
        updateRing(root.Position - Vector3.new(0, root.Size.Y/2, 0), _G.PickupRadius)
    end
end)

-- ==========================================
-- auto farm (OTIMIZADO, MULTI-FRUTA & SEM LAG)
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Packets = require(ReplicatedStorage.Modules.Packets)
local ItemIDS = require(ReplicatedStorage.Modules.ItemIDS)

--// CONFIG & STATES
_G.AutoPlant = false
_G.AutoHarvest = false
_G.AutoMovePlantBox = false
_G.AutoMoveBush = false
_G.AutoMoveBushAndBox = false

_G.PlantRange = 25
_G.HarvestRange = 25
_G.AutoMoveRange = 30

local foods = {
    "Bloodfruit",
    "Lemon",
    "Pumpkin",
    "Berry",
    "Carrot",
    "Cloudberry",
    "Strawberry",
    "Orange",
    "Apple",
    "Jelly",
    "Strangefruit",
    "Barley",
    "Banana",
    "Watermelon",
    "Blossom",
    "Mango",
    "Oddberry",
    "Coconut",
    "Sunfruit",
    "Frostfruit",
    "Bluefruit"
}

-- Tabela de frutas selecionadas para plantio múltiplo em rotação (Padrão inicial: Pumpkin)
local selectedFarmFoods = {"Bloodfruit"}
local foodIndexRotation = 1

local SEARCH_HEIGHT = 10
local MOVE_SPEED    = 17
local HEIGHT_OFFSET = 1

local currentTween = nil

local function stopMovement()
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:Move(Vector3.zero)
            humanoid.AutoRotate = true
        end
    end
end

-- Função para verificar se o nome do arbusto/crop corresponde a alguma das frutas selecionadas
local function matchesAnyFood(name)
    if not name then return false end
    local n = name:lower()
    for _, food in ipairs(selectedFarmFoods) do
        if n:find(food:lower()) then
            return true
        end
    end
    return false
end

CreateToggle(FarmTab, "Auto Plant", "AutoPlant", function(state)
    _G.AutoPlant = state
end)

CreateSlider(FarmTab, "Plant Range", 5, 25, 25, 1, function(val)
    _G.PlantRange = val
end)

CreateToggle(FarmTab, "Auto Harvest", "AutoHarvest", function(state)
    _G.AutoHarvest = state
end)

CreateSlider(FarmTab, "Harvest Range", 5, 25, 25, 1, function(val)
    _G.HarvestRange = val
end)

-- Dropdown alterado para MÚLTIPLA SELEÇÃO (isMulti = true)
CreateDropdown(FarmTab, "Select Farm Food: ", foods, {"Bloodfruit"}, true, function(selected)
    if type(selected) == "table" and #selected > 0 then
        selectedFarmFoods = selected
    elseif type(selected) == "string" and selected ~= "" then
        selectedFarmFoods = {selected}
    else
        selectedFarmFoods = {"Bloofruit"}
    end
    foodIndexRotation = 1
end)

CreateToggle(FarmTab, "Auto Move to Plant Box", "AutoMovePlantBox", function(state)
    _G.AutoMovePlantBox = state
    if not state then stopMovement() end
end)

CreateToggle(FarmTab, "Auto Move to Bush", "AutoMoveBush", function(state)
    _G.AutoMoveBush = state
    if not state then stopMovement() end
end)

CreateToggle(FarmTab, "Auto Move Bush and Plantbox", "AutoMoveBushAndBox", function(state)
    _G.AutoMoveBushAndBox = state
    if not state then stopMovement() end
end)

CreateSlider(FarmTab, "Auto Move Range", 10, 200, 30, 5, function(val)
    _G.AutoMoveRange = val
end)

local currentTargetGui

local function setTarget(model)
    pcall(function()
        if currentTargetGui then
            currentTargetGui:Destroy()
            currentTargetGui = nil
        end

        if not model then return end

        local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
        if not part then return end

        local gui = Instance.new("BillboardGui")
        gui.Name = "__PLANT_TARGET__"
        gui.Adornee = part
        gui.Size = UDim2.fromOffset(110, 32)
        gui.StudsOffset = Vector3.new(0, 2.5, 0)
        gui.AlwaysOnTop = true
        gui.Parent = workspace

        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromScale(1, 1)
        label.BackgroundTransparency = 1
        label.Text = "TARGET"
        label.Font = Enum.Font.GothamBold
        label.TextScaled = true
        label.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 0, 0)
        stroke.Thickness = 2
        stroke.Parent = label
        
        label.Parent = gui
        currentTargetGui = gui
    end)
end

-- ==========================================
-- [ MOVIMENTAÇÃO SEGURA ]
-- ==========================================

local function moveToBox(box)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    local part = box.PrimaryPart or box:FindFirstChildWhichIsA("BasePart")
    if not part then return end

    local target = Vector3.new(
        part.Position.X,
        part.Position.Y + (part.Size.Y / 2) + humanoid.HipHeight + (root.Size.Y / 2) + HEIGHT_OFFSET,
        part.Position.Z
    )

    local distance = (target - root.Position).Magnitude
    if distance < 1 then return end

    humanoid.AutoRotate = false

    if currentTween then
        currentTween:Cancel()
    end

    currentTween = TweenService:Create(
        root,
        TweenInfo.new(math.max(distance / MOVE_SPEED, 0.05), Enum.EasingStyle.Linear),
        { CFrame = CFrame.new(target) * root.CFrame.Rotation }
    )

    pcall(function()
        currentTween:Play()
        currentTween.Completed:Wait()
    end)

    if humanoid.Parent then
        humanoid.AutoRotate = true
    end
end

-- ==========================================
-- [ SCANNER DE PLANT BOXES OTIMIZADO ]
-- ==========================================

local function getSortedPlantBoxes(origin, range)
    local results = {}
    local checked = {}

    pcall(function()
        local parts = workspace:GetPartBoundsInBox(
            CFrame.new(origin),
            Vector3.new(range * 2, SEARCH_HEIGHT, range * 2)
        )

        for _, part in ipairs(parts) do
            local model = part:FindFirstAncestor("Plant Box")
            if model and model.Name == "Plant Box" and not checked[model] and model:GetAttribute("EntityID") then
                checked[model] = true
                local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                if primary then
                    local dist = (origin - primary.Position).Magnitude
                    if dist <= range then
                        table.insert(results, {model = model, dist = dist})
                    end
                end
            end
        end

        table.sort(results, function(a, b)
            return a.dist < b.dist
        end)
    end)

    local sorted = {}
    for _, item in ipairs(results) do
        table.insert(sorted, item.model)
    end
    return sorted
end

-- ==========================================
-- [ LOOPS PRINCIPAIS OTIMIZADOS SEM LAG ]
-- ==========================================

local plantingCooldown = {}
local harvestCooldown = {}

-- LOOP 1: AUTO PLANT (COM ROTAÇÃO CÍCLICA DE FRUTAS A -> B -> C)
task.spawn(function()
    while true do
        task.wait(0.05) -- Otimizado: pausa leve para não consumir CPU nem causar lag
        if not _G.AutoPlant then continue end

        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if not root then return end
            local origin = root.Position

            local boxes = getSortedPlantBoxes(origin, _G.PlantRange)
            local plantedCount = 0
            local maxPerTick = 3

            for _, box in ipairs(boxes) do
                if plantedCount >= maxPerTick then break end
                
                local id = box:GetAttribute("EntityID")
                if id and not box:FindFirstChild("Seed") then
                    local last = plantingCooldown[id] or 0
                    if tick() - last >= 0.1 then
                        plantingCooldown[id] = tick()

                        -- Obtém a fruta atual na rotação cíclica (A -> B -> C -> A...)
                        local currentFoodName = selectedFarmFoods[foodIndexRotation] or selectedFarmFoods[1]
                        local currentItemID = ItemIDS[currentFoodName]

                        if currentItemID then
                            Packets.InteractStructure.send({
                                entityID = id,
                                itemID = currentItemID
                            })

                            -- Avança para a próxima fruta da lista selecionada de forma cíclica
                            foodIndexRotation = foodIndexRotation + 1
                            if foodIndexRotation > #selectedFarmFoods then
                                foodIndexRotation = 1
                            end

                            plantedCount = plantedCount + 1
                        end
                    end
                end
            end
        end)
    end
end)

-- LOOP 2: AUTO HARVEST (OTIMIZADO)
task.spawn(function()
    while true do
        task.wait(0.1) -- Evita repetição excessiva por frame
        if not _G.AutoHarvest then continue end

        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if not root then return end
            local origin = root.Position

            -- 1. Colheita em Plant Boxes
            local harvestBoxes = getSortedPlantBoxes(origin, _G.HarvestRange)
            for _, box in ipairs(harvestBoxes) do
                local id = box:GetAttribute("EntityID")
                if id and box:FindFirstChild("Seed") then
                    local last = harvestCooldown[id] or 0
                    if tick() - last >= 0.2 then
                        harvestCooldown[id] = tick()
                        Packets.InteractStructure.send({
                            entityID = id,
                            itemID = 0
                        })
                    end
                end
            end

            -- 2. Colheita em Crops do workspace
            local cropsFolder = workspace:FindFirstChild("Crops")
            if cropsFolder then
                for _, bush in ipairs(cropsFolder:GetChildren()) do
                    local id = bush:GetAttribute("EntityID")
                    local primary = bush.PrimaryPart or bush:FindFirstChildWhichIsA("BasePart")
                    if id and primary then
                        local dist = (origin - primary.Position).Magnitude
                        if dist <= _G.HarvestRange then
                            local last = harvestCooldown[id] or 0
                            if tick() - last >= 0.2 then
                                harvestCooldown[id] = tick()
                                
                                pcall(function() Packets.Pickup.send(id) end)
                                pcall(function()
                                    Packets.InteractStructure.send({
                                        entityID = id,
                                        itemID = 0
                                    })
                                end)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- LOOP 3: AUTO MOVE OTIMIZADO (SEM TRAVAMENTOS COM RAIO 200)
task.spawn(function()
    while true do
        task.wait(0.15) -- Task de varredura leve que impede o lag excessivo de varreduras instantâneas por frame

        if not _G.AutoMovePlantBox and not _G.AutoMoveBush and not _G.AutoMoveBushAndBox then
            setTarget(nil)
            continue
        end

        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if not root then return end
            local charPos = root.Position

            local chosenTargetBox = nil
            local shortestDist = _G.AutoMoveRange

            -- PRIORIDADE 1: Arbustos / Crops (Filtra pelas frutas selecionadas)
            if _G.AutoMoveBush or _G.AutoMoveBushAndBox then
                local crops = workspace:FindFirstChild("Crops")
                if crops then
                    for _, bush in ipairs(crops:GetChildren()) do
                        if matchesAnyFood(bush.Name) then
                            local primary = bush.PrimaryPart or bush:FindFirstChildWhichIsA("BasePart")
                            if primary then
                                local dist = (charPos - primary.Position).Magnitude
                                local id = bush:GetAttribute("EntityID")
                                if dist < shortestDist and id then
                                    shortestDist = dist
                                    chosenTargetBox = bush
                                end
                            end
                        end
                    end
                end
            end

            -- PRIORIDADE 2: Plant Boxes vazias
            if not chosenTargetBox and (_G.AutoMovePlantBox or _G.AutoMoveBushAndBox) then
                local boxes = getSortedPlantBoxes(charPos, _G.AutoMoveRange)
                for _, box in ipairs(boxes) do
                    if not box:FindFirstChild("Seed") then
                        local primary = box.PrimaryPart or box:FindFirstChildWhichIsA("BasePart")
                        if primary then
                            local dist = (charPos - primary.Position).Magnitude
                            if dist < shortestDist then
                                shortestDist = dist
                                chosenTargetBox = box
                            end
                        end
                    end
                end
            end

            if chosenTargetBox then
                setTarget(chosenTargetBox)
                moveToBox(chosenTargetBox)
            else
                setTarget(nil)
                stopMovement()
            end
        end)
    end
end)

-- ==========================================
-- [ ESP COMPLETO + TRACER + GOD SYSTEMS ]
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// CONFIGURAÇÕES DO ESP
_G.PlayerESP = false
_G.ESPOutline = true
_G.ESPShowName = true
_G.ESPShowDistance = true
_G.ESPShowHealthBar = true
_G.ESPShowHealthText = true
_G.ESPTracer = false
_G.GodESP = false
_G.GodPartsESP = false
_G.OnlyGodPlayers = false
_G.ESPRange = 500

local MAIN_COLOR = Color3.fromRGB(222, 222, 222)
local GOD_COLOR = Color3.fromRGB(255, 200, 0) -- Amarelo
local GOD_ITEMS = {"God Legs", "God Chestplate", "God Halo"}
local tracers = {}

-- 1. FUNÇÕES AUXILIARES (Busca recursiva para detetar as peças em qualquer pasta do character)
local function getGodPartsCount(char)
    if not char then return 0 end
    local count = 0
    for _, itemName in ipairs(GOD_ITEMS) do
        if char:FindFirstChild(itemName, true) then
            count = count + 1
        end
    end
    return count
end

local function removeESP(char)
    if not char then return end
    local highlight = char:FindFirstChild("__HUB_HIGHLIGHT__")
    local gui = char:FindFirstChild("__HUB_ESP_GUI__")
    if highlight then highlight:Destroy() end
    if gui then gui:Destroy() end
end

-- 2. ELEMENTOS DA UI NA VISUALTAB
CreateToggle(VisualTab, "Player ESP", "PlayerESP", function(state)
    _G.PlayerESP = state
    if not state then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                removeESP(plr.Character)
            end
            if tracers[plr] then
                pcall(function() tracers[plr]:Remove() end)
                tracers[plr] = nil
            end
        end
    end
end)

CreateSlider(VisualTab, "ESP Range", 50, 5000, 500, 50, function(val)
    _G.ESPRange = val
end)

CreateToggle(VisualTab, "ESP Outline", "ESPOutline", function(state)
    _G.ESPOutline = state
    if not state then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local highlight = plr.Character:FindFirstChild("__HUB_HIGHLIGHT__")
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

CreateToggle(VisualTab, "ESP Show Name", "ESPShowName", function(state)
    _G.ESPShowName = state
end)

CreateToggle(VisualTab, "ESP Show Distance", "ESPShowDistance", function(state)
    _G.ESPShowDistance = state
end)

CreateToggle(VisualTab, "ESP Health Bar", "ESPShowHealthBar", function(state)
    _G.ESPShowHealthBar = state
end)

CreateToggle(VisualTab, "ESP Health Text", "ESPShowHealthText", function(state)
    _G.ESPShowHealthText = state
end)

CreateToggle(VisualTab, "ESP Tracer", "ESPTracer", function(state)
    _G.ESPTracer = state
    if not state then
        for plr, line in pairs(tracers) do
            pcall(function() line:Remove() end)
            tracers[plr] = nil
        end
    end
end)

CreateToggle(VisualTab, "ESP God", "GodESP", function(state)
    _G.GodESP = state
end)

CreateToggle(VisualTab, "ESP God Parts", "GodPartsESP", function(state)
    _G.GodPartsESP = state
end)

CreateToggle(VisualTab, "Only ESP God Players", "OnlyGodPlayers", function(state)
    _G.OnlyGodPlayers = state
end)

-- 3. LÓGICA PRINCIPAL DE APLICAÇÃO
local function applyESP(player)
    if player == LocalPlayer then return end

    local char = player.Character
    if not char then 
        removeESP(char)
        if tracers[player] then tracers[player].Visible = false end
        return 
    end

    local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid or humanoid.Health <= 0 then
        removeESP(char)
        if tracers[player] then tracers[player].Visible = false end
        return
    end

    -- Validação do Only ESP God Players (Exige pelo menos 1 peça)
    local partsCount = getGodPartsCount(char)
    if _G.OnlyGodPlayers and partsCount < 1 then
        removeESP(char)
        if tracers[player] then tracers[player].Visible = false end
        return
    end

    local myRoot = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character.PrimaryPart)
    local dist = myRoot and math.floor((root.Position - myRoot.Position).Magnitude) or 0
    local maxDist = _G.ESPRange or 500

    if dist > maxDist then
        removeESP(char)
        if tracers[player] then tracers[player].Visible = false end
        return
    end

    -- Full God (3/3 peças + Toggle ESP God ligado)
    local isFullGod = (partsCount >= 3) and _G.GodESP
    local playerColor = isFullGod and GOD_COLOR or MAIN_COLOR

    -- Tracer Logic
    if _G.ESPTracer and Drawing then
        local line = tracers[player]
        if not line then
            pcall(function()
                line = Drawing.new("Line")
                line.Thickness = 1.5
                tracers[player] = line
            end)
        end
        
        if line then
            line.Color = playerColor
            line.Transparency = 0.8
            local vector, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                line.To = Vector2.new(vector.X, vector.Y)
                line.Visible = true
            else
                line.Visible = false
            end
        end
    else
        if tracers[player] then
            tracers[player].Visible = false
        end
    end

    -- Outline Geral
    local highlight = char:FindFirstChild("__HUB_HIGHLIGHT__")
    if _G.ESPOutline then
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "__HUB_HIGHLIGHT__"
            highlight.Adornee = char
            highlight.Parent = char
        end
        highlight.FillColor = playerColor
        highlight.FillTransparency = 0.75
        highlight.OutlineColor = playerColor
        highlight.OutlineTransparency = 0
    else
        if highlight then highlight:Destroy() end
    end

    -- Billboard GUI
    local gui = char:FindFirstChild("__HUB_ESP_GUI__")
    if not gui then
        gui = Instance.new("BillboardGui")
        gui.Name = "__HUB_ESP_GUI__"
        gui.Adornee = root
        gui.Size = UDim2.fromOffset(160, 60)
        gui.StudsOffset = Vector3.new(0, 3.5, 0)
        gui.AlwaysOnTop = true
        gui.Parent = char

        local frame = Instance.new("Frame")
        frame.Name = "Container"
        frame.Size = UDim2.fromScale(1, 1)
        frame.BackgroundTransparency = 1
        frame.Parent = gui

        local infoLabel = Instance.new("TextLabel")
        infoLabel.Name = "InfoLabel"
        infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
        infoLabel.Position = UDim2.new(0, 0, 0, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.Font = Enum.Font.GothamBold
        infoLabel.TextSize = 13
        infoLabel.RichText = true -- Necessário para colorir apenas o (X/3)
        infoLabel.TextStrokeTransparency = 0
        infoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        infoLabel.Parent = frame

        local healthBG = Instance.new("Frame")
        healthBG.Name = "HealthBG"
        healthBG.Size = UDim2.new(0.8, 0, 0, 6)
        healthBG.Position = UDim2.new(0.1, 0, 0.55, 0)
        healthBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        healthBG.BorderSizePixel = 0
        healthBG.Parent = frame

        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(0, 3)
        bgCorner.Parent = healthBG

        local healthBar = Instance.new("Frame")
        healthBar.Name = "HealthBar"
        healthBar.Size = UDim2.fromScale(1, 1)
        healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        healthBar.BorderSizePixel = 0
        healthBar.Parent = healthBG

        local barCorner = Instance.new("UICorner")
        barCorner.CornerRadius = UDim.new(0, 3)
        barCorner.Parent = healthBar

        local healthText = Instance.new("TextLabel")
        healthText.Name = "HealthText"
        healthText.Size = UDim2.new(1, 0, 0.35, 0)
        healthText.Position = UDim2.new(0, 0, 0.65, 0)
        healthText.BackgroundTransparency = 1
        healthText.Font = Enum.Font.GothamBold
        healthText.TextSize = 11
        healthText.TextStrokeTransparency = 0
        healthText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        healthText.Parent = frame
    end

    local hpPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
    local infoContainer = gui:FindFirstChild("Container")
    
    if infoContainer then
        local baseText = ""
        if _G.ESPShowName then baseText = player.DisplayName or player.Name end
        if _G.ESPShowDistance then baseText = baseText .. " [" .. tostring(dist) .. "m]" end
        
        local infoText = baseText
        -- Adiciona o contador (X/3) em amarelo se o ESP God Parts estiver ativo e tiver pelo menos 1 peça
        if _G.GodPartsESP and partsCount > 0 then
            infoText = infoText .. " <font color=\"#FFC800\">(" .. partsCount .. "/3)</font>"
        end
        
        infoContainer.InfoLabel.Text = infoText

        -- Cor do texto principal (Nome e Distância): Amarelo se for full God, senão Branco
        if isFullGod then
            infoContainer.InfoLabel.TextColor3 = GOD_COLOR
        else
            infoContainer.InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        -- Barra de Vida
        local healthBG = infoContainer.HealthBG
        healthBG.Visible = _G.ESPShowHealthBar
        if _G.ESPShowHealthBar then
            healthBG.HealthBar.Size = UDim2.fromScale(hpPercent, 1)
            healthBG.HealthBar.BackgroundColor3 = Color3.fromHSV(hpPercent * 0.3, 0.9, 1)
        end

        -- Texto de Vida Dinâmico (Verde -> Laranja -> Amarelo)
        local healthText = infoContainer.HealthText
        healthText.Visible = _G.ESPShowHealthText
        if _G.ESPShowHealthText then
            healthText.Text = math.floor(humanoid.Health) .. " / " .. math.floor(humanoid.MaxHealth)
            
            if hpPercent > 0.66 then
                healthText.TextColor3 = Color3.fromRGB(0, 255, 120) -- Verde
            elseif hpPercent > 0.33 then
                healthText.TextColor3 = Color3.fromRGB(255, 165, 0) -- Laranja
            else
                healthText.TextColor3 = Color3.fromRGB(255, 255, 0) -- Amarelo
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if not _G.PlayerESP then return end

    for _, player in ipairs(Players:GetPlayers()) do
        pcall(function()
            if player ~= LocalPlayer then
                applyESP(player)
            end
        end)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if tracers[plr] then
        pcall(function() tracers[plr]:Remove() end)
        tracers[plr] = nil
    end
end)

-- auto replay
_G.AutoReplay = false

CreateToggle(MiscTab, "AUTO REPLAY", "AutoReplay", function(state)
    _G.AutoReplay = state
end)

-- Buffer do Replay fornecido
local replayBuffer = buffer.fromstring("\000\228\000\000\000\000\000\000\000\240?")

task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(function()
            if not _G.AutoReplay then return end
            
            local remote = ReplicatedStorage:FindFirstChild("ByteNetReliable")
            if remote then
                remote:FireServer(unpack({replayBuffer}))
                task.wait(0.1)
            end
        end)
    end
end)

-- Auto Skip
_G.AutoSkip = false

CreateToggle(MiscTab, "AUTO SKIP", "AutoSkip", function(state)
    _G.AutoSkip = state
end)

-- Buffer do Skip fornecido
local replayBuffer = buffer.fromstring("\000\228\003\000\000\000\000\000\000\000\000")

task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(function()
            if not _G.AutoSkip then return end
            
            local remote = ReplicatedStorage:FindFirstChild("ByteNetReliable")
            if remote then
                remote:FireServer(unpack({replayBuffer}))
                task.wait(0.1)
            end
        end)
    end
end)

-- auto equip god rock
_G.AutoGodRock = false

CreateToggle(MiscTab, "AUTO GOD ROCK", "AutoGodRock", function(state)
    _G.AutoGodRock = state
    
    task.spawn(function()
        while _G.AutoGodRock do
            task.wait(0.1)
            
            pcall(function()
                local char = lp.Character
                if not char then return end
                
                local toolsFolder = char:FindFirstChild("Tools")
                local needsEquip = false
                
                if toolsFolder then
                    local hasGodRock = toolsFolder:FindFirstChild("God Rock")
                    
                    if not hasGodRock then
                        needsEquip = true
                    end
                else
                    needsEquip = true
                end
                
                if needsEquip then
                    local args = {
                        buffer.fromstring("\000-\001")
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args))
                    task.wait(0.5)
                end
            end)
        end
    end)
end)

-- auto equip blade
_G.AutoEquipEmeraldBlade = false

CreateToggle(MiscTab, "Auto Equip Emerald Blade", "AutoEquipEmeraldBlade", function(state)
    _G.AutoEquipEmeraldBlade = state
    
    task.spawn(function()
        while _G.AutoEquipEmeraldBlade do
            task.wait(0.3)
            
            pcall(function()
                local char = lp.Character
                if not char then return end
                
                local toolsFolder = char:FindFirstChild("Tools")
                local needsEquip = false
                
                if toolsFolder then
                    local hasGodRock = toolsFolder:FindFirstChild("Emerald Blade")
                    
                    if not hasGodRock then
                        needsEquip = true
                    end
                else
                    needsEquip = true
                end
                
                if needsEquip then
                    local args = {
                    	buffer.fromstring("\000-\004")
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(unpack(args))
                    task.wait(0.5)
                end
            end)
        end
    end)
end)

-- Auto Reset
_G.AutoResetWave = false
_G.TargetResetWave = 10

CreateToggle(MiscTab, "AUTO RESET WAVE/BOSS", "AutoResetWave", function(state)
    _G.AutoResetWave = state
end)

CreateSlider(MiscTab, "ALVO PARA RESET (WAVE/VALOR)", 1, 100, 10, function(value)
    _G.TargetResetWave = value
end)

task.spawn(function()
    while true do
        task.wait(0.4)
        pcall(function()
            if not _G.AutoResetWave then return end

            local playerGui = lp:FindFirstChild("PlayerGui")
            if not playerGui then return end

            local mainGui = playerGui:FindFirstChild("MainGui")
            if not mainGui then return end

            local panels = mainGui:FindFirstChild("Panels")
            if not panels then return end

            local bossbar = panels:FindFirstChild("Bossbar")
            if not bossbar then return end

            local healthBackdrop = bossbar:FindFirstChild("HealthBackdrop")
            if not healthBackdrop then return end

            local titleLabel = healthBackdrop:FindFirstChild("Title")
            if not titleLabel or not titleLabel:IsA("TextLabel") then return end

            local text = titleLabel.Text
            if not text or text == "" then return end

            local shouldReset = false

            if string.match(text:lower(), "boss") then
                shouldReset = true
            else
                local firstNum, secondNum = text:match("(%d+)%s*/%s*(%d+)")
                if firstNum then
                    local currentVal = tonumber(firstNum)
                    if currentVal and currentVal >= _G.TargetResetWave then
                        shouldReset = true
                    end
                else
                    local currentWave = tonumber(text:match("%d+"))
                    if currentWave and currentWave >= _G.TargetResetWave then
                        shouldReset = true
                    end
                end
            end

            if shouldReset then
                local char = lp.Character
                if char then
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        humanoid.Health = 0
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end)

-- Esp FisherBoat
_G.ESP_FisherBoat = false

local function RemoveFisherBoatESP()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Modders_FisherBoatESP" then
            obj:Destroy()
        end
    end
end

CreateToggle(VisualTab, "ESP FISHERBOAT", "ESP_FisherBoat", function(state)
    _G.ESP_FisherBoat = state
    
    if not state then
        RemoveFisherBoatESP()
    else
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "FisherBoat" and obj:IsA("Model") then
                local primaryPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if primaryPart and not primaryPart:FindFirstChild("Modders_FisherBoatESP") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "Modders_FisherBoatESP"
                    billboard.Size = UDim2.new(0, 140, 0, 45)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Adornee = primaryPart
                    billboard.Parent = primaryPart

                    local textLabel = Instance.new("TextLabel", billboard)
                    textLabel.Size = UDim2.new(1, 0, 0, 20)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Font = Enum.Font.Code
                    textLabel.Text = "[ FISHERBOAT ]"
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
                    textLabel.TextSize = 12
                    textLabel.TextStrokeTransparency = 0.2

                    local distLabel = Instance.new("TextLabel", billboard)
                    distLabel.Name = "DistLabel"
                    distLabel.Size = UDim2.new(1, 0, 0, 20)
                    distLabel.Position = UDim2.new(0, 0, 0, 18)
                    distLabel.BackgroundTransparency = 1
                    distLabel.Font = Enum.Font.Code
                    distLabel.Text = "0 studs"
                    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200) -- Cinza claro
                    distLabel.TextSize = 11
                    distLabel.TextStrokeTransparency = 0.2

                    task.spawn(function()
                        while billboard and billboard.Parent and _G.ESP_FisherBoat do
                            task.wait(0.5)
                            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                                local dist = math.floor((primaryPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude)
                                distLabel.Text = dist .. " studs"
                            end
                        end
                    end)
                end
            end
        end
    end
end)

workspace.ChildAdded:Connect(function(obj)
    if _G.ESP_FisherBoat and obj.Name == "FisherBoat" and obj:IsA("Model") then
        task.wait(0.5)
        local primaryPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
        if primaryPart and not primaryPart:FindFirstChild("Modders_FisherBoatESP") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "Modders_FisherBoatESP"
            billboard.Size = UDim2.new(0, 140, 0, 45)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Adornee = primaryPart
            billboard.Parent = primaryPart

            local textLabel = Instance.new("TextLabel", billboard)
            textLabel.Size = UDim2.new(1, 0, 0, 20)
            textLabel.BackgroundTransparency = 1
            textLabel.Font = Enum.Font.Code
            textLabel.Text = "[ FISHERBOAT ]"
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextSize = 12
            textLabel.TextStrokeTransparency = 0.2

            local distLabel = Instance.new("TextLabel", billboard)
            distLabel.Name = "DistLabel"
            distLabel.Size = UDim2.new(1, 0, 0, 20)
            distLabel.Position = UDim2.new(0, 0, 0, 18)
            distLabel.BackgroundTransparency = 1
            distLabel.Font = Enum.Font.Code
            distLabel.Text = "0 studs"
            distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            distLabel.TextSize = 11
            distLabel.TextStrokeTransparency = 0.2

            task.spawn(function()
                while billboard and billboard.Parent and _G.ESP_FisherBoat do
                    task.wait(0.5)
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((primaryPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude)
                        distLabel.Text = dist .. " studs"
                    end
                end
            end)
        end
    end
end)

-- Esp Wandering and Treasure
_G.ESP_Wandering = false
_G.ESP_Treasure = false

local function CreateSimpleESP(targetPart, titleText, espName)
    if not targetPart or targetPart:FindFirstChild(espName) then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = espName
    billboard.Size = UDim2.new(0, 140, 0, 45)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = targetPart
    billboard.Parent = targetPart

    local titleLbl = Instance.new("TextLabel", billboard)
    titleLbl.Size = UDim2.new(1, 0, 0, 20)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.Code
    titleLbl.Text = "[" .. titleText .. "]"
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 12
    titleLbl.TextStrokeTransparency = 0.2

    local distLbl = Instance.new("TextLabel", billboard)
    distLbl.Name = "Dist"
    distLbl.Size = UDim2.new(1, 0, 0, 20)
    distLbl.Position = UDim2.new(0, 0, 0, 18)
    distLbl.BackgroundTransparency = 1
    distLbl.Font = Enum.Font.Code
    distLbl.Text = "0 studs"
    distLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLbl.TextSize = 11
    distLbl.TextStrokeTransparency = 0.2

    task.spawn(function()
        while billboard and billboard.Parent do
            task.wait(0.5)
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                local dist = math.floor((targetPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude)
                distLbl.Text = dist .. " studs"
            end
        end
    end)
end

local function RemoveESP(espName)
    for _, item in ipairs(workspace:GetDescendants()) do
        if item.Name == espName then
            item:Destroy()
        end
    end
end

-- esp wandering
CreateToggle(VisualTab, "ESP WANDERING TRADER", "ESP_Wandering", function(state)
    _G.ESP_Wandering = state
    if not state then
        RemoveESP("Modders_WanderingESP")
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Wandering Trader" then
                local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                CreateSimpleESP(part, "WANDERING", "Modders_WanderingESP")
            end
        end
    end
end)

CreateToggle(VisualTab, "ESP TREASURE CHEST", "ESP_Treasure", function(state)
    _G.ESP_Treasure = state
    if not state then
        RemoveESP("Modders_TreasureESP")
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Treasure Chest" then
                local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                CreateSimpleESP(part, "TREASURE", "Modders_TreasureESP")
            end
        end
    end
end)

-- Esp Gods
_G.ESP_Gods = false

local godsList = {
    "Wealthy God",
    "Sleeping God",
    "Old God",
    "Miserable God",
    "Mini Gold Gods",
    "Lonely God",
    "Hateful God",
    "Furious God",
    "Evil God",
    "Strange God",
    "Soulless God",
    "Odd God",
    "Magical God",
    "Infinity God",
    "Dark God",
    "Ancient God"
}

local function IsGod(name)
    for _, godName in ipairs(godsList) do
        if name == godName then
            return true
        end
    end
    return false
end

local function RemoveGodsESP()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Modders_GodESP" then
            obj:Destroy()
        end
    end
end

local function CreateGodESP(targetPart, godName)
    if not targetPart or targetPart:FindFirstChild("Modders_GodESP") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "Modders_GodESP"
    billboard.Size = UDim2.new(0, 150, 0, 45)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = targetPart
    billboard.Parent = targetPart

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Size = UDim2.new(1, 0, 0, 20)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Code
    textLabel.Text = "[" .. string.upper(godName) .. "]"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 11
    textLabel.TextStrokeTransparency = 0.2

    local distLabel = Instance.new("TextLabel", billboard)
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0, 20)
    distLabel.Position = UDim2.new(0, 0, 0, 18)
    distLabel.BackgroundTransparency = 1
    distLabel.Font = Enum.Font.Code
    distLabel.Text = "0 studs"
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.TextSize = 10
    distLabel.TextStrokeTransparency = 0.2

    task.spawn(function()
        while billboard and billboard.Parent and _G.ESP_Gods do
            task.wait(0.5)
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                local dist = math.floor((targetPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude)
                distLabel.Text = dist .. " studs"
            end
        end
    end)
end

CreateToggle(VisualTab, "ESP GODS (Void too)", "ESP_Gods", function(state)
    _G.ESP_Gods = state
    
    if not state then
        RemoveGodsESP()
    else
        local resourcesFolder = workspace:FindFirstChild("Resources")
        if resourcesFolder then
            for _, obj in ipairs(resourcesFolder:GetDescendants()) do
                if IsGod(obj.Name) then
                    local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or (obj:IsA("BasePart") and obj)
                    if part then
                        CreateGodESP(part, obj.Name)
                    end
                end
            end
        end
    end
end)

local resourcesFolder = workspace:FindFirstChild("Resources")
if resourcesFolder then
    resourcesFolder.DescendantAdded:Connect(function(obj)
        if _G.ESP_Gods and IsGod(obj.Name) then
            task.wait(0.3)
            local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or (obj:IsA("BasePart") and obj)
            if part then
                CreateGodESP(part, obj.Name)
            end
        end
    end)
end

-- auto heal
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Packets = require(ReplicatedStorage.Modules.Packets)
local GameUtil = require(ReplicatedStorage.Modules.GameUtil)

--// CONFIGURAÇÕES DO AUTO HEAL
_G.AutoHeal = false
_G.HealHealthThreshold = 40  -- % de vida para ativar
_G.HealSpeed = 50            -- Velocidade (10 a 100)
_G.HealDelay = 1             -- Tempo (s) de espera após a vida baixar
_G.HealSelectedItem = "Bloodfruit"

local healOptions = {"Bloodfruit", "Bluefruit", "Lemon"}

-- UI NA AUTOMATIONTAB
CreateToggle(CombatTab, "Auto Heal", "AutoHeal", function(state)
    _G.AutoHeal = state
end)

CreateSlider(CombatTab, "Heal at Health (%)", 5, 99, 40, 1, function(val)
    _G.HealHealthThreshold = val
end)

CreateSlider(CombatTab, "Heal Speed", 1, 300, 50, 1, function(val)
    _G.HealSpeed = val
end)

CreateSlider(CombatTab, "Heal Delay (s)", 0, 3, 1, 0.1, function(val)
    _G.HealDelay = val
end)

CreateDropdown(CombatTab, "Select Heal Item", healOptions, "Bloodfruit", false, function(selected)
    _G.HealSelectedItem = selected
end)

-- ==========================================
-- [ LÓGICA DE CONSUMO ]
-- ==========================================

local lowHealthTick = nil
local lastHealTick = 0

local function triggerHeal()
    local targetFoodName = _G.HealSelectedItem or "Bloodfruit"
    
    -- 1. Encontra o índice correto do item no inventário do jogador
    local invIndex = GameUtil.hasItem(targetFoodName, LocalPlayer)
    if invIndex then
        pcall(function()
            Packets.Consume.send(invIndex)
        end)
        pcall(function()
            Packets.UseBagItem.send(invIndex)
        end)
    end
    
    -- 2. Fallback: Tenta equipar e ativar caso esteja na barra de ferramentas/mão
    local char = LocalPlayer.Character
    if char then
        local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
        local tool = (backpack and backpack:FindFirstChild(targetFoodName)) or char:FindFirstChild(targetFoodName)
        if tool and tool:IsA("Tool") then
            if tool.Parent ~= char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:EquipTool(tool)
                end
            end
            pcall(function()
                tool:Activate()
            end)
        end
    end
end

-- ==========================================
-- [ LOOP PRINCIPAL ]
-- ==========================================

RunService.Heartbeat:Connect(function()
    if not _G.AutoHeal then 
        lowHealthTick = nil
        return 
    end

    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then 
        lowHealthTick = nil
        return 
    end

    local hpPercent = (humanoid.Health / humanoid.MaxHealth) * 100
    local threshold = _G.HealHealthThreshold or 40

    if hpPercent <= threshold then
        if not lowHealthTick then
            lowHealthTick = tick()
        end

        local delayTime = _G.HealDelay or 1
        if (tick() - lowHealthTick) >= delayTime then
            local speedVal = math.clamp(_G.HealSpeed or 50, 1, 300)
            local cooldown = 1 - ((speedVal - 10) / 99) * 0.85

            if tick() - lastHealTick >= cooldown then
                lastHealTick = tick()
                triggerHeal()
            end
        end
    else
        lowHealthTick = nil
    end
end)

-- Walkspeed
_G.LoopWalkSpeed = false
_G.TargetWalkSpeed = 16

CreateToggle(PlayerTab, "WalkSpeed", "LoopWalkSpeed", function(state)
    _G.LoopWalkSpeed = state
end)

CreateSlider(PlayerTab, "Walkspeed Slider", 1, 21, 16, 1, function(val)
    _G.TargetWalkSpeed = val
end)

RunService.RenderStepped:Connect(function()
    if not _G.LoopWalkSpeed then return end
    pcall(function()
        local char = lp.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.WalkSpeed ~= _G.TargetWalkSpeed then
            humanoid.WalkSpeed = _G.TargetWalkSpeed
        end
    end)
end)

-- Msa editor
_G.MaxSlope = 46

CreateSlider(PlayerTab, "MAX SLOPE ANGLE", 46, 360, 46, 1, function(val)
    local num = tonumber(val)
    if num and num > 0 then
        _G.MaxSlope = num
    else
        _G.MaxSlope = 46
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            local char = lp.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local currentSlope = tonumber(_G.MaxSlope)
                if not currentSlope or currentSlope <= 0 then
                    currentSlope = 46
                    _G.MaxSlope = 46
                end
                
                if humanoid.MaxSlopeAngle ~= currentSlope then
                    humanoid.MaxSlopeAngle = currentSlope
                end
            end
        end)
    end
end)

CreateSlider(PlayerTab, "MAX ZOOM DISTANCE", 125, 10000, 125, function(val)
    pcall(function()
        lp.CameraMaxZoomDistance = val
    end)
end)

pcall(function()
    lp.CameraMaxZoomDistance = 125
end)

-- jumppwoer
_G.LoopJumpPower = false
_G.CustomJumpPower = 50

CreateToggle(PlayerTab, "JumpPower", "LoopJumpPower", function(state)
    _G.LoopJumpPower = state
end)

CreateSlider(PlayerTab, "JumpPower Slider", 50, 70, 50, function(val)
    _G.CustomJumpPower = val
end)

RunService.RenderStepped:Connect(function()
    if not _G.LoopJumpPower then return end
    pcall(function()
        local char = lp.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            if humanoid.JumpPower ~= _G.CustomJumpPower then
                humanoid.JumpPower = _G.CustomJumpPower
            end
        end
    end)
end)

-- Cam Noclip
_G.InvisicamEnabled = false

CreateToggle(PlayerTab, "Cam noclip", "InvisicamEnabled", function(state)
    _G.InvisicamEnabled = state
    pcall(function()
        if state then
            lp.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
        else
            lp.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
        end
    end)
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            if _G.InvisicamEnabled then
                if lp.DevCameraOcclusionMode ~= Enum.DevCameraOcclusionMode.Invisicam then
                    lp.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
                end
            end
        end)
    end
end)

-- Inf Jump
_G.InfJumpEnabled = false

CreateToggle(PlayerTab, "INF JUMP", "InfJumpEnabled", function(state)
    _G.InfJumpEnabled = state
end)

UserInputService.JumpRequest:Connect(function()
    if not _G.InfJumpEnabled then return end
    
    pcall(function()
        local char = lp.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

-- Chest Hitbox
_G.ChestHitboxEnabled = false
_G.ChestHitboxSize = 6

CreateToggle(MiscTab, "Chest Hitbox Slider", "ChestHitboxEnabled", "Closest Chest.", function(state)
    _G.ChestHitboxEnabled = state
end)

CreateSlider(MiscTab, "Hitbox Size", 6, 50, 6, 1, function(val)
    local num = tonumber(val)
    if num and num >= 6 then
        _G.ChestHitboxSize = num
    else
        _G.ChestHitboxSize = 6
    end
end)

task.spawn(function()
    while true do
        task.wait(0.9)
        pcall(function()
            if not _G.ChestHitboxEnabled then return end

            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local deployables = workspace:FindFirstChild("Deployables")
            if not deployables then return end

            local targetSize = Vector3.new(_G.ChestHitboxSize, _G.ChestHitboxSize, _G.ChestHitboxSize)
            local closestHitbox = nil
            local shortestDistance = math.huge

            for _, model in ipairs(deployables:GetChildren()) do
                local nameLower = string.lower(model.Name)
                if string.find(nameLower, "chest") or string.find(nameLower, "reinforced") then
                    local hitbox = model:FindFirstChild("Hitbox")
                    if hitbox and hitbox:IsA("BasePart") then
                        local dist = (hrp.Position - hitbox.Position).Magnitude
                        if dist < shortestDistance then
                            shortestDistance = dist
                            closestHitbox = hitbox
                        end
                    end
                end
            end

            for _, model in ipairs(deployables:GetChildren()) do
                local nameLower = string.lower(model.Name)
                if string.find(nameLower, "chest") or string.find(nameLower, "reinforced") then
                    local hitbox = model:FindFirstChild("Hitbox")
                    if hitbox and hitbox:IsA("BasePart") then
                        if hitbox == closestHitbox then
                            if hitbox.Size ~= targetSize then
                                hitbox.Size = targetSize
                                hitbox.Transparency = 1
                                hitbox.CanCollide = false
                                hitbox.Massless = true
                            end
                        else
                            if hitbox.Size == targetSize then
                                hitbox.Size = Vector3.new(2, 2, 2)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Delete Doors
_G.DeleteDoorEnabled = false

CreateToggle(MiscTab, "Delete Doors (all)", "DeleteDoorEnabled", "Literally All doors(Gates,fences,Chests,huts and others)", function(state)
    _G.DeleteDoorEnabled = state
end)

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if not _G.DeleteDoorEnabled then return end
            
            local deployables = workspace:FindFirstChild("Deployables")
            if deployables then
                for _, obj in ipairs(deployables:GetDescendants()) do
                    if obj.Name == "Door" then
                        obj:Destroy()
                    end
                end
            end
        end)
    end
end)

-- vehicle Speed
_G.MaxVehicleSpeed = false
_G.TargetVehicleSpeed = 39

CreateToggle(MiscTab, "Vehicle Speed", "MaxVehicleSpeed", function(state)
    _G.MaxVehicleSpeed = state
end)

CreateSlider(MiscTab, "Vehicle Speed Slider", 10, 39, 39, 1, function(val)
    local num = tonumber(val)
    if num and num >= 10 then
        _G.TargetVehicleSpeed = num
    else
        _G.TargetVehicleSpeed = 39
    end
end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        if not _G.MaxVehicleSpeed then return end

        local char = lp.Character
        if not char then return end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
            local seat = humanoid.SeatPart
            
            local vehicleModel = seat.Parent
            local primaryPart = (vehicleModel:IsA("Model") and vehicleModel.PrimaryPart) or seat

            if seat.Throttle ~= 0 or seat.Steer ~= 0 then
                local lookDir = seat.CFrame.LookVector
                local currentVel = primaryPart.AssemblyLinearVelocity
                
                local direction = (seat.Throttle > 0) and 1 or ((seat.Throttle < 0) and -1 or 0)
                
                if direction ~= 0 then
                    local speedMag = _G.TargetVehicleSpeed * direction
                    local targetVel = Vector3.new(lookDir.X * speedMag, currentVel.Y, lookDir.Z * speedMag)
                    
                    primaryPart.AssemblyLinearVelocity = targetVel
                end
            end
        end
    end)
end)

-- Vehicle Fly
_G.VehicleFly = false
_G.VehicleFlySpeed = 50

CreateToggle(MiscTab, "Vehicle Fly", "VehicleFly", "31~ is perfect", function(state)
    _G.VehicleFly = state
end)

CreateSlider(MiscTab, "Vehicle Fly Speed", 20, 60, 50, 1, function(val)
    local num = tonumber(val)
    if num and num >= 20 then
        _G.VehicleFlySpeed = num
    else
        _G.VehicleFlySpeed = 50
    end
end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        if not _G.VehicleFly then return end

        local char = lp.Character
        if not char then return end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
            local seat = humanoid.SeatPart
            local vehicleModel = seat.Parent
            local primaryPart = (vehicleModel:IsA("Model") and vehicleModel.PrimaryPart) or seat

            local cam = workspace.CurrentCamera
            local flyDir = Vector3.new(0, 0, 0)
            
            if seat.Throttle > 0 then
                flyDir = flyDir + cam.CFrame.LookVector
            elseif seat.Throttle < 0 then
                flyDir = flyDir - cam.CFrame.LookVector
            end
            
            if seat.Steer > 0 then
                flyDir = flyDir + cam.CFrame.RightVector
            elseif seat.Steer < 0 then
                flyDir = flyDir - cam.CFrame.RightVector
            end

            if flyDir.Magnitude > 0 then
                primaryPart.AssemblyLinearVelocity = flyDir.Unit * _G.VehicleFlySpeed
            else
                primaryPart.AssemblyLinearVelocity = Vector3.new(0, 0.1, 0)
            end
        end
    end)
end)

-- esp meteor
_G.MeteorTextESP = false

CreateToggle(VisualTab, "ESP METEORS", "MeteorTextESP", function(state)
    _G.MeteorTextESP = state
    
    if not state then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BillboardGui") and obj.Name == "MeteorTextESP_Gui" then
                obj:Destroy()
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5) 
        pcall(function()
            if not _G.MeteorTextESP then return end

            local char = lp.Character
            if not char then return end
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end

            local foldersToCheck = {
                workspace,
                workspace:FindFirstChild("Resources")
            }

            for _, folder in ipairs(foldersToCheck) do
                if folder then
                    for _, obj in ipairs(folder:GetChildren()) do
                        if obj.Name == "Meteor Core" or obj.Name == "Crystal Meteor Core" then
                            local targetPart = obj:IsA("BasePart") and obj or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")))
                            
                            if targetPart then
                                local gui = targetPart:FindFirstChild("MeteorTextESP_Gui")
                                
                                if not gui then
                                    gui = Instance.new("BillboardGui")
                                    gui.Name = "MeteorTextESP_Gui"
                                    gui.Size = UDim2.new(0, 200, 0, 50)
                                    gui.StudsOffset = Vector3.new(0, 3, 0)
                                    gui.AlwaysOnTop = true
                                    gui.Adornee = targetPart
                                    gui.Parent = targetPart

                                    local textLabel = Instance.new("TextLabel", gui)
                                    textLabel.Name = "Text"
                                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                                    textLabel.BackgroundTransparency = 1
                                    textLabel.Font = Enum.Font.Code
                                    textLabel.TextSize = 13
                                    textLabel.TextStrokeTransparency = 0
                                    
                                    if obj.Name == "Crystal Meteor Core" then
                                        textLabel.TextColor3 = Color3.fromRGB(0, 255, 255) -- Ciano
                                    else
                                        textLabel.TextColor3 = Color3.fromRGB(138, 43, 226) -- Roxo
                                    end
                                end

                                local textLabel = gui:FindFirstChild("Text")
                                if textLabel then
                                    local dist = math.floor((rootPart.Position - targetPart.Position).Magnitude)
                                    textLabel.Text = "[" .. obj.Name .. "]\n[" .. dist .. "m]"
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- KILL AURA
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Packets = require(ReplicatedStorage.Modules.Packets)

--// CONFIGURAÇÕES DO KILL AURA
_G.KillAura = false
_G.KillAuraRange = 8
_G.KillAuraShowRange = false
_G.KillAuraIgnoreFriends = true

local MAIN_COLOR = Color3.fromRGB(0, 0, 0)

-- UI NA COMBATTAB
CreateToggle(CombatTab, "Kill Aura", "KillAura", function(state)
    _G.KillAura = state
    if not state then
        local sphere = workspace:FindFirstChild("__KILL_AURA_RANGE__")
        if sphere then sphere:Destroy() end
    end
end)

CreateSlider(CombatTab, "Aura Range", 5, 8, 8, 1, function(val)
    _G.KillAuraRange = val
end)

CreateToggle(CombatTab, "Show Range", "KillAuraShowRange", function(state)
    _G.KillAuraShowRange = state
    if not state then
        local sphere = workspace:FindFirstChild("__KILL_AURA_RANGE__")
        if sphere then sphere:Destroy() end
    end
end)

CreateToggle(CombatTab, "Ignore Friends", "KillAuraIgnoreFriends", function(state)
    _G.KillAuraIgnoreFriends = state
end)

-- ==========================================
-- [ LÓGICA DO KILL AURA ]
-- ==========================================

local lastSwingTick = 0
local SWING_DELAY = 0.12 -- Velocidade de ataque otimizada

-- VISUAL DO ALCANCE (SHOW RANGE)
local function updateRangeVisual(root, range)
    if not _G.KillAuraShowRange then
        local old = workspace:FindFirstChild("__KILL_AURA_RANGE__")
        if old then old:Destroy() end
        return
    end

    local sphere = workspace:FindFirstChild("__KILL_AURA_RANGE__")
    if not sphere then
        sphere = Instance.new("Part")
        sphere.Name = "__KILL_AURA_RANGE__"
        sphere.Shape = Enum.PartType.Ball
        sphere.Material = Enum.Material.ForceField
        sphere.Color = MAIN_COLOR
        sphere.Transparency = 0.65
        sphere.CanCollide = false
        sphere.Anchored = true
        sphere.Parent = workspace
    end

    sphere.Size = Vector3.new(range * 2, range * 2, range * 2)
    sphere.CFrame = root.CFrame
end

-- LOOP DE ATAQUE AUTOMÁTICO
RunService.Heartbeat:Connect(function()
    if not _G.KillAura then return end

    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid or humanoid.Health <= 0 then return end

    local range = _G.KillAuraRange or 20
    updateRangeVisual(root, range)

    if tick() - lastSwingTick < SWING_DELAY then return end

    local targetsToHit = {}

    -- 1. PROCURA JOGADORES NO ALCANCE
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local isFriend = false
            if _G.KillAuraIgnoreFriends then
                pcall(function()
                    isFriend = LocalPlayer:IsFriendsWith(player.UserId)
                end)
            end

            if not isFriend then
                local tChar = player.Character
                local tRoot = tChar:FindFirstChild("HumanoidRootPart") or tChar.PrimaryPart
                local tHum = tChar:FindFirstChildOfClass("Humanoid")

                if tRoot and tHum and tHum.Health > 0 then
                    local dist = (root.Position - tRoot.Position).Magnitude
                    if dist <= range then
                        local entityID = tChar:GetAttribute("EntityID") or player.UserId
                        table.insert(targetsToHit, { entityID = entityID })
                    end
                end
            end
        end
    end

    -- 2. PROCURA CRITTURES / MOBS NO ALCANCE
    local crittersFolder = workspace:FindFirstChild("Critters") or workspace:FindFirstChild("HumanoidCritters")
    if crittersFolder then
        for _, critter in ipairs(crittersFolder:GetChildren()) do
            local cRoot = critter.PrimaryPart or critter:FindFirstChildWhichIsA("BasePart")
            local cHum = critter:FindFirstChildOfClass("Humanoid")
            local entityID = critter:GetAttribute("EntityID")

            if cRoot and entityID and (not cHum or cHum.Health > 0) then
                local dist = (root.Position - cRoot.Position).Magnitude
                if dist <= range then
                    table.insert(targetsToHit, { entityID = entityID })
                end
            end
        end
    end

    -- 3. DISPARA O ATAQUE VIA PACOTE
    if #targetsToHit > 0 then
        lastSwingTick = tick()
        pcall(function()
            Packets.SwingTool.send({
                entityIDs = targetsToHit,
                cframe = root.CFrame,
                timestamp = tick()
            })
        end)
    end
end)

-- ==========================================
-- [ MODULE: AUTO COIN PRESS WITH LIMIT ]
-- Style: Universal HUb Modders (#00FFCC) - AutomationTab
-- ==========================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local lp = Players.LocalPlayer
local PlayerGui = lp:WaitForChild("PlayerGui")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Packets = require(Modules:WaitForChild("Packets"))
local ItemIDS = require(Modules:WaitForChild("ItemIDS"))

_G.AutoCoinPressEnabled = false
_G.CoinPressShowRange = false
_G.CoinPressRange = 25
_G.CoinPressSpeed = 0.1
_G.CoinPressLimit = 200

local startingGold = 0

local function getInventoryGold()
    local t = PlayerGui:FindFirstChild("MainGui")
        and PlayerGui.MainGui:FindFirstChild("RightPanel")
        and PlayerGui.MainGui.RightPanel:FindFirstChild("Inventory")
        and PlayerGui.MainGui.RightPanel.Inventory:FindFirstChild("List")
        and PlayerGui.MainGui.RightPanel.Inventory.List:FindFirstChild("Gold")
        and PlayerGui.MainGui.RightPanel.Inventory.List.Gold:FindFirstChild("QuantityImage")
        and PlayerGui.MainGui.RightPanel.Inventory.List.Gold.QuantityImage:FindFirstChild("QuantityText")

    if t and tonumber(t.Text) then
        return tonumber(t.Text)
    end
    return 0
end

CreateToggle(AutomationTab, "Auto Coin Press", "AutoCoinPressEnabled", function(state)
    _G.AutoCoinPressEnabled = state
    if state then
        startingGold = getInventoryGold()
    end
end)

CreateToggle(AutomationTab, "Show Range", "CoinPressShowRange", function(state)
    _G.CoinPressShowRange = state
    if not state then
        local deployables = Workspace:FindFirstChild("Deployables")
        if deployables then
            for _, obj in ipairs(deployables:GetChildren()) do
                if obj.Name:find("Coin Press") then
                    local sphere = obj:FindFirstChild("ModWareCoinPressSphere")
                    if sphere then sphere:Destroy() end
                end
            end
        end
    end
end)

CreateSlider(AutomationTab, "Press Range", 5, 30, 25, 1, function(val)
    _G.CoinPressRange = val
end)

CreateSlider(AutomationTab, "Press Speed", 0.01, 0.2, 0.1, 0.01, function(val)
    _G.CoinPressSpeed = val
end)

CreateTextbox(AutomationTab, "Gold Limit", "200", function(val)
    local num = tonumber(val)
    if num then
        _G.CoinPressLimit = num
    end
end)

-- Visualizador do Range (Show Range)
task.spawn(function()
    while true do
        task.wait(0.5)
        local deployables = Workspace:FindFirstChild("Deployables")
        if deployables then
            for _, obj in ipairs(deployables:GetChildren()) do
                if obj.Name:find("Coin Press") then
                    local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        local sphere = obj:FindFirstChild("ModWareCoinPressSphere")
                        if _G.CoinPressShowRange then
                            if not sphere then
                                sphere = Instance.new("Part")
                                sphere.Name = "ModWareCoinPressSphere"
                                sphere.Shape = Enum.PartType.Ball
                                sphere.Anchored = true
                                sphere.CanCollide = false
                                sphere.Transparency = 0.85
                                sphere.Color = Color3.fromRGB(255, 255, 255)
                                sphere.Material = Enum.Material.Neon
                                sphere.Parent = obj
                            end
                            local diameter = _G.CoinPressRange * 2
                            sphere.Size = Vector3.new(diameter, diameter, diameter)
                            sphere.Position = primary.Position
                        elseif sphere then
                            sphere:Destroy()
                        end
                    end
                end
            end
        end
    end
end)

-- Lógica principal do Auto Coin Press com Limite e Apenas a Mais Próxima
task.spawn(function()
    local lastInteract = 0

    while true do
        task.wait(0.01)
        if not _G.AutoCoinPressEnabled then continue end

        pcall(function()
            local char = lp.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local currentGold = getInventoryGold()
            if startingGold > 0 and (startingGold - currentGold) >= _G.CoinPressLimit then
                _G.AutoCoinPressEnabled = false
                if ToggleCallbacks["AutoCoinPressEnabled"] then
                    ToggleCallbacks["AutoCoinPressEnabled"](false)
                end
                return
            end

            local deployables = Workspace:FindFirstChild("Deployables")
            if not deployables then return end

            local closestPress = nil
            local shortestDist = _G.CoinPressRange

            for _, obj in ipairs(deployables:GetChildren()) do
                if obj.Name:find("Coin Press") then
                    local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        local dist = (primary.Position - root.Position).Magnitude
                        if dist <= shortestDist then
                            local entityID = obj:GetAttribute("EntityID")
                            if entityID then
                                shortestDist = dist
                                closestPress = obj
                            end
                        end
                    end
                end
            end

            if not closestPress then return end

            local now = tick()
            if now - lastInteract < _G.CoinPressSpeed then return end

            local eid = closestPress:GetAttribute("EntityID")
            if eid then
                lastInteract = now
                pcall(function()
                    Packets.InteractStructure.send({
                        entityID = eid,
                        itemID = ItemIDS["Gold"]
                    })
                end)
            end
        end)
    end
end)

-- ==========================================
-- [ MODULE: AUTO HUT ALL ENEMIES (TRAP ALL) ]
-- Style: Universal HUb Modders (#00FFCC) - AutomationTab
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Packets = require(ReplicatedStorage.Modules.Packets)

_G.AutoHutEnemyAll = false
_G.AutoHutRange = 40

CreateToggle(AutomationTab, "Auto Hut All Enemies", "AutoHutEnemyAll", function(state)
    _G.AutoHutEnemyAll = state
end)

CreateSlider(AutomationTab, "Hut Range", 10, 80, 40, 5, function(val)
    _G.AutoHutRange = val
end)

local lastPlaceTick = 0
local PLACE_DELAY = 0.1
local DISTANCE_OFFSET = -6

RunService.Heartbeat:Connect(function()
    if not _G.AutoHutEnemyAll then return end
    if tick() - lastPlaceTick < PLACE_DELAY then return end

    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    if not root then return end

    -- Percorre todos os jogadores no servidor
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local enemyRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if enemyRoot then
                local dist = (root.Position - enemyRoot.Position).Magnitude
                
                if dist <= _G.AutoHutRange then
                    -- Calcula a posição exata no inimigo com o offset de -6 e ajuste de altura para o chão (-2.5)
                    local targetCF = enemyRoot.CFrame * CFrame.new(0, 0, DISTANCE_OFFSET)
                    
                    -- Verifica se já existe uma Hut colocada neste inimigo/zona
                    local hasHut = false
                    local overlapParts = Workspace:GetPartBoundsInBox(targetCF, Vector3.new(8, 6, 8))
                    for _, part in ipairs(overlapParts) do
                        if part.Name == "Big Ol' Hut" or part:FindFirstAncestor("Big Ol' Hut") then
                            hasHut = true
                            break
                        end
                    end

                    -- Se o inimigo ainda não tiver Hut, coloca e passa para o próximo
                    if not hasHut then
                        lastPlaceTick = tick()
                        pcall(function()
                            Packets.PlaceStructure.send({
                                cframe = targetCF,
                                buildingName = "Big Ol' Hut"
                            })
                        end)
                        break -- Coloca uma por ciclo (respeitando o delay de 0.1s) para prender todos sequencialmente sem falhas
                    end
                end
            end
        end
    end
end)

