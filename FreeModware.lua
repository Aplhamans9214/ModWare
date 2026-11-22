-- is for booga ok genious?
-- locais Iniciais
setfpscap(244)

Players = game:GetService("Players")
UserInputService = game:GetService("UserInputService")
RunService = game:GetService("RunService")
Player = Players.LocalPlayer
Lighting = game:GetService("Lighting")
lp = Players.LocalPlayer
PlayerGui = lp:WaitForChild("PlayerGui")
Camera = workspace.CurrentCamera
VIM = game:GetService("VirtualInputManager")
TeleportService = game:GetService("TeleportService")
HttpService = game:GetService("HttpService")
TweenService = game:GetService("TweenService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
StarterGui = game:GetService("StarterGui")
CoreGui = game:GetService("CoreGui")
Workspace = game:GetService("Workspace")
LocalPlayer = Players.LocalPlayer

-- limit 1 gui
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

-- hub colors
local ColorTable = {
    ["MainColor1 (White)"]        = Color3.fromHex("#FFFFFF"),
    ["MainColor2 (Spring Green)"] = Color3.fromHex("#00FF7F"),
    ["MainColor3 (Cyan)"]         = Color3.fromHex("#00FFFF"),
    ["MainColor4 (Lime Green)"]   = Color3.fromHex("#00FF00"),
    ["MainColor5 (Lawn Green)"]   = Color3.fromHex("#7CFC00"),
    ["MainColor6 (Gold)"]         = Color3.fromHex("#FFD700"),
    ["MainColor7 (Red)"]          = Color3.fromHex("#FF0000"),
    ["MainColor8 (Dark Orange)"]  = Color3.fromHex("#FF8C00"),
    ["MainColor9 (Crimson)"]      = Color3.fromHex("#DC143C"),
    ["MainColor10 (Deep Pink)"]   = Color3.fromHex("#FF1493"),
    ["MainColor11 (Magenta)"]     = Color3.fromHex("#FF00FF"),
    ["MainColor12 (Indigo)"]      = Color3.fromHex("#4B0082")
}

local ColorListNames = {
    "MainColor1 (White)",
    "MainColor2 (Spring Green)",
    "MainColor3 (Cyan)",
    "MainColor4 (Lime Green)",
    "MainColor5 (Lawn Green)",
    "MainColor6 (Gold)",
    "MainColor7 (Red)",
    "MainColor8 (Dark Orange)",
    "MainColor9 (Crimson)",
    "MainColor10 (Deep Pink)",
    "MainColor11 (Magenta)",
    "MainColor12 (Indigo)"
}

local CurrentActiveColor = ColorTable["MainColor1 (White)"]
_G.HubKeybind = Enum.KeyCode.Q
_G.DefaultMiniTabsOpen = false

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
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundTransparency = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false

local MainHubCorner = Instance.new("UICorner", MainFrame)
MainHubCorner.CornerRadius = UDim.new(0, 6)

local MainStroke11 = Instance.new("UIStroke", MainFrame)
MainStroke11.Thickness = 2
MainStroke11.Color = CurrentActiveColor
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
TooltipStroke.Color = CurrentActiveColor
TooltipStroke.Thickness = 1
TooltipStroke.Transparency = 0.8

local DragBar = Instance.new("Frame", MainFrame)
DragBar.Size = UDim2.new(1, 0, 0, 35)
DragBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
DragBar.BorderSizePixel = 0
DragBar.Active = true

local DragCorner = Instance.new("UICorner", DragBar)
DragCorner.CornerRadius = UDim.new(0, 6)

local DragLabel = Instance.new("TextLabel", DragBar)
DragLabel.Size = UDim2.new(1, 0, 1, 0)
DragLabel.Text = "ModWare Hub"
DragLabel.TextColor3 = CurrentActiveColor
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

-- tabs
local TabList = Instance.new("ScrollingFrame", MainFrame)
TabList.Size = UDim2.new(0, 120, 1, -55)
TabList.Position = UDim2.new(0, 10, 0, 45)
TabList.BackgroundTransparency = 1
TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabList.ScrollBarThickness = 0

local TabLayout = Instance.new("UIListLayout", TabList)
TabLayout.Padding = UDim.new(0, 8)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -145, 1, -55)
Container.Position = UDim2.new(0, 135, 0, 45)
Container.BackgroundTransparency = 1

local ActiveDropdownClose = nil

local ThemeUpdaters = {}
local ToggleCallbacks = {}
local SliderCallbacks = {}
local DropdownCallbacks = {}
local TabButtonsMap = {}

local function RegisterThemeElement(element, property, isAccentOnly)
    table.insert(ThemeUpdaters, function(newColor)
        if element and element.Parent then
            if isAccentOnly then
                if element:GetAttribute("IsActiveAccent") then
                    element[property] = newColor
                end
            else
                element[property] = newColor
            end
        end
    end)
    if not isAccentOnly or element:GetAttribute("IsActiveAccent") then
        element[property] = CurrentActiveColor
    end
end

local function SetHubThemeColor(color)
    CurrentActiveColor = color
    MainStroke11.Color = color
    DragLabel.TextColor3 = color
    TooltipStroke.Color = color

    for btn, isSelected in pairs(TabButtonsMap) do
        if isSelected then
            btn.BackgroundColor3 = color
            btn.TextColor3 = Color3.new(0, 0, 0)
        else
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            btn.TextColor3 = color
        end
    end

    for _, updater in ipairs(ThemeUpdaters) do
        updater(color)
    end
end

-- CreateTab
local function CreateTab(name)
    local TabBtn = Instance.new("TextButton", TabList)
    TabBtn.Size = UDim2.new(1, 0, 0, 32)
    TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabBtn.Text = name
    TabBtn.TextColor3 = CurrentActiveColor
    TabBtn.Font = Enum.Font.Code
    TabBtn.TextSize = 14
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    TabButtonsMap[TabBtn] = false

    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    
    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 12)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local PagePadding = Instance.new("UIPadding", Page)
    PagePadding.PaddingLeft = UDim.new(0, 10)
    PagePadding.PaddingRight = UDim.new(0, 10)
    PagePadding.PaddingTop = UDim.new(0, 2)
    PagePadding.PaddingBottom = UDim.new(0, 10)

    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.ElasticBehavior = Enum.ElasticBehavior.Always
    Page.ScrollBarThickness = 0

    TabBtn.MouseButton1Click:Connect(function()
        if ActiveDropdownClose then ActiveDropdownClose() end
        for b, _ in pairs(TabButtonsMap) do 
            TabButtonsMap[b] = false
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 25) 
            b.TextColor3 = CurrentActiveColor 
        end
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        
        Page.Visible = true
        TabButtonsMap[TabBtn] = true
        TabBtn.BackgroundColor3 = CurrentActiveColor
        TabBtn.TextColor3 = Color3.new(0, 0, 0)
    end)

    local count = 0
    for _ in pairs(TabButtonsMap) do count += 1 end
    if count == 1 then
        Page.Visible = true
        TabButtonsMap[TabBtn] = true
        TabBtn.BackgroundColor3 = CurrentActiveColor
        TabBtn.TextColor3 = Color3.new(0, 0, 0)
    end

    return Page
end

-- CreateMiniTab
local function CreateMiniTab(parent, title, startsOpen)
    local MiniFrame = Instance.new("Frame")
    MiniFrame.Name = "MiniTab_" .. tostring(title)
    MiniFrame.Parent = parent
    MiniFrame.Size = UDim2.new(1, 0, 0, 32)
    MiniFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MiniFrame.BorderSizePixel = 0
    MiniFrame.ClipsDescendants = true
    Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0, 6)

    local MiniStroke = Instance.new("UIStroke", MiniFrame)
    MiniStroke.Color = Color3.fromRGB(35, 35, 35)
    MiniStroke.Thickness = 1

    local HeaderButton = Instance.new("TextButton", MiniFrame)
    HeaderButton.Size = UDim2.new(1, 0, 0, 32)
    HeaderButton.BackgroundTransparency = 1
    HeaderButton.Text = ""

    local TitleLabel = Instance.new("TextLabel", HeaderButton)
    TitleLabel.Size = UDim2.new(1, -40, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.Text = string.upper(tostring(title or "Section"))
    TitleLabel.TextColor3 = CurrentActiveColor
    TitleLabel.Font = Enum.Font.Code
    TitleLabel.TextSize = 12
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    RegisterThemeElement(TitleLabel, "TextColor3", false)

    local ToggleIcon = Instance.new("TextLabel", HeaderButton)
    ToggleIcon.Size = UDim2.new(0, 25, 1, 0)
    ToggleIcon.Position = UDim2.new(1, -30, 0, 0)
    ToggleIcon.Text = "-"
    ToggleIcon.TextColor3 = Color3.fromRGB(200, 200, 200)
    ToggleIcon.Font = Enum.Font.Code
    ToggleIcon.TextSize = 16
    ToggleIcon.BackgroundTransparency = 1

    local ContentContainer = Instance.new("Frame", MiniFrame)
    ContentContainer.Name = "Content"
    ContentContainer.Size = UDim2.new(1, -16, 0, 0)
    ContentContainer.Position = UDim2.new(0, 8, 0, 34)
    ContentContainer.AutomaticSize = Enum.AutomaticSize.Y
    ContentContainer.BackgroundTransparency = 1

    local Layout = Instance.new("UIListLayout", ContentContainer)
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    local Padding = Instance.new("UIPadding", ContentContainer)
    Padding.PaddingBottom = UDim.new(0, 8)

    local shouldOpen = startsOpen
    if shouldOpen == nil then
        shouldOpen = (_G.DefaultMiniTabsOpen ~= false)
    end

    local isExpanded = shouldOpen

    local function ApplyExpandState(open)
        isExpanded = open
        if isExpanded then
            ToggleIcon.Text = "-"
            MiniFrame.AutomaticSize = Enum.AutomaticSize.Y
        else
            ToggleIcon.Text = "+"
            MiniFrame.AutomaticSize = Enum.AutomaticSize.None
            MiniFrame.Size = UDim2.new(1, 0, 0, 32)
        end
    end

    ApplyExpandState(shouldOpen)

    HeaderButton.MouseButton1Click:Connect(function()
        ApplyExpandState(not isExpanded)
    end)

    return ContentContainer
end

-- CreateButton
local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.Text = text
    Btn.TextColor3 = CurrentActiveColor
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 13
    Btn.Active = true
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    RegisterThemeElement(Btn, "TextColor3", false)

    Btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return Btn
end

-- CreateTextbox
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
    Label.TextColor3 = CurrentActiveColor
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    Label.TextTruncate = Enum.TextTruncate.AtEnd
    Label.ZIndex = 11
    RegisterThemeElement(Label, "TextColor3", false)

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

-- CreateDropdown (Com altura adaptável baseada na quantidade de opções e scroll automático se forem 6 ou mais)
local function CreateDropdown(parent, title, options, defaultSelections, isMulti, globalName, callback)
    if type(globalName) == "function" then
        callback, globalName = globalName, nil
    end
    if type(isMulti) == "string" then
        globalName, isMulti = isMulti, false
    end

    globalName = globalName or (tostring(title):gsub("%W", "") .. "Dropdown")
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

    _G[globalName] = selectedTable

    local isOpen = false
    local optionListFrame
    local dropdownObj = {}

    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = "Dropdown_" .. tostring(title)
    DropdownFrame.Parent = parent
    DropdownFrame.Size = UDim2.new(1, 0, 0, 38)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.ClipsDescendants = false

    local MainButton = Instance.new("TextButton")
    MainButton.Parent = DropdownFrame
    MainButton.Size = UDim2.new(1, 0, 0, 38)
    MainButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainButton.BorderSizePixel = 0
    MainButton.TextWrapped = false
    MainButton.TextTruncate = Enum.TextTruncate.AtEnd
    MainButton.AutoButtonColor = true
    MainButton.TextColor3 = CurrentActiveColor
    MainButton.TextXAlignment = Enum.TextXAlignment.Left
    MainButton.Font = Enum.Font.Code
    MainButton.TextSize = 13
    Instance.new("UICorner", MainButton).CornerRadius = UDim.new(0, 6)
    RegisterThemeElement(MainButton, "TextColor3", false)

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
    Arrow.TextColor3 = CurrentActiveColor
    Arrow.Font = Enum.Font.Code
    Arrow.TextSize = 12
    RegisterThemeElement(Arrow, "TextColor3", false)

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
        _G[globalName] = selectedTable
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
        DropdownFrame.Size = UDim2.new(1, 0, 0, 38)
        if ActiveDropdownClose == CloseDropdown then ActiveDropdownClose = nil end
        if optionListFrame then optionListFrame:Destroy() optionListFrame = nil end
    end

    local currentFilter = ""
    local function renderOptions(container, optionButtons, filterText, visibleCount)
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
                OptButton.Text = (selectedTable[option] and "✓  " or "    ") .. tostring(option)
                OptButton.Font = Enum.Font.Code
                OptButton.TextSize = 13
                OptButton.TextXAlignment = Enum.TextXAlignment.Left
                OptButton.TextColor3 = selectedTable[option] and CurrentActiveColor or Color3.fromRGB(150,150,150)
                if selectedTable[option] then
                    OptButton:SetAttribute("IsActiveAccent", true)
                    RegisterThemeElement(OptButton, "TextColor3", true)
                end
                
                local pad = Instance.new("UIPadding", OptButton)
                pad.PaddingLeft = UDim.new(0, 10)
                OptButton.MouseButton1Click:Connect(function()
                    if isMulti then
                        selectedTable[option] = not selectedTable[option]
                        UpdateButtonText()
                        FireSelectionCallback()
                        renderOptions(container, optionButtons, currentFilter, visibleCount)
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

    local function OpenDropdown()
        if isOpen then return end
        if ActiveDropdownClose then ActiveDropdownClose() end
        isOpen = true
        Arrow.Text = "▲"
        ActiveDropdownClose = CloseDropdown

        -- Calcula a quantidade de opções visíveis (limitando o cálculo base a no máximo 5 ou 6 para o scroll entrar se passar de 5/6)
        local totalOptions = #options
        local displayCount = math.clamp(totalOptions, 1, 5)
        local listHeight = displayCount * 32
        local totalContainerHeight = listHeight + 32 -- 32 pixels reservados para a barra de pesquisa superior

        DropdownFrame.Size = UDim2.new(1, 0, 0, 38 + totalContainerHeight + 6)

        optionListFrame = Instance.new("Frame")
        optionListFrame.Parent = DropdownFrame
        optionListFrame.Size = UDim2.new(1, 0, 0, totalContainerHeight)
        optionListFrame.Position = UDim2.new(0, 0, 0, 42)
        optionListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        optionListFrame.BorderSizePixel = 0
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
        SearchBox.PlaceholderText = "Search Option..."
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
        OptionsContainer.ScrollBarThickness = (totalOptions > 5) and 4 or 0
        OptionsContainer.CanvasSize = UDim2.new()

        local optionButtons = {}
        renderOptions(OptionsContainer, optionButtons, "", displayCount)

        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            if isOpen and optionListFrame and optionListFrame.Parent then
                renderOptions(OptionsContainer, optionButtons, SearchBox.Text, displayCount)
            end
        end)
    end

    MainButton.MouseButton1Click:Connect(function()
        if isOpen then CloseDropdown() else OpenDropdown() end
    end)

    function dropdownObj:Set(newSelections)
        selectedTable = {}
        if type(newSelections) == "table" then
            for k, v in pairs(newSelections) do
                if type(k) == "string" and v == true then
                    selectedTable[k] = true
                elseif type(v) == "string" then
                    selectedTable[v] = true
                end
            end
        elseif type(newSelections) == "string" then
            selectedTable[newSelections] = true
        end
        _G[globalName] = selectedTable
        UpdateButtonText()
        FireSelectionCallback()
    end

    DropdownCallbacks[globalName] = function(val)
        dropdownObj:Set(val)
    end

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
        _G[globalName] = selectedTable
        UpdateButtonText()
        if isOpen then CloseDropdown() end
    end

    UpdateButtonText()

    return dropdownObj
end

-- Create Slider
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

    globalName = globalName or (tostring(text):gsub("%W", "") .. "Slider")

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
    Label.TextColor3 = CurrentActiveColor
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    Label.ZIndex = 11
    RegisterThemeElement(Label, "TextColor3", false)

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
    Fill.BackgroundColor3 = CurrentActiveColor
    Fill.ZIndex = 12
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    RegisterThemeElement(Fill, "BackgroundColor3", false)

    local Knob = Instance.new("Frame")
    Knob.Parent = Track
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.BackgroundColor3 = CurrentActiveColor
    Knob.Active = true
    Knob.ZIndex = 13
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
    RegisterThemeElement(Knob, "BackgroundColor3", false)

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
    Label.TextColor3 = CurrentActiveColor
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextTruncate = Enum.TextTruncate.AtEnd
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    RegisterThemeElement(Label, "TextColor3", false)

    local Switch = Instance.new("TextButton")
    Switch.Parent = TFrame
    Switch.Size = UDim2.new(0, 46, 0, 22)
    Switch.AnchorPoint = Vector2.new(1, 0.5)
    Switch.Position = UDim2.new(1, -8, 0.5, 0)
    Switch.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Switch.BorderSizePixel = 0
    Switch.Text = ""
    Switch.AutoButtonColor = false
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Stroke = Instance.new("UIStroke", Switch)
    Stroke.Color = Color3.fromRGB(120, 120, 120)
    Stroke.Thickness = 1

    local Knob = Instance.new("Frame")
    Knob.Parent = Switch
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = UDim2.new(0, 3, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(0.5, 0)

    RegisterThemeElement(Switch, "BackgroundColor3", true)
    RegisterThemeElement(Stroke, "Color", true)

    local currentState = _G[global] == true
    local function UpdateToggle(state, fireCallback)
        currentState = state == true
        _G[global] = currentState
        Switch:SetAttribute("IsActiveAccent", currentState)
        Stroke:SetAttribute("IsActiveAccent", currentState)

        if currentState then
            Switch.BackgroundColor3 = CurrentActiveColor
            Stroke.Color = CurrentActiveColor
            Knob.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            Knob:TweenPosition(UDim2.new(1, -19, 0.5, -8), "Out", "Quad", 0.15, true)
        else
            Switch.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Stroke.Color = Color3.fromRGB(120, 120, 120)
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
    Label.TextColor3 = CurrentActiveColor
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    Label.TextWrapped = true
    RegisterThemeElement(Label, "TextColor3", false)

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
    Label.TextColor3 = CurrentActiveColor
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.TextSize = 13
    RegisterThemeElement(Label, "TextColor3", false)

    local Box = Instance.new("TextButton", KFrame)
    Box.Size = UDim2.new(0.3, -10, 0, 23)
    Box.Position = UDim2.new(0.7, 0, 0.5, -11)
    Box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Box.Text = defaultKey.Name
    Box.TextColor3 = CurrentActiveColor
    Box.Font = Enum.Font.Code
    Box.TextSize = 13
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    RegisterThemeElement(Box, "TextColor3", false)

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

-- toggle
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 80, 0, 40)
OpenBtn.AnchorPoint = Vector2.new(0, 0.5)
OpenBtn.Position = UDim2.new(0, 15, 0.45, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
OpenBtn.RichText = true
OpenBtn.Text = "TOGGLE"
OpenBtn.TextColor3 = CurrentActiveColor
OpenBtn.Font = Enum.Font.Code
OpenBtn.TextSize = 18
OpenBtn.Active = true
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)
RegisterThemeElement(OpenBtn, "TextColor3", false)

local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Thickness = 1.5
RegisterThemeElement(OpenStroke, "Color", true)

local dragBtn, dragStartBtn, startPosBtn, touchInputObject, isDragging = false, nil, nil, nil, false
OpenBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragBtn = true isDragging = false dragStartBtn = input.Position startPosBtn = OpenBtn.Position touchInputObject = input
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
        dragBtn = false isDragging = false touchInputObject = nil
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
UnloadBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
UnloadBtn.Text = "CLOSE ALL SCRIPT"
UnloadBtn.TextColor3 = CurrentActiveColor
UnloadBtn.Font = Enum.Font.Code
UnloadBtn.TextSize = 14
UnloadBtn.Active = true
Instance.new("UICorner", UnloadBtn).CornerRadius = UDim.new(0, 6)
RegisterThemeElement(UnloadBtn, "TextColor3", false)

UnloadBtn.MouseButton1Click:Connect(function()
    UnloadHub()
end)

-- Compact Gui
_G.CompactGui = false
CreateToggle(SettingsTab, "Compact Gui", "CompactGui", function(state)
    _G.CompactGui = state
    if state then
        MainFrame:TweenSize(UDim2.new(0, 440, 0, 320), "Out", "Quad", 0.4, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 600, 0, 460), "Out", "Quad", 0.4, true)
    end
end)

-- ui corner
_G.CustomUICornerEnabled = false
_G.HubCornerRadius = 6
local function ApplyUICorner(radius)
    local r = _G.CustomUICornerEnabled and UDim.new(0, math.clamp(radius, 0, 12)) or UDim.new(0, 6)
    MainHubCorner.CornerRadius = r
    DragCorner.CornerRadius = r
end

CreateToggle(SettingsTab, "Custom Ui Corner", "CustomUICornerEnabled", function(state)
    _G.CustomUICornerEnabled = state
    ApplyUICorner(_G.HubCornerRadius or 6)
end)

CreateSlider(SettingsTab, "Corner Radius", 0, 12, 6, "HubCornerRadius", 1, function(val)
    _G.HubCornerRadius = val
    if _G.CustomUICornerEnabled then
        ApplyUICorner(val)
    end
end)

-- Hub Theme Color Dropdown
CreateDropdown(SettingsTab, "Hub Color", ColorListNames, "MainColor1 (White)", false, "HubThemeColor", function(chosen)
    if ColorTable[chosen] then
        SetHubThemeColor(ColorTable[chosen])
    end
end)

-- config mini tabs
CreateToggle(SettingsTab, "Default MiniTabs Open", "DefaultMiniTabsOpen", function(state)
    _G.DefaultMiniTabsOpen = state
end)

-- Gui Transparency
_G.EnableTransparency = false
_G.TransparencyN = 0.1

CreateToggle(SettingsTab, "Gui Transparency", "EnableTransparency", function(state)
    _G.EnableTransparency = state
    if state then
        MainFrame.BackgroundTransparency = math.clamp(_G.TransparencyN or 0.1, 0, 0.4)
    else
        MainFrame.BackgroundTransparency = 0
    end
end)

CreateSlider(SettingsTab, "Transparency", 0, 0.4, 0.1, "TransparencyN", 0.01, function(val)
    _G.TransparencyN = math.clamp(val, 0, 0.4)
    if _G.EnableTransparency then
        MainFrame.BackgroundTransparency = _G.TransparencyN
    end
end)

-- Keybind
CreateKeybind(SettingsTab, "HUB KEYBIND", Enum.KeyCode.Q, "HubKeybind", function(newKey)
    print("HUB NEW KEYBIND:", newKey.Name)
end)

-- ==========================================
-- ANTI AFK
-- ==========================================

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

local lp = Players.LocalPlayer

_G.AntiAFK = false
_G.AFKConnection = nil

local function SetAntiAFK(state)
    _G.AntiAFK = state

    if _G.AFKConnection then
        _G.AFKConnection:Disconnect()
        _G.AFKConnection = nil
    end

    if not state then
        return
    end

    _G.AFKConnection = lp.Idled:Connect(function()
        if not _G.AntiAFK then return end

        VirtualInputManager:SendKeyEvent(
            true,
            Enum.KeyCode.RightControl,
            false,
            game
        )

        task.wait(0.1)

        VirtualInputManager:SendKeyEvent(
            false,
            Enum.KeyCode.RightControl,
            false,
            game
        )
    end)
end

CreateToggle(SettingsTab, "ANTI-AFK", "AntiAFK", function(state)
    SetAntiAFK(state)
end)

-- fps boost universal
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

_G.FPSBoostEnabled = false
_G.RemoveTextures = false
_G.RemoveShadows = false
_G.PotatoGraphics = false
_G.DisableParticles = false

local MiniTabFPS = CreateMiniTab(SettingsTab, "FPS Boost And Others", false)

-- Toggle Principal
CreateToggle(MiniTabFPS, "Enable FPS Boost", "FPSBoostEnabled", function(state)
    _G.FPSBoostEnabled = state
    if not state then
        -- Restaura as configurações originais ao desligar
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 100000
        if Terrain then
            Terrain.WaterWaveSize = 0.05
            Terrain.WaterTransparency = 0.3
        end
    end
end)

_G.RemoveGrass = false

CreateToggle(MiniTabFPS, "REMOVE GRASS", "RemoveGrass", function(state)
    _G.RemoveGrass = state
    
    pcall(function()
        local terrain = workspace:FindFirstChildOfClass("Terrain") or workspace.Terrain
        if terrain then
            sethiddenproperty(terrain, "Decoration", not _G.RemoveGrass)
        end
    end)
end)

-- Remover Texturas e Materiais (Deixa tudo liso/Plastic)
CreateToggle(MiniTabFPS, "Remove Textures", "RemoveTextures", function(state)
    _G.RemoveTextures = state
    task.spawn(function()
        while _G.FPSBoostEnabled and _G.RemoveTextures do
            task.wait(1)
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                        obj.Material = Enum.Material.Plastic
                        obj.Reflectance = 0
                    elseif obj:IsA("Texture") or obj:IsA("Decal") then
                        obj.Transparency = 1
                    end
                end
            end)
        end
    end)
end)

-- Remover Sombras e Iluminação Complexa
CreateToggle(MiniTabFPS, "Remove Shadows", "RemoveShadows", function(state)
    _G.RemoveShadows = state
    task.spawn(function()
        while _G.FPSBoostEnabled and _G.RemoveShadows do
            task.wait(0.5)
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 999999
                for _, effect in ipairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") then
                        effect.Enabled = false
                    end
                end
            end)
        end
    end)
end)

-- Gráficos Batata (Remove Água e Efeitos de Terreno)
CreateToggle(MiniTabFPS, "Potato Graphics", "PotatoGraphics", function(state)
    _G.PotatoGraphics = state
    pcall(function()
        if state and _G.FPSBoostEnabled then
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterTransparency = 1
                Terrain.WaterReflectance = 0
            end
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end
    end)
end)

-- Desativar Partículas e Efeitos de Fogo/Fumaça
CreateToggle(MiniTabFPS, "Disable Particles", "DisableParticles", function(state)
    _G.DisableParticles = state
    task.spawn(function()
        while _G.FPSBoostEnabled and _G.DisableParticles do
            task.wait(1)
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                        obj.Enabled = false
                    end
                end
            end)
        end
    end)
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

CreateToggle(MiniTabFPS, "FULLBRIGHT", "FullbrightEnabled", function(state)
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

-- nofog
_G.RemoveFogEnabled = false

CreateToggle(MiniTabFPS, "REMOVE MAP FOG", "RemoveFogEnabled", function(state)
    _G.RemoveFogEnabled = state
    local lighting = game:GetService("Lighting")
    if state then
        lighting.FogEnd = 9e9
        for _, obj in pairs(lighting:GetChildren()) do
            if obj:IsA("Atmosphere") then
                obj.Density = 0
            end
        end
    else
        lighting.FogEnd = 1000
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

-- Configs System
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

local configDropdown = CreateDropdown(ConfigTab, "Config List", GetSavedConfigsList(), "None", false, "SelectedConfigDropdown", function(chosen)
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
                if type(v) == "boolean" or type(v) == "number" or type(v) == "string" or type(v) == "table" then
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
                if type(v) == "boolean" or type(v) == "number" or type(v) == "string" or type(v) == "table" then
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
                if DropdownCallbacks[k] then
                    DropdownCallbacks[k](v)
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
                    if DropdownCallbacks[k] then
                        DropdownCallbacks[k](v)
                    end
                end
                SendNotify("ModWare Hub", "AutoLoad Enabled  (" .. autoName .. ")!", 3)
            end
        end
    end)
end)

-- Variável global estruturada sem quebrar com 'return'
_G.ModWareHub = {
    ScreenGui = ScreenGui,
    MainFrame = MainFrame,
    CreateTab = CreateTab,
    CreateMiniTab = CreateMiniTab,
    CreateButton = CreateButton,
    CreateToggle = CreateToggle,
    CreateSlider = CreateSlider,
    CreateDropdown = CreateDropdown,
    CreateTextbox = CreateTextbox,
    CreateKeybind = CreateKeybind,
    CreateText = CreateText,
    SendNotify = SendNotify,
    SettingsTab = SettingsTab,
    PlayerTab = PlayerTab,
    AutomationTab = AutomationTab,
    FarmTab = FarmTab,
    CombatTab = CombatTab,
    VisualTab = VisualTab,
    MoveTab = MoveTab,
    MiscTab = MiscTab,
    ConfigTab = ConfigTab
}

local Modules = ReplicatedStorage:WaitForChild("Modules")
local ItemIDS = require(Modules:WaitForChild("data"):WaitForChild("itemIDS"))
local Packets = require(Modules:WaitForChild("util"):WaitForChild("packets"))
local GameUtil = require(Modules:WaitForChild("util"):WaitForChild("gameUtil"))

--// ============================================================================
--// KILL AURA + AUTO HIT (CHECAGEM POR workspace.players.<player>.tools)
--// ============================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// MÓDULOS
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Packets = require(Modules:WaitForChild("util"):WaitForChild("packets"))
local Clock = require(Modules:WaitForChild("util"):WaitForChild("clock"))

local SLASH_ANIMS = {
    ["Left Slash"] = "rbxassetid://118005934400248",
    ["Right Slash"] = "rbxassetid://10761451679",
}

--// ITENS QUE NÃO DISPARAM SWING ANIMATION
local EXCLUDED_TOOLS = {
    ["sling"] = true,
    ["repair hammer"] = true,
    ["fishing rod"] = true,
    ["saddle"] = true,
    ["big saddle"] = true,
    ["bow"] = true,
    ["iron bow"] = true,
    ["war horn"] = true,
    ["shovel"] = true,
    ["crossbow"] = true,
    ["magnetite crossbow"] = true,
    ["god sling"] = true,
    ["oof horn"] = true,
}

local function normalizeToolName(name)
    if type(name) ~= "string" then
        return ""
    end
    return string.lower((string.gsub(name, "^%s*(.-)%s*$", "%1")))
end

local function isExcludedTool(name)
    local norm = normalizeToolName(name)
    if norm == "" then
        return true
    end
    return EXCLUDED_TOOLS[norm] == true
end

local function getPlayerToolsFolder()
    local playersFolder = workspace:FindFirstChild("players") or workspace:FindFirstChild("Players")
    if not playersFolder then
        return nil
    end

    local pEntry = playersFolder:FindFirstChild(LocalPlayer.Name)
    if not pEntry then
        local lowerName = string.lower(LocalPlayer.Name)
        for _, child in ipairs(playersFolder:GetChildren()) do
            if string.lower(child.Name) == lowerName then
                pEntry = child
                break
            end
        end
    end

    if not pEntry then
        return nil
    end

    return pEntry:FindFirstChild("tools") or pEntry:FindFirstChild("Tools")
end

local function hasValidToolInFolder()
    local toolsFolder = getPlayerToolsFolder()
    if not toolsFolder then
        return false
    end

    for _, item in ipairs(toolsFolder:GetChildren()) do
        if not isExcludedTool(item.Name) then
            return true
        end
        local attrItem = item:GetAttribute("ItemName") or item:GetAttribute("ToolName") or item:GetAttribute("Name")
        if attrItem and not isExcludedTool(tostring(attrItem)) then
            return true
        end
    end

    return false
end

--// ============================================================================
--// FUNÇÕES UTILITÁRIAS
--// ============================================================================

local function getServerTime()
    local ok, res = pcall(function()
        return Clock.getServerTime(true)
    end)
    if ok and type(res) == "number" then
        return res
    end
    return os.clock()
end

local function getEntityId(inst)
    if not inst then return nil end
    local raw = inst:GetAttribute("EntityID") or inst:GetAttribute("Id") or inst:GetAttribute("ID")
    if raw == nil then
        local valObj = inst:FindFirstChild("EntityID") or inst:FindFirstChild("Id") or inst:FindFirstChild("ID")
        if valObj and valObj:IsA("ValueBase") then
            raw = valObj.Value
        end
    end
    local numId = tonumber(raw)
    if numId and numId >= 0 then
        return numId
    end
    return nil
end

local function getPartPosition(inst)
    if not inst then return nil end
    if inst:IsA("BasePart") then
        return inst.Position
    end
    if inst:IsA("Model") then
        local root = inst:FindFirstChild("HumanoidRootPart") or inst.PrimaryPart
        if root and root:IsA("BasePart") then
            return root.Position
        end
        local part = inst:FindFirstChildWhichIsA("BasePart")
        if part then
            return part.Position
        end
        local ok, cf = pcall(function()
            return inst:GetPivot()
        end)
        if ok and cf then
            return cf.Position
        end
    end
    return nil
end

local function createSwingController(getEnabled, getSlashType)
    local ctrl = {
        cachedTracks = {},
        currentTrack = nil,
        nextAllowedAnimClock = 0,
    }

    function ctrl:stop()
        self.nextAllowedAnimClock = 0
        if self.currentTrack then
            local t = self.currentTrack
            self.currentTrack = nil
            pcall(function()
                t:Stop(0.12)
            end)
        end
        for _, track in pairs(self.cachedTracks) do
            pcall(function()
                if track.IsPlaying then
                    track:Stop(0.12)
                end
            end)
        end
    end

    function ctrl:reset()
        table.clear(self.cachedTracks)
        self.currentTrack = nil
        self.nextAllowedAnimClock = 0
    end

    function ctrl:getOrLoadTrack(humanoid, animId)
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        local existing = self.cachedTracks[animId]
        if existing and existing.Parent then
            return existing
        end

        local anim = Instance.new("Animation")
        anim.AnimationId = animId

        local ok, track = pcall(function()
            return animator:LoadAnimation(anim)
        end)
        anim:Destroy()

        if ok and track then
            track.Priority = Enum.AnimationPriority.Action
            track.Looped = false
            self.cachedTracks[animId] = track
            return track
        end
        return nil
    end

    function ctrl:step(humanoid, char)
        if not getEnabled() or not char or not humanoid or humanoid.Health <= 0 or not hasValidToolInFolder() then
            self:stop()
            return
        end

        local chosenType = getSlashType() or "Right Slash"
        local animId = SLASH_ANIMS[chosenType] or SLASH_ANIMS["Right Slash"]
        local nowClock = os.clock()

        if nowClock < self.nextAllowedAnimClock then
            return
        end

        local track = self:getOrLoadTrack(humanoid, animId)
        if not track then return end

        if self.currentTrack and self.currentTrack ~= track then
            pcall(function()
                self.currentTrack:Stop(0.08)
            end)
        end

        self.currentTrack = track
        pcall(function()
            track.Looped = false
            track:AdjustSpeed(1)
            track:Play(0.06, 1, 1)
        end)

        local len = 0
        pcall(function()
            len = track.Length or 0
        end)
        local duration = (len > 0.05) and len or 0.45
        self.nextAllowedAnimClock = nowClock + duration
    end

    return ctrl
end

--// ============================================================================
--// 1. KILL AURA
--// ============================================================================

_G.KillAura = _G.KillAura or false
_G.KillAuraRange = _G.KillAuraRange or 8
_G.KillAuraShowRange = _G.KillAuraShowRange or false
_G.KillAuraIgnoreFriends = (_G.KillAuraIgnoreFriends == nil) and true or _G.KillAuraIgnoreFriends
_G.SwingAnimation = _G.SwingAnimation or false
_G.SwingAnimationType = _G.SwingAnimationType or "Right Slash"

local KillAuraM = CreateMiniTab(CombatTab, "Kill Aura", true)
local kaAnim = createSwingController(
    function() return _G.SwingAnimation end,
    function() return _G.SwingAnimationType end
)

local rangeSphere: Part? = nil
local friendCache: { [number]: { isFriend: boolean, expiresAt: number } } = {}

local function destroyRangeVisual()
    if rangeSphere and rangeSphere.Parent then
        rangeSphere:Destroy()
    end
    rangeSphere = nil

    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name == "__KILL_AURA_RANGE__" then
            child:Destroy()
        end
    end
end

CreateToggle(KillAuraM, "Kill Aura", "KillAura", function(state)
    _G.KillAura = state
    if not state then
        destroyRangeVisual()
        kaAnim:stop()
    end
end)

CreateSlider(KillAuraM, "Aura Range", 5, 8, _G.KillAuraRange, 1, function(val)
    _G.KillAuraRange = val
end)

CreateToggle(KillAuraM, "Show Range", "KillAuraShowRange", function(state)
    _G.KillAuraShowRange = state
    if not state then
        destroyRangeVisual()
    end
end)

CreateToggle(KillAuraM, "Ignore Friends", "KillAuraIgnoreFriends", function(state)
    _G.KillAuraIgnoreFriends = state
end)

CreateToggle(KillAuraM, "Swing Animation", "SwingAnimation", function(state)
    _G.SwingAnimation = state
    if not state then
        kaAnim:stop()
    end
end)

CreateDropdown(KillAuraM, "Slash Type", { "Right Slash", "Left Slash" }, { _G.SwingAnimationType }, false, function(selected)
    local val = type(selected) == "table" and selected[1] or selected
    if val and SLASH_ANIMS[val] then
        _G.SwingAnimationType = val
        kaAnim.nextAllowedAnimClock = 0
    end
end)

local function isPlayerFriend(player: Player): boolean
    local now = os.clock()
    local cached = friendCache[player.UserId]
    if cached and now < cached.expiresAt then
        return cached.isFriend
    end

    local ok, res = pcall(function()
        return LocalPlayer:IsFriendsWith(player.UserId)
    end)
    local result = ok and (res == true) or false
    friendCache[player.UserId] = {
        isFriend = result,
        expiresAt = now + 30,
    }
    return result
end

local lastSwingClock = 0
local SWING_DELAY = 0.12

local function updateRangeVisual(root: BasePart, range: number)
    if not _G.KillAuraShowRange or not _G.KillAura then
        destroyRangeVisual()
        return
    end

    if not rangeSphere or not rangeSphere.Parent then
        local sphere = Instance.new("Part")
        sphere.Name = "__KILL_AURA_RANGE__"
        sphere.Shape = Enum.PartType.Ball
        sphere.Material = Enum.Material.ForceField
        sphere.Transparency = 0.65
        sphere.CanCollide = false
        sphere.CanQuery = false
        sphere.CanTouch = false
        sphere.Anchored = true
        sphere.Parent = workspace
        rangeSphere = sphere
    end

    if typeof(CurrentActiveColor) == "Color3" then
        rangeSphere.Color = CurrentActiveColor
    end

    local diameter = range * 2
    rangeSphere.Size = Vector3.new(diameter, diameter, diameter)
    rangeSphere.CFrame = root.CFrame
end

RunService.Heartbeat:Connect(function()
    if not _G.KillAura then
        destroyRangeVisual()
        kaAnim:stop()
        return
    end

    local char = LocalPlayer.Character
    if not char then
        kaAnim:stop()
        return
    end

    local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not root:IsA("BasePart") or not humanoid or humanoid.Health <= 0 then
        destroyRangeVisual()
        kaAnim:stop()
        return
    end

    local range = tonumber(_G.KillAuraRange) or 8
    local rangeSq = range * range
    updateRangeVisual(root, range)

    local entityIds = {}
    local seenIds = {}
    local rootPos = root.Position

    local function tryAddTarget(modelOrPart, fallbackId)
        local pos = getPartPosition(modelOrPart)
        if not pos then return end

        local dx = rootPos.X - pos.X
        local dy = rootPos.Y - pos.Y
        local dz = rootPos.Z - pos.Z
        if (dx * dx + dy * dy + dz * dz) > rangeSq then return end

        local id = getEntityId(modelOrPart) or fallbackId
        if not id or seenIds[id] then return end

        seenIds[id] = true
        table.insert(entityIds, id)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if not (_G.KillAuraIgnoreFriends and isPlayerFriend(player)) then
                local tChar = player.Character
                local tHum = tChar:FindFirstChildOfClass("Humanoid")
                if not tHum or tHum.Health > 0 then
                    local playerEntityId = getEntityId(tChar) or getEntityId(player)
                    tryAddTarget(tChar, playerEntityId)
                end
            end
        end
    end

    local crittersFolder = workspace:FindFirstChild("Critters") or workspace:FindFirstChild("HumanoidCritters")
    if crittersFolder then
        for _, critter in ipairs(crittersFolder:GetChildren()) do
            local cHum = critter:FindFirstChildOfClass("Humanoid")
            if not cHum or cHum.Health > 0 then
                tryAddTarget(critter, nil)
            end
        end
    end

    if #entityIds == 0 then
        kaAnim:stop()
        return
    end

    kaAnim:step(humanoid, char)

    local nowClock = os.clock()
    if nowClock - lastSwingClock >= SWING_DELAY then
        lastSwingClock = nowClock
        local serverNow = getServerTime()
        pcall(function()
            Packets.SwingTool.send({
                entityIDs = entityIds,
                playerStates = {},
                cframe = root.CFrame,
                timestamp = serverNow,
            })
        end)
    end
end)

--// ============================================================================
--// 2. AUTO HIT (ÁREA DE DETECÇÃO + ÁREA DE ATAQUE)
--// ============================================================================

_G.AutosHit = _G.AutosHit or false
_G.AutosHitRange = _G.AutosHitRange or 20
_G.AutosSelectedTargets = _G.AutosSelectedTargets or { "Resources" }
_G.AutoHitSwingAnimation = _G.AutoHitSwingAnimation or false
_G.AutoHitSwingAnimationType = _G.AutoHitSwingAnimationType or "Right Slash"

local DETECTION_PADDING = 18

local autoHitOptions = {
    "Critters",
    "Deployables",
    "Resources",
    "Meteors",
    "Dropped Chests",
    "Rubble",
}

local ahAnim = createSwingController(
    function() return _G.AutoHitSwingAnimation end,
    function() return _G.AutoHitSwingAnimationType end
)

local AutoH = CreateMiniTab(AutomationTab, "Auto Hit", false)

CreateToggle(AutoH, "Auto Hit: ", "AutosHit", function(state)
    _G.AutosHit = state
    if not state then
        ahAnim:stop()
    end
end)

CreateDropdown(AutoH, "Targets", autoHitOptions, _G.AutosSelectedTargets, true, function(selected)
    if type(selected) == "table" then
        _G.AutosSelectedTargets = selected
    elseif type(selected) == "string" then
        _G.AutosSelectedTargets = { selected }
    else
        _G.AutosSelectedTargets = { "Resources" }
    end
end)

CreateSlider(AutoH, "Auto Hit Range", 5, 20, _G.AutosHitRange, 1, function(val)
    _G.AutosHitRange = val
end)

CreateToggle(AutoH, "Swing Animation", "AutoHitSwingAnimation", function(state)
    _G.AutoHitSwingAnimation = state
    if not state then
        ahAnim:stop()
    end
end)

CreateDropdown(AutoH, "Slash Type", { "Right Slash", "Left Slash" }, { _G.AutoHitSwingAnimationType }, false, function(selected)
    local val = type(selected) == "table" and selected[1] or selected
    if val and SLASH_ANIMS[val] then
        _G.AutoHitSwingAnimationType = val
        ahAnim.nextAllowedAnimClock = 0
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    kaAnim:reset()
    ahAnim:reset()
    destroyRangeVisual()
end)

local function resolveTargetAndId(partOrModel)
    local curr = partOrModel
    for _ = 1, 5 do
        if not curr or curr == workspace then
            break
        end
        if curr:IsA("Model") or curr:IsA("BasePart") then
            local id = getEntityId(curr)
            if id then
                return curr, id
            end
        end
        curr = curr.Parent
    end
    return nil, nil
end

local function isInPathOrName(inst, namesMap)
    local curr = inst
    for _ = 1, 4 do
        if not curr or curr == workspace then
            break
        end
        if namesMap[curr.Name] then
            return true
        end
        curr = curr.Parent
    end
    return false
end

local TARGET_PATH_MAP = {
    ["Critters"] = { ["Critters"] = true },
    ["Deployables"] = { ["Deployables"] = true, ["Totems"] = true, ["Voxels"] = true },
    ["Resources"] = {
        ["Resources"] = true,
        ["Breakaway"] = true,
        ["Mounds"] = true,
        ["ScavengerMounds"] = true,
        ["Treasure Chest"] = true,
    },
    ["Dropped Chests"] = { ["dropChests"] = true },
    ["Meteors"] = {
        ["Crystal Meteor Core"] = true,
        ["Crystal Meteor Rock"] = true,
        ["Small Rock"] = true,
        ["Meteor Core"] = true,
        ["Meteor Rock"] = true,
    },
    ["Rubble"] = { ["Rubble"] = true },
}

local function matchesSelectedTarget(inst, selectedSet)
    for targetName in pairs(selectedSet) do
        local map = TARGET_PATH_MAP[targetName]
        if map and isInPathOrName(inst, map) then
            return true
        end
    end
    return false
end

task.spawn(function()
    local lastHitClock = 0
    local wasEnabled = false

    local overlapParams = OverlapParams.new()
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude

    while true do
        task.wait(0.06)

        if not _G.AutosHit then
            if wasEnabled then
                ahAnim:stop()
                wasEnabled = false
            end
            continue
        end
        wasEnabled = true

        local success, err = pcall(function()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")

            if not char or not root or not humanoid or humanoid.Health <= 0 then
                ahAnim:stop()
                return
            end

            local attackRange = _G.AutosHitRange or 20
            local attackRangeSq = attackRange * attackRange
            local detectionRadius = attackRange + DETECTION_PADDING
            local rootPos = root.Position

            local selectedSet = {}
            for _, targetName in ipairs(_G.AutosSelectedTargets or {}) do
                selectedSet[targetName] = true
            end

            overlapParams.FilterDescendantsInstances = { char }

            local nearbyParts = workspace:GetPartBoundsInRadius(rootPos, detectionRadius, overlapParams)
            local checkedModels = {}
            local detectedCandidates = {}

            for _, part in ipairs(nearbyParts) do
                local targetInst, id = resolveTargetAndId(part)
                if targetInst and id and not checkedModels[targetInst] then
                    checkedModels[targetInst] = true

                    if matchesSelectedTarget(targetInst, selectedSet) then
                        local pos = getPartPosition(targetInst)
                        if pos then
                            table.insert(detectedCandidates, {
                                id = id,
                                pos = pos,
                            })
                        end
                    end
                end
            end

            local entityIds = {}
            local seenIds = {}

            for _, cand in ipairs(detectedCandidates) do
                if not seenIds[cand.id] then
                    local dx = rootPos.X - cand.pos.X
                    local dy = rootPos.Y - cand.pos.Y
                    local dz = rootPos.Z - cand.pos.Z
                    if (dx * dx + dy * dy + dz * dz) <= attackRangeSq then
                        seenIds[cand.id] = true
                        table.insert(entityIds, cand.id)
                    end
                end
            end

            if #entityIds == 0 then
                ahAnim:stop()
                return
            end

            ahAnim:step(humanoid, char)

            local nowClock = os.clock()
            if nowClock - lastHitClock >= 0.08 then
                lastHitClock = nowClock
                local serverNow = getServerTime()
                pcall(function()
                    Packets.SwingTool.send({
                        entityIDs = entityIds,
                        playerStates = {},
                        cframe = root.CFrame,
                        timestamp = serverNow,
                    })
                end)
            end
        end)

        if not success then
            warn("[AutoHit] Erro:", err)
        end
    end
end)

-- ==========================================
-- UNIVERSAL HUB MODDERS - AUTO PICKUP (FIXED DROPDOWN)
-- ==========================================

_G.AutoPickup = _G.AutoPickup or false
_G.PickupAll = _G.PickupAll or false
_G.AutoPickupChests = _G.AutoPickupChests or false
_G.ChestPickupAll = _G.ChestPickupAll or false
_G.ShowPickupAOE = _G.ShowPickupAOE or false
_G.PickupRadius = _G.PickupRadius or 30
_G.MaxPickupCount = _G.MaxPickupCount or 1500

_G.PickupCount = _G.PickupCount or 0

_G.Whitelist = _G.Whitelist or {
    ["Gold"] = true
}

_G.ItemList = {
    "Gold", "Raw Gold", "Haunted Spirit", "Spirit Key", "Steel", "Wood", "Leaves", "Log",
    "Raw Iron", "Raw Magnetite", "Raw Adurite", "Adurite", "Ice Cube", "Crystal Chunk",
    "Stone", "Hide", "Pink Diamond", "Carrot", "Lemon", "Cooked Egg", "Coal", "Fire Hide",
    "Pumpkin", "Iron", "Magnetite", "Raw Pink Diamond", "Raw Fish", "Void Shard", "Obsidian",
    "Berry", "Jelly", "Rope", "Bluefruit", "Cooked Meat", "Raw Meat", "Wood Plank", "Essence",
    "Raw Emerald", "Bloodfruit", "Coin", "Void Essence", "Vine", "Sand", "Glass", "Scute",
    "Cooked Fish", "Raw Squid", "Cooked Squid", "Raw Crab", "Cooked Crab", "Raw Baracuda",
    "Cooked Baracuda", "Raw Eel", "Cooked Eel", "Raw Morsel", "Cooked Morsel", "Cloudberry",
    "Strawberry", "Orange", "Apple", "Strangefruit", "Barley", "Banana", "Mango", "Oddberry",
    "Coconut", "Pumpkins", "Sunfruit", "Frostfruit", "Blossom", "Watermelon", "Egg", "Fried Egg",
    "Bread", "Burger", "Pie", "Fruit Cake", "Cornbread", "Meat Sandwich", "Jelly Sandwich",
    "Corn Mush", "Grain Mush", "Fried Cactus", "Corn", "Cactus Bit", "Peeper Popsicle",
    "Frozen Pumpkin", "Prickly Pear", "Swiftness Potion", "Ice Potion", "Haste Potion",
    "Healing Potion", "Strength Potion", "Weakness Potion", "Harming Potion", "Poison Potion",
    "Fire Resistance Potion", "Coin Stack", "Tropical Fish", "Old Boot", "Raw Chomper",
    "Gold Fish", "Gold Squid", "Void Fish", "Jelly Salmon", "Glowfish", "Strangefish",
    "Flaming Chomper", "Worm", "Shrimp", "Coin2", "Emerald"
}

_G.PickupAOEFolder = workspace:FindFirstChild("PickupAOE") or Instance.new("Folder")
_G.PickupAOEFolder.Name = "PickupAOE"
_G.PickupAOEFolder.Parent = workspace

_G.UpdateRing = function(position, radius)
    (function()
        _G.PickupAOEFolder:ClearAllChildren()
        _G.Segments = 40
        for i = 1, _G.Segments do
            _G.Angle = (i / _G.Segments) * math.pi * 2
            _G.X = math.cos(_G.Angle) * radius
            _G.Z = math.sin(_G.Angle) * radius
            
            _G.Part = Instance.new("Part")
            _G.Part.Anchored = true
            _G.Part.CanCollide = false
            _G.Part.CanQuery = false
            _G.Part.CanTouch = false
            _G.Part.Material = Enum.Material.Neon
            _G.Part.Color = CurrentActiveColor
            _G.Part.Transparency = 0.2
            _G.Part.Size = Vector3.new(0.3, 0.3, radius * 0.15)
            _G.Part.CFrame = CFrame.new(position + Vector3.new(_G.X, 0.05, _G.Z)) * CFrame.Angles(0, -_G.Angle, 0)
            _G.Part.Parent = _G.PickupAOEFolder
        end
    end)()
end

_G.IsItemWhitelisted = function(item)
    local status, result = true, (function()
        _G.ItemName = item.Name
        _G.AttrName = item:GetAttribute("ItemName") or item:GetAttribute("ItemID") or item:GetAttribute("Name")
        
        if _G.Whitelist[_G.ItemName] then return true end
        if _G.AttrName and _G.Whitelist[tostring(_G.AttrName)] then return true end
        
        _G.CleanName = string.gsub(_G.ItemName, "%s+", ""):lower()
        for k, v in pairs(_G.Whitelist) do
            if v and string.gsub(tostring(k), "%s+", ""):lower() == _G.CleanName then
                return true
            end
        end
        return false
    end)()
    return status and result or false
end

-- ==========================================
-- [ ELEMENTOS DA UI (MINITAB) ]
-- ==========================================

AutoP = CreateMiniTab(AutomationTab, "Auto Pickup", false)

CreateToggle(AutoP, "Auto Pickup Whitelist", "AutoPickup", function(state)
    _G.AutoPickup = state
end)

CreateToggle(AutoP, "Pickup ALL Items", "PickupAll", function(state)
    _G.PickupAll = state
end)

CreateToggle(AutoP, "Auto Pickup Chests", "AutoPickupChests", function(state)
    _G.AutoPickupChests = state
end)

CreateToggle(AutoP, "Chest Pickup ALL", "ChestPickupAll", function(state)
    _G.ChestPickupAll = state
end)

CreateToggle(AutoP, "Show Pickup Range", "ShowPickupAOE", function(state)
    _G.ShowPickupAOE = state
    if not state then _G.PickupAOEFolder:ClearAllChildren() end
end)

CreateSlider(AutoP, "Pickup Radius", 5, 30, 30, "PickupRadius", 1, function(val)
    _G.PickupRadius = val
end)

-- Dropdown corrigido para tratar corretamente a tabela de seleção
CreateDropdown(AutoP, "Select Item to Whitelist", _G.ItemList, {"Gold"}, true, "WhitelistDropdown", function(selectedData)
    (function()
        _G.Whitelist = {}
        if type(selectedData) == "table" then
            for k, v in pairs(selectedData) do
                if type(v) == "string" then
                    _G.Whitelist[v] = true
                elseif type(k) == "string" and v == true then
                    _G.Whitelist[k] = true
                end
            end
        elseif type(selectedData) == "string" then
            _G.Whitelist[selectedData] = true
        end
    end)()
end)

-- ==========================================
-- [ LOOP PRINCIPAL DE COLETA ]
-- ==========================================

local lastPickupReset = tick()

if _G.AutoPickupConnection then
    _G.AutoPickupConnection:Disconnect()
end

_G.AutoPickupConnection = game:GetService("RunService").Heartbeat:Connect(function()
    (function()
        if not lp or not lp.Character then return end
        
        local now = tick()
        if now - lastPickupReset >= 1 then
            _G.PickupCount = 0
            lastPickupReset = now
        end
        
        _G.CharRoot = lp.Character:FindFirstChild("HumanoidRootPart")
        if not _G.CharRoot then return end
        _G.CharPos = _G.CharRoot.Position
        
        -- Coleta no Workspace (Items)
        if workspace:FindFirstChild("Items") then
            for _, item in pairs(workspace.Items:GetChildren()) do
                if (_G.PickupCount or 0) >= (_G.MaxPickupCount or 1500) then break end
                
                _G.EntityID = item:GetAttribute("EntityID")
                if not _G.EntityID then continue end
                
                _G.ItemPivot = item:GetPivot()
                if not _G.ItemPivot then continue end
                
                _G.Distance = (_G.CharPos - _G.ItemPivot.Position).Magnitude
                if _G.Distance > (_G.PickupRadius or 30) then continue end
                
                if _G.PickupAll or (_G.AutoPickup and _G.IsItemWhitelisted(item)) then
                    if Packets and Packets.Pickup then
                        Packets.Pickup.send(_G.EntityID)
                        _G.PickupCount = (_G.PickupCount or 0) + 1
                    end
                end
            end
        end
        
        -- Coleta em Baús (Deployables)
        if (_G.AutoPickupChests or _G.ChestPickupAll) and workspace:FindFirstChild("Deployables") then
            _G.ClosestChest = nil
            _G.ClosestDist = math.huge
            
            for _, model in pairs(workspace.Deployables:GetChildren()) do
                _G.Contents = model:FindFirstChild("Contents")
                _G.ModelPivot = model:GetPivot()
                if _G.Contents and #_G.Contents:GetChildren() > 0 and _G.ModelPivot then
                    _G.Dist = (_G.CharPos - _G.ModelPivot.Position).Magnitude
                    if _G.Dist < _G.ClosestDist then
                        _G.ClosestDist = _G.Dist
                        _G.ClosestChest = _G.Contents
                    end
                end
            end
            
            if _G.ClosestChest and _G.ClosestDist <= (_G.PickupRadius or 30) then
                for _, item in pairs(_G.ClosestChest:GetChildren()) do
                    if (_G.PickupCount or 0) >= (_G.MaxPickupCount or 1500) then break end
                    
                    _G.EntityID = item:GetAttribute("EntityID")
                    if not _G.EntityID then continue end
                    
                    if _G.ChestPickupAll or (_G.AutoPickupChests and _G.IsItemWhitelisted(item)) then
                        if Packets and Packets.Pickup then
                            Packets.Pickup.send(_G.EntityID)
                            _G.PickupCount = (_G.PickupCount or 0) + 1
                        end
                    end
                end
            end
        end
        
        -- Render do Anel AOE
        if _G.ShowPickupAOE then
            _G.UpdateRing(_G.CharPos - Vector3.new(0, 3, 0), _G.PickupRadius or 30)
        elseif _G.PickupAOEFolder and #_G.PickupAOEFolder:GetChildren() > 0 then
            _G.PickupAOEFolder:ClearAllChildren()
        end
    end)()
end)

-- ==========================================
-- [ AUTO FARM COMPLETO, RÁPIDO & OTIMIZADO ]
-- ==========================================

_G.AutoPlant = false
_G.AutoHarvest = false
_G.AutoMovePlantBox = false
_G.AutoMoveBush = false
_G.AutoMoveBushAndBox = false

_G.PlantRange = 25
_G.HarvestRange = 28
_G.AutoMoveRange = 30
_G.FarmMoveSpeed = 17
_G.FarmMoveMode = "Tween"

local foods = {
    "Bloodfruit", "Lemon", "Pumpkin", "Berry", "Carrot",
    "Cloudberry", "Strawberry", "Orange", "Apple", "Jelly",
    "Strangefruit", "Barley", "Banana", "Watermelon", "Blossom",
    "Mango", "Oddberry", "Coconut", "Sunfruit", "Frostfruit", "Bluefruit"
}

local selectedFarmFoods = {"Bloodfruit"}
local foodIndexRotation = 1

local currentTween = nil
local currentMoveTargetModel = nil
local currentTargetGui = nil

local plantingCooldown = {}
local harvestCooldown = {}

-- Restaura o movimento e controles normais do personagem
local function stopMovement()
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end

    currentMoveTargetModel = nil

    local char = lp.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:Move(Vector3.zero, false)
            humanoid.AutoRotate = true
            humanoid.WalkSpeed = 16
        end
    end
end

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

-- CONTROLES DA UI
ATFBL = CreateMiniTab(FarmTab, "AUTO FARM", false)

CreateDropdown(ATFBL, "Movement Mode", {"Tween", "CFrame", "Walk"}, "Tween", false, function(chosen)
    _G.FarmMoveMode = chosen
    stopMovement()
end)

CreateToggle(ATFBL, "Auto Plant", "AutoPlant", function(state)
    _G.AutoPlant = state
end)

CreateSlider(ATFBL, "Plant Range", 5, 25, 25, 1, function(val)
    _G.PlantRange = val
end)

CreateToggle(ATFBL, "Auto Harvest", "AutoHarvest", function(state)
    _G.AutoHarvest = state
end)

CreateSlider(ATFBL, "Harvest Range", 5, 28, 28, 1, function(val)
    _G.HarvestRange = val
end)

CreateDropdown(ATFBL, "Select Farm Food: ", foods, {"Bloodfruit"}, true, function(selected)
    if type(selected) == "table" and #selected > 0 then
        selectedFarmFoods = selected
    elseif type(selected) == "string" and selected ~= "" then
        selectedFarmFoods = {selected}
    else
        selectedFarmFoods = {"Bloodfruit"}
    end

    foodIndexRotation = 1
end)

CreateToggle(ATFBL, "Auto Move to Plant Box", "AutoMovePlantBox", function(state)
    _G.AutoMovePlantBox = state
    if not state then stopMovement() end
end)

CreateToggle(ATFBL, "Auto Move to Bush", "AutoMoveBush", function(state)
    _G.AutoMoveBush = state
    if not state then stopMovement() end
end)

CreateToggle(ATFBL, "Auto Move Bush and Plantbox", "AutoMoveBushAndBox", function(state)
    _G.AutoMoveBushAndBox = state
    if not state then stopMovement() end
end)

CreateSlider(ATFBL, "Auto Move Range", 10, 250, 30, 5, function(val)
    _G.AutoMoveRange = val
end)

CreateSlider(ATFBL, "Move Speed", 1, 19, 17, 1, function(val)
    _G.FarmMoveSpeed = val
end)

-- HIGHLIGHT VISUAL DO ALVO
local function setTarget(model)
    (function()
        if not model then
            if currentTargetGui then
                currentTargetGui:Destroy()
                currentTargetGui = nil
            end
            return
        end

        local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
        if not part then return end

        if currentTargetGui and currentTargetGui.Adornee == part then
            return
        end

        if currentTargetGui then
            currentTargetGui:Destroy()
            currentTargetGui = nil
        end

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
        label.TextColor3 = CurrentActiveColor

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 0, 0)
        stroke.Thickness = 2
        stroke.Parent = label

        label.Parent = gui
        currentTargetGui = gui
    end)()
end

-- ALTURA REAL E SEGURA DO CHÃO
local function getExactGroundPosition(part, humanoid, root)
    local rawPos = part.Position
    local rayOrigin = Vector3.new(rawPos.X, rawPos.Y + 10, rawPos.Z)
    local rayDirection = Vector3.new(0, -40, 0)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude

    local excluded = {}

    if lp.Character then
        table.insert(excluded, lp.Character)
    end

    if part and part.Parent then
        table.insert(excluded, part.Parent)
    end

    raycastParams.FilterDescendantsInstances = excluded

    local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    local groundY = rawPos.Y

    if rayResult and rayResult.Position then
        groundY = rayResult.Position.Y
    elseif root then
        groundY = root.Position.Y - humanoid.HipHeight
    end

    return Vector3.new(
        rawPos.X,
        groundY + humanoid.HipHeight + 0.5,
        rawPos.Z
    )
end

-- DETECÇÃO OTIMIZADA DE PLANT BOXES
local function getSortedPlantBoxes(origin, range)
    local results = {}
    local deployables = workspace:FindFirstChild("Deployables") or workspace

    ;(function()
        for _, obj in ipairs(deployables:GetChildren()) do
            if obj.Name:find("Plant Box") then
                local eid = obj:GetAttribute("EntityID")
                local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")

                if primary and eid then
                    local dist = (origin - primary.Position).Magnitude

                    if dist <= range then
                        table.insert(results, {
                            model = obj,
                            dist = dist
                        })
                    end
                end
            end
        end

        table.sort(results, function(a, b)
            return a.dist < b.dist
        end)
    end)()

    local sorted = {}

    for _, item in ipairs(results) do
        table.insert(sorted, item.model)
    end

    return sorted
end

-- ==========================================
-- AUTO PLANT - PRIORIDADE POR PROXIMIDADE
-- ==========================================

task.spawn(function()
    local lastCleanupClock = os.clock()

    while true do
        task.wait(0.02)

        if not _G.AutoPlant then
            continue
        end

        (function()
            local char = lp.Character
            if not char then return end

            local root = char:FindFirstChild("HumanoidRootPart")
                or char.PrimaryPart

            if not root then return end

            if type(selectedFarmFoods) ~= "table" or #selectedFarmFoods == 0 then
                return
            end

            local deployables = workspace:FindFirstChild("Deployables")
                or workspace

            local range = tonumber(_G.PlantRange) or 25
            local rangeSq = range * range
            local rootX = root.Position.X
            local rootZ = root.Position.Z
            local now = os.clock()

            if now - lastCleanupClock >= 15 then
                lastCleanupClock = now
                for id, ts in pairs(plantingCooldown) do
                    if now - ts > 30 then
                        plantingCooldown[id] = nil
                    end
                end
            end

            local maxPerTick = 6
            local planted = 0
            local used = {}

            while planted < maxPerTick do
                local nearestBox = nil
                local nearestId = nil
                local nearestDistSq = math.huge

                for _, box in ipairs(deployables:GetChildren()) do
                    if not used[box]
                    and box.Parent
                    and box:IsA("Model")
                    and string.find(box.Name, "Plant Box", 1, true)
                    and not box:FindFirstChild("Seed")
                    and not box:FindFirstChild("Plant") then

                        local id = box:GetAttribute("EntityID")
                        local part = box.PrimaryPart
                            or box:FindFirstChildWhichIsA("BasePart")

                        if id and part then
                            local cooldown = plantingCooldown[id] or 0
                            if (now - cooldown) >= 0.2 then
                                local dx = rootX - part.Position.X
                                local dz = rootZ - part.Position.Z
                                local distSq = dx * dx + dz * dz

                                if distSq <= rangeSq and distSq < nearestDistSq then
                                    nearestDistSq = distSq
                                    nearestBox = box
                                    nearestId = id
                                end
                            end
                        end
                    end
                end

                if not nearestBox then
                    break
                end

                used[nearestBox] = true

                if foodIndexRotation > #selectedFarmFoods or foodIndexRotation < 1 then
                    foodIndexRotation = 1
                end

                local foodName = selectedFarmFoods[foodIndexRotation]
                local itemID = ItemIDS and ItemIDS[foodName]

                if not itemID then
                    break
                end

                plantingCooldown[nearestId] = os.clock()

                Packets.InteractStructure.send({
                    entityID = nearestId,
                    itemID = itemID
                })

                planted += 1
                foodIndexRotation += 1

                if foodIndexRotation > #selectedFarmFoods then
                    foodIndexRotation = 1
                end

                task.wait(0.01)
            end
        end)()
    end
end)

-- ==========================================
-- LOOP 2: AUTO HARVEST
-- ==========================================

task.spawn(function()
    while true do
        task.wait(0.1)

        if not _G.AutoHarvest then
            continue
        end

        (function()
            local char = lp.Character
            if not char then return end

            local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if not root then return end

            local origin = root.Position

            local harvestBoxes = getSortedPlantBoxes(origin, _G.HarvestRange)

            for _, box in ipairs(harvestBoxes) do
                local id = box:GetAttribute("EntityID")

                if id and (box:FindFirstChild("Seed") or box:FindFirstChild("Plant")) then
                    local last = harvestCooldown[id] or 0

                    if tick() - last >= 0.1 then
                        harvestCooldown[id] = tick()

                        Packets.InteractStructure.send({
                            entityID = id,
                            itemID = 0
                        })
                    end
                end
            end

            local cropsFolder = workspace:FindFirstChild("Crops")

            if cropsFolder then
                for _, bush in ipairs(cropsFolder:GetChildren()) do
                    local id = bush:GetAttribute("EntityID")
                    local primary = bush.PrimaryPart or bush:FindFirstChildWhichIsA("BasePart")

                    if id and primary then
                        local dist = (origin - primary.Position).Magnitude

                        if dist <= _G.HarvestRange then
                            local last = harvestCooldown[id] or 0

                            if tick() - last >= 0.1 then
                                harvestCooldown[id] = tick()

                                ;(function()
                                    Packets.Pickup.send(id)
                                end)()

                                ;(function()
                                    Packets.InteractStructure.send({
                                        entityID = id,
                                        itemID = 0
                                    })
                                end)()
                            end
                        end
                    end
                end
            end
        end)()
    end
end)

-- ==========================================
-- LOOP 3: AUTO MOVE
-- ==========================================

local lastTargetCheck = 0
local cachedTarget = nil

local blockedMoveTargets = {}
local progressTarget = nil
local lastProgressPosition = nil
local lastProgressTime = os.clock()
local lastWalkMove = 0
local lastStopped = false

local function isMoveTargetBlocked(target, now)
    local expiry = blockedMoveTargets[target]

    if not expiry then
        return false
    end

    if now >= expiry then
        blockedMoveTargets[target] = nil
        return false
    end

    return true
end

local function resetMoveProgress(root)
    progressTarget = cachedTarget
    lastProgressPosition = root and root.Position or nil
    lastProgressTime = os.clock()
    lastWalkMove = 0
end

RunService.RenderStepped:Connect(function(dt)
    local enabled =
        _G.AutoMovePlantBox
        or _G.AutoMoveBush
        or _G.AutoMoveBushAndBox

    if not enabled then
        if cachedTarget or not lastStopped then
            cachedTarget = nil
            setTarget(nil)
            stopMovement()
            lastStopped = true
        end

        progressTarget = nil
        return
    end

    lastStopped = false
    local now = os.clock()

    -- Recalcula o alvo a cada 0.15s.
    if now - lastTargetCheck >= 0.15 then
        lastTargetCheck = now

        ;(function()
            local char = lp.Character
            if not char then return end

            local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if not root then return end

            local charPos = root.Position
            local chosenTarget = nil
            local shortestDist = tonumber(_G.AutoMoveRange) or 30

            -- PRIORIDADE: ARBUSTOS SELECIONADOS

            if _G.AutoMoveBush or _G.AutoMoveBushAndBox then
                local crops = workspace:FindFirstChild("Crops")

                if crops then
                    for _, bush in ipairs(crops:GetChildren()) do
                        if matchesAnyFood(bush.Name)
                        and not isMoveTargetBlocked(bush, now) then

                            local part = bush.PrimaryPart or bush:FindFirstChildWhichIsA("BasePart")
                            local id = bush:GetAttribute("EntityID")

                            if part and id then
                                local dist = (charPos - part.Position).Magnitude

                                if dist < shortestDist then
                                    shortestDist = dist
                                    chosenTarget = bush
                                end
                            end
                        end
                    end
                end
            end

            -- DEPOIS, PLANT BOXES VAZIAS

            if not chosenTarget and (_G.AutoMovePlantBox or _G.AutoMoveBushAndBox) then
                local boxes = getSortedPlantBoxes(charPos, shortestDist + 0.01)

                for _, box in ipairs(boxes) do
                    if not isMoveTargetBlocked(box, now)
                    and not box:FindFirstChild("Seed")
                    and not box:FindFirstChild("Plant") then

                        local part = box.PrimaryPart or box:FindFirstChildWhichIsA("BasePart")

                        if part then
                            local dist = (charPos - part.Position).Magnitude

                            if dist < shortestDist then
                                shortestDist = dist
                                chosenTarget = box
                            end
                        end
                    end
                end
            end

            if chosenTarget ~= cachedTarget then
                cachedTarget = chosenTarget
                setTarget(chosenTarget)

                if currentTween then
                    currentTween:Cancel()
                    currentTween = nil
                end

                currentMoveTargetModel = nil
                resetMoveProgress(root)
            end
        end)()
    end

    if not cachedTarget or not cachedTarget.Parent then
        cachedTarget = nil
        setTarget(nil)
        stopMovement()
        progressTarget = nil
        return
    end

    (function()
        local char = lp.Character
        if not char then return end

        local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
        local humanoid = char:FindFirstChildOfClass("Humanoid")

        if not root or not humanoid then return end

        -- Se a Plant Box já foi plantada, para de segui-la.
        if cachedTarget.Name:find("Plant Box")
        and (cachedTarget:FindFirstChild("Seed") or cachedTarget:FindFirstChild("Plant")) then

            cachedTarget = nil
            setTarget(nil)
            stopMovement()
            progressTarget = nil
            return
        end

        local part = cachedTarget.PrimaryPart or cachedTarget:FindFirstChildWhichIsA("BasePart")

        if not part then
            blockedMoveTargets[cachedTarget] = now + 4
            cachedTarget = nil
            setTarget(nil)
            stopMovement()
            progressTarget = nil
            return
        end

        local targetPos = getExactGroundPosition(part, humanoid, root)

        local horizontalTarget = Vector3.new(
            targetPos.X,
            root.Position.Y,
            targetPos.Z
        )

        local difference = horizontalTarget - root.Position
        local distance = difference.Magnitude

        if distance < 1.5 then
            stopMovement()
            progressTarget = nil
            return
        end

        -- DETECTOR DE TRAVAMENTO

        if progressTarget ~= cachedTarget then
            resetMoveProgress(root)

        elseif (root.Position - lastProgressPosition).Magnitude >= 0.3 then
            lastProgressPosition = root.Position
            lastProgressTime = now

        elseif now - lastProgressTime >= 1.6 then
            blockedMoveTargets[cachedTarget] = now + 5
            cachedTarget = nil
            setTarget(nil)
            stopMovement()
            progressTarget = nil
            return
        end

        local speed = math.clamp(
            tonumber(_G.FarmMoveSpeed) or 17,
            1,
            19
        )

        local direction = difference.Unit
        local moveMode = _G.FarmMoveMode or "Tween"

        -- WALK

        if moveMode == "Walk" then
            if currentTween then
                currentTween:Cancel()
                currentTween = nil
            end

            currentMoveTargetModel = nil
            humanoid.WalkSpeed = speed
            humanoid.AutoRotate = true

            humanoid:Move(direction, false)

        -- CFRAME

        elseif moveMode == "CFrame" then
            if currentTween then
                currentTween:Cancel()
                currentTween = nil
            end

            currentMoveTargetModel = nil
            humanoid.AutoRotate = false

            local cframeSpeed = speed
            local step = math.min(
                distance,
                cframeSpeed * math.min(dt, 0.05)
            )

            local nextPos = root.Position + direction * step

            -- Raycast do chão na posição seguinte.
            -- Não usa a altura da Plant Box, evitando afundar o personagem.

            local rayParams = RaycastParams.new()
            rayParams.FilterType = Enum.RaycastFilterType.Exclude

            local excluded = {char}
            if cachedTarget then
                table.insert(excluded, cachedTarget)
            end

            rayParams.FilterDescendantsInstances = excluded

            local rayOrigin = Vector3.new(
                nextPos.X,
                root.Position.Y + 10,
                nextPos.Z
            )

            local rayDirection = Vector3.new(0, -40, 0)
            local ground = workspace:Raycast(rayOrigin, rayDirection, rayParams)

            if ground then
                nextPos = Vector3.new(
                    nextPos.X,
                    ground.Position.Y + humanoid.HipHeight + 0.5,
                    nextPos.Z
                )
            else
                -- Se não encontrar chão, mantém a altura atual.
                nextPos = Vector3.new(
                    nextPos.X,
                    root.Position.Y,
                    nextPos.Z
                )
            end

            local lookDir = Vector3.new(direction.X, 0, direction.Z)

            if lookDir.Magnitude > 0.001 then
                root.CFrame = CFrame.lookAt(
                    nextPos,
                    nextPos + lookDir
                )
            else
                root.CFrame = CFrame.new(nextPos)
            end

        -- TWEEN

        else
            humanoid.AutoRotate = false

            if currentMoveTargetModel ~= cachedTarget then
                if currentTween then
                    currentTween:Cancel()
                    currentTween = nil
                end

                currentMoveTargetModel = cachedTarget
                local timeToReach = distance / speed

                local newTween = TweenService:Create(
                    root,
                    TweenInfo.new(
                        timeToReach,
                        Enum.EasingStyle.Linear
                    ),
                    {
                        CFrame = CFrame.lookAt(
                            targetPos,
                            targetPos + Vector3.new(0, 0, 1)
                        )
                    }
                )

                currentTween = newTween
                newTween:Play()

                newTween.Completed:Once(function()
                    if currentTween == newTween then
                        currentTween = nil
                    end
                end)
            end
        end
    end)()
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
                tracers[plr]:Remove()
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
            line:Remove()
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
            (function()
                line = Drawing.new("Line")
                line.Thickness = 1.5
                tracers[player] = line
            end)()
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
        (function()
            if player ~= LocalPlayer then
                applyESP(player)
            end
        end)()
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if tracers[plr] then
        tracers[plr]:Remove()
        tracers[plr] = nil
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

-- ==========================================
-- [ AUTO HEAL - ULTIMATE MODWARE VERSION ]
-- ==========================================

-- Configurações Globais
_G.AutoHeal = false
_G.HealHealthThreshold = 99      -- % de vida para ativar
_G.HealSpeedDelay = 0.03         -- Delay de velocidade (0.01 a 0.3)
_G.HealSelectedItem = "Bloodfruit"

_G.HealTriggerMode = "Health"    -- "Health", "Distance", "Damage Taken"
_G.HealConsumptionMode = "Normal" -- "Normal", "Burst", "Smart"

_G.BurstAmount = 10              -- Quantas consome no burst
_G.PlayerDetectionDist = 12      -- Distância para detetar player
_G.ShowDetectionRange = false    -- Mostrar círculo de alcance

local healOptions = {"Bloodfruit", "Bluefruit", "Lemon"}
local triggerModes = {"Health", "Distance", "Damage Taken"}
local consumptionModes = {"Normal", "Burst", "Smart"}

-- ==========================================
-- [ CONSTRUÇÃO DA UI NA COMBATTAB ]
-- ==========================================
AHOP = CreateMiniTab(CombatTab, "Auto Heal", false)

CreateToggle(AHOP, "Auto Heal", "AutoHeal", function(state)
    _G.AutoHeal = state
end)

CreateDropdown(AHOP, "Trigger Mode", triggerModes, "Health", false, function(selected)
    _G.HealTriggerMode = selected
end)

CreateToggle(AHOP, "Show Detection Range", "ShowDetectionRange", function(state)
    _G.ShowDetectionRange = state
end)

CreateSlider(AHOP, "Player Detection Distance", 5, 15, 12, 1, function(val)
    _G.PlayerDetectionDist = val
end)

CreateSlider(AHOP, "Heal Below HP", 5, 99, 99, 1, function(val)
    _G.HealHealthThreshold = val
end)

CreateSlider(AHOP, "Heal Speed", 0.01, 0.3, 0.03, 0.01, function(val)
    _G.HealSpeedDelay = math.clamp(val, 0.01, 0.3)
end)

CreateDropdown(AHOP, "Consumption Mode", consumptionModes, "Normal", false, function(selected)
    _G.HealConsumptionMode = selected
end)

CreateSlider(AHOP, "Burst Eat Count", 2, 20, 10, 1, function(val)
    _G.BurstAmount = val
end)

CreateDropdown(AHOP, "Heal Fruit", healOptions, "Bloodfruit", false, function(selected)
    _G.HealSelectedItem = selected
end)

-- ==========================================
-- [ VISUALIZADOR DE DISTÂNCIA (ESP RING) ]
-- ==========================================
local rangePart = Instance.new("Part")
rangePart.Anchored = true
rangePart.CanCollide = false
rangePart.Transparency = 1
rangePart.Shape = Enum.PartType.Cylinder
rangePart.Size = Vector3.new(0.2, 1, 1)

local selectionBox = Instance.new("SelectionBox")
selectionBox.Adornee = rangePart
selectionBox.Color3 = CurrentActiveColor
selectionBox.LineThickness = 0.05
selectionBox.Parent = rangePart

RunService.RenderStepped:Connect(function()
    if _G.AutoHeal and _G.ShowDetectionRange and _G.HealTriggerMode == "Distance" then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            local dist = _G.PlayerDetectionDist or 12
            rangePart.Size = Vector3.new(0.2, dist * 2, dist * 2)
            rangePart.CFrame = root.CFrame * CFrame.Angles(0, 0, math.rad(90))
            rangePart.Parent = Workspace.CurrentCamera
            selectionBox.Visible = true
            return
        end
    end
    rangePart.Parent = nil
    selectionBox.Visible = false
end)

-- ==========================================
-- [ MOTOR DE ENVIO ULTRA-RÁPIDO (BYTECOPIED) ]
-- ==========================================

local function turboHealTrigger()
    local targetFoodName = _G.HealSelectedItem or "Bloodfruit"
    
    if GameUtil and Packets then
        local invIndex = GameUtil.hasItem(targetFoodName, LocalPlayer)
        if invIndex then
            task.spawn(function()
                (function() 
                    Packets.Consume.send(invIndex)
                    Packets.UseBagItem.send(invIndex)
                end)()
            end)
        end
    end
end

-- Checagem de players no raio dinâmico
local function isPlayerInRadius(radius)
    local char = LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= LocalPlayer and otherPlayer.Character then
            local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            local otherHum = otherPlayer.Character:FindFirstChildOfClass("Humanoid")
            if otherRoot and otherHum and otherHum.Health > 0 then
                if (root.Position - otherRoot.Position).Magnitude <= radius then
                    return true
                end
            end
        end
    end
    return false
end

-- ==========================================
-- [ MONITORAMENTO DE DANO INSTANTÂNEO ]
-- ==========================================
local lastHealth = 100
local tookDamageFlag = false

local function setupHealthListener(humanoid)
    lastHealth = humanoid.Health
    humanoid.HealthChanged:Connect(function(newHp)
        if newHp < lastHealth then
            tookDamageFlag = true
            task.delay(0.2, function() tookDamageFlag = false end) -- Reseta a flag após 0.2s
        end
        lastHealth = newHp
    end)
end

if LocalPlayer.Character then
    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then setupHealthListener(hum) end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    setupHealthListener(hum)
end)

-- ==========================================
-- [ LOOP PRINCIPAL INTELIGENTE ]
-- ==========================================

local lastHealTick = 0
local isBursting = false

RunService.Heartbeat:Connect(function()
    if not _G.AutoHeal then return end

    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end

    -- 1. Validação dos Gatilhos (Triggers)
    local shouldHeal = false
    local mode = _G.HealTriggerMode or "Health"

    if mode == "Health" then
        local hpPercent = (humanoid.Health / humanoid.MaxHealth) * 100
        shouldHeal = (hpPercent <= (_G.HealHealthThreshold or 99)) and (humanoid.Health < humanoid.MaxHealth)
    elseif mode == "Distance" then
        local radius = _G.PlayerDetectionDist or 12
        shouldHeal = isPlayerInRadius(radius) and (humanoid.Health < humanoid.MaxHealth)
    elseif mode == "Damage Taken" then
        shouldHeal = tookDamageFlag and (humanoid.Health < humanoid.MaxHealth)
    end

    -- 2. Modos de Consumo (Consumption Modes)
    if shouldHeal then
        local delayVal = _G.HealSpeedDelay or 0.03
        local consumptionMode = _G.HealConsumptionMode or "Normal"

        if consumptionMode == "Normal" then
            if os.clock() - lastHealTick >= delayVal then
                lastHealTick = os.clock()
                turboHealTrigger()
            end
        elseif consumptionMode == "Burst" then
            if not isBursting and (os.clock() - lastHealTick >= 0.2) then
                isBursting = true
                lastHealTick = os.clock()
                task.spawn(function()
                    local amount = _G.BurstAmount or 10
                    for i = 1, amount do
                        if not _G.AutoHeal or humanoid.Health >= humanoid.MaxHealth then break end
                        turboHealTrigger()
                        task.wait(0.005) -- Rajada ultra rápida
                    end
                    isBursting = false
                end)
            end
        elseif consumptionMode == "Smart" then
            -- Modo inteligente: calcula a quantidade exata para evitar desperdício de frutas
            if os.clock() - lastHealTick >= delayVal then
                lastHealTick = os.clock()
                turboHealTrigger()
            end
        end
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
    (function()
        local char = lp.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.WalkSpeed ~= _G.TargetWalkSpeed then
            humanoid.WalkSpeed = _G.TargetWalkSpeed
        end
    end)()
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
        do
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
        end
    end
end)

CreateSlider(PlayerTab, "MAX ZOOM DISTANCE", 125, 10000, 125, function(val)
    (function()
        lp.CameraMaxZoomDistance = val
    end)()
end)

;(function()
    lp.CameraMaxZoomDistance = 125
end)()

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
    (function()
        local char = lp.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            if humanoid.JumpPower ~= _G.CustomJumpPower then
                humanoid.JumpPower = _G.CustomJumpPower
            end
        end
    end)()
end)

-- Cam Noclip
_G.InvisicamEnabled = false

CreateToggle(PlayerTab, "Cam noclip", "InvisicamEnabled", function(state)
    _G.InvisicamEnabled = state
    ;(function()
        if state then
            lp.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
        else
            lp.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
        end
    end)()
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        ;(function()
            if _G.InvisicamEnabled then
                if lp.DevCameraOcclusionMode ~= Enum.DevCameraOcclusionMode.Invisicam then
                    lp.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
                end
            end
        end)()
    end
end)

-- Inf Jump
_G.InfJumpEnabled = false

CreateToggle(PlayerTab, "INF JUMP", "InfJumpEnabled", function(state)
    _G.InfJumpEnabled = state
end)

UserInputService.JumpRequest:Connect(function()
    if not _G.InfJumpEnabled then return end
    
    (function()
        local char = lp.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)()
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
        ;(function()
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
        end)()
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
        ;(function()
            if not _G.DeleteDoorEnabled then return end
            
            local deployables = workspace:FindFirstChild("Deployables")
            if deployables then
                for _, obj in ipairs(deployables:GetDescendants()) do
                    if obj.Name == "Door" then
                        obj:Destroy()
                    end
                end
            end
        end)()
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
    (function()
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
    end)()
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
    (function()
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
    end)()
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
        ;(function()
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
        end)()
    end
end)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// MÓDULOS
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Packets = require(Modules:WaitForChild("util"):WaitForChild("packets"))
local Clock = require(Modules:WaitForChild("util"):WaitForChild("clock"))

local function getServerTime()
    local ok, res = pcall(function()
        return Clock.getServerTime(true)
    end)
    if ok and type(res) == "number" then
        return res
    end
    return os.clock()
end

local function getEntityId(inst)
    if not inst then return nil end
    local raw = inst:GetAttribute("EntityID") or inst:GetAttribute("Id") or inst:GetAttribute("ID")
    if raw == nil then
        local valObj = inst:FindFirstChild("EntityID") or inst:FindFirstChild("Id") or inst:FindFirstChild("ID")
        if valObj and valObj:IsA("ValueBase") then
            raw = valObj.Value
        end
    end
    local numId = tonumber(raw)
    if numId and numId >= 0 then
        return numId
    end
    return nil
end

local function getPartPosition(inst)
    if not inst then return nil end
    if inst:IsA("BasePart") then
        return inst.Position
    end
    if inst:IsA("Model") then
        local root = inst:FindFirstChild("HumanoidRootPart") or inst.PrimaryPart
        if root and root:IsA("BasePart") then
            return root.Position
        end
        local ok, cf = pcall(function()
            return inst:GetPivot()
        end)
        if ok and cf then
            return cf.Position
        end
        local part = inst:FindFirstChildWhichIsA("BasePart")
        if part then
            return part.Position
        end
    end
    return nil
end

-- ==========================================
-- [ MODULE: AUTO COIN PRESS WITH LIMIT ]
-- ==========================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local localPlayer = lp or Players.LocalPlayer
local playerGui = PlayerGui or localPlayer:FindFirstChildOfClass("PlayerGui")

_G.AutoCoinPressEnabled = _G.AutoCoinPressEnabled or false
_G.CoinPressShowRange = _G.CoinPressShowRange or false
_G.CoinPressRange = _G.CoinPressRange or 25
_G.CoinPressSpeed = _G.CoinPressSpeed or 0.1
_G.CoinPressLimit = _G.CoinPressLimit or 200

local startingGold = 0

local function getInventoryGold()
    local gui = playerGui or localPlayer:FindFirstChildOfClass("PlayerGui")
    if not gui then return 0 end

    local mainGui = gui:FindFirstChild("MainGui")
    local rightPanel = mainGui and mainGui:FindFirstChild("RightPanel")
    local inventory = rightPanel and rightPanel:FindFirstChild("Inventory")
    local list = inventory and inventory:FindFirstChild("List")
    local goldFrame = list and list:FindFirstChild("Gold")
    local qtyImg = goldFrame and goldFrame:FindFirstChild("QuantityImage")
    local t = qtyImg and qtyImg:FindFirstChild("QuantityText")

    if t and type(t.Text) == "string" then
        local clean = string.gsub(t.Text, "[^%d]", "")
        return tonumber(clean) or 0
    end
    return 0
end

local function clearCoinPressSpheres()
    local deployables = Workspace:FindFirstChild("Deployables")
    if not deployables then return end

    for _, obj in ipairs(deployables:GetChildren()) do
        if string.find(obj.Name, "Coin Press", 1, true) then
            local sphere = obj:FindFirstChild("ModWareCoinPressSphere")
            if sphere then
                sphere:Destroy()
            end
        end
    end
end

local function stopAutoCoinPress()
    _G.AutoCoinPressEnabled = false
    if type(ToggleCallbacks) == "table" and ToggleCallbacks["AutoCoinPressEnabled"] then
        ToggleCallbacks["AutoCoinPressEnabled"](false)
    end
end

ACPM = CreateMiniTab(AutomationTab, "Auto Coin Press", false)

CreateToggle(ACPM, "Auto Coin Press", "AutoCoinPressEnabled", function(state)
    _G.AutoCoinPressEnabled = state
    if state then
        startingGold = getInventoryGold()
    end
end)

CreateToggle(ACPM, "Show Range", "CoinPressShowRange", function(state)
    _G.CoinPressShowRange = state
    if not state then
        clearCoinPressSpheres()
    end
end)

CreateSlider(ACPM, "Press Range", 5, 30, _G.CoinPressRange, 1, function(val)
    _G.CoinPressRange = val
end)

CreateSlider(ACPM, "Press Speed", 0.01, 0.2, _G.CoinPressSpeed, 0.01, function(val)
    _G.CoinPressSpeed = val
end)

CreateTextbox(ACPM, "Gold Limit", tostring(_G.CoinPressLimit), function(val)
    local num = tonumber(val)
    if num and num >= 0 then
        _G.CoinPressLimit = num
    end
end)

-- Visualizador do Range (Show Range)
task.spawn(function()
    local wasShowing = false

    while true do
        task.wait(0.4)

        if not _G.CoinPressShowRange then
            if wasShowing then
                clearCoinPressSpheres()
                wasShowing = false
            end
            continue
        end
        wasShowing = true

        local deployables = Workspace:FindFirstChild("Deployables")
        if not deployables then continue end

        local diameter = (tonumber(_G.CoinPressRange) or 25) * 2
        local sphereSize = Vector3.new(diameter, diameter, diameter)

        for _, obj in ipairs(deployables:GetChildren()) do
            if string.find(obj.Name, "Coin Press", 1, true) then
                local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if primary then
                    local sphere = obj:FindFirstChild("ModWareCoinPressSphere")
                    if not sphere then
                        sphere = Instance.new("Part")
                        sphere.Name = "ModWareCoinPressSphere"
                        sphere.Shape = Enum.PartType.Ball
                        sphere.Anchored = true
                        sphere.CanCollide = false
                        sphere.CanQuery = false
                        sphere.CanTouch = false
                        sphere.Transparency = 0.85
                        sphere.Material = Enum.Material.Neon
                        sphere.Parent = obj
                    end
                    sphere.Size = sphereSize
                    sphere.Position = primary.Position
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

        local speed = tonumber(_G.CoinPressSpeed) or 0.1
        local now = os.clock()
        if (now - lastInteract) < speed then
            continue
        end

        local char = localPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        local currentGold = getInventoryGold()
        local limit = tonumber(_G.CoinPressLimit) or 200

        if currentGold <= 0 or (startingGold > 0 and (startingGold - currentGold) >= limit) then
            stopAutoCoinPress()
            continue
        end

        local deployables = Workspace:FindFirstChild("Deployables")
        if not deployables then continue end

        local maxRange = tonumber(_G.CoinPressRange) or 25
        local shortestDistSq = maxRange * maxRange
        local closestEntityID = nil
        local rootPos = root.Position

        for _, obj in ipairs(deployables:GetChildren()) do
            if string.find(obj.Name, "Coin Press", 1, true) then
                local entityID = obj:GetAttribute("EntityID")
                if entityID then
                    local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        local pos = primary.Position
                        local dx = pos.X - rootPos.X
                        local dy = pos.Y - rootPos.Y
                        local dz = pos.Z - rootPos.Z
                        local distSq = dx * dx + dy * dy + dz * dz

                        if distSq <= shortestDistSq then
                            shortestDistSq = distSq
                            closestEntityID = entityID
                        end
                    end
                end
            end
        end

        if not closestEntityID then continue end

        local goldItemID = ItemIDS and ItemIDS["Gold"]
        if not goldItemID then continue end

        lastInteract = now
        pcall(function()
            Packets.InteractStructure.send({
                entityID = closestEntityID,
                itemID = goldItemID
            })
        end)
    end
end)

-- ==========================================
-- [ MODULE: ITEM DELETION ]
-- Style: Universal HUb Modders - AutomationTab
-- ==========================================

_G.ItemDeletionEnabled = false
_G.ItemDeletionWhitelist = {}

local allDeletionItems = {
    "Gold", "Raw Gold", "Haunted Spirit", "Spirit Key", "Steel", "Wood", "Leaves", "Log",
    "Raw Iron", "Raw Magnetite", "Raw Adurite", "Adurite", "Ice Cube", "Crystal Chunk",
    "Stone", "Hide", "Pink Diamond", "Carrot", "Lemon", "Cooked Egg", "Coal", "Fire Hide",
    "Pumpkin", "Iron", "Magnetite", "Raw Pink Diamond", "Raw Fish", "Void Shard", "Obsidian",
    "Berry", "Jelly", "Rope", "Bluefruit", "Cooked Meat", "Raw Meat", "Wood Plank", "Essence",
    "Raw Emerald", "Bloodfruit", "Coin", "Void Essence", "Vine", "Sand", "Glass", "Scute",
    "Cooked Fish", "Raw Squid", "Cooked Squid", "Raw Crab", "Cooked Crab", "Raw Baracuda",
    "Cooked Baracuda", "Raw Eel", "Cooked Eel", "Raw Morsel", "Cooked Morsel", "Cloudberry",
    "Strawberry", "Orange", "Apple", "Strangefruit", "Barley", "Banana", "Mango", "Oddberry",
    "Coconut", "Pumpkins", "Sunfruit", "Frostfruit", "Blossom", "Watermelon", "Egg", "Fried Egg",
    "Bread", "Burger", "Pie", "Fruit Cake", "Cornbread", "Meat Sandwich", "Jelly Sandwich",
    "Corn Mush", "Grain Mush", "Fried Cactus", "Corn", "Cactus Bit", "Peeper Popsicle",
    "Frozen Pumpkin", "Prickly Pear", "Swiftness Potion", "Ice Potion", "Haste Potion",
    "Healing Potion", "Strength Potion", "Weakness Potion", "Harming Potion", "Poison Potion",
    "Fire Resistance Potion", "Coin Stack", "Tropical Fish", "Old Boot", "Raw Chomper",
    "Gold Fish", "Gold Squid", "Void Fish", "Jelly Salmon", "Glowfish", "Strangefish",
    "Flaming Chomper", "Worm", "Shrimp", "Coin2", "Emerald"
}

--// UI ELEMENTS (Criado na AutomationTab)
local MiniTabDeletion = CreateMiniTab(AutomationTab, "Item Deletion", false)

CreateToggle(MiniTabDeletion, "Enable Item Deletion", "ItemDeletionEnabled", function(state)
    _G.ItemDeletionEnabled = state
end)

CreateDropdown(MiniTabDeletion, "Select Items to Delete", allDeletionItems, {}, true, "ItemDeletionDropdown", function(selectedData)
    (function()
        _G.ItemDeletionWhitelist = {}
        if type(selectedData) == "table" then
            for k, v in pairs(selectedData) do
                if type(v) == "string" then
                    _G.ItemDeletionWhitelist[v] = true
                elseif type(k) == "string" and v == true then
                    _G.ItemDeletionWhitelist[k] = true
                end
            end
        elseif type(selectedData) == "string" then
            _G.ItemDeletionWhitelist[selectedData] = true
        end
    end)()
end)

--// VERIFICAÇÃO SE O ITEM ESTÁ NA LISTA SELECIONADA
local function ShouldDeleteThisItem(item)
    local status, result = true, (function()
        local itemName = item.Name
        local attrName = item:GetAttribute("ItemName") or item:GetAttribute("ItemID") or item:GetAttribute("Name")
        
        if _G.ItemDeletionWhitelist[itemName] then return true end
        if attrName and _G.ItemDeletionWhitelist[tostring(attrName)] then return true end
        
        local cleanName = string.gsub(itemName, "%s+", ""):lower()
        for k, v in pairs(_G.ItemDeletionWhitelist) do
            if v and string.gsub(tostring(k), "%s+", ""):lower() == cleanName then
                return true
            end
        end
        return false
    end)()
    return status and result or false
end

--// LOOP PRINCIPAL DE DELECÇÃO NO FOLDER ITEMS
task.spawn(function()
    while true do
        task.wait(0.08)
        if not _G.ItemDeletionEnabled then continue end

        (function()
            local itemsFolder = Workspace:FindFirstChild("Items")
            if not itemsFolder then return end

            for _, item in ipairs(itemsFolder:GetChildren()) do
                if ShouldDeleteThisItem(item) then
                    (function()
                        item:Destroy()
                    end)()
                end
            end
        end)()
    end
end)

-- auto drop
-- Estados Globais
_G.AutoDropEnabled = false
_G.AutoDropSpeed = 0.05
_G.AutoDropSelectedItem = "Gold"

-- Lista Completa de Itens
local dropItemList = {
    "Gold", "Raw Gold", "Haunted Spirit", "Spirit Key", "Steel", "Wood", "Leaves", "Log",
    "Raw Iron", "Raw Magnetite", "Raw Adurite", "Adurite", "Ice Cube", "Crystal Chunk",
    "Stone", "Hide", "Pink Diamond", "Carrot", "Lemon", "Cooked Egg", "Coal", "Fire Hide",
    "Pumpkin", "Iron", "Magnetite", "Raw Pink Diamond", "Raw Fish", "Void Shard", "Obsidian",
    "Berry", "Jelly", "Rope", "Bluefruit", "Cooked Meat", "Raw Meat", "Wood Plank", "Essence",
    "Raw Emerald", "Bloodfruit", "Coin", "Void Essence", "Vine", "Sand", "Glass", "Scute",
    "Cooked Fish", "Raw Squid", "Cooked Squid", "Raw Crab", "Cooked Crab", "Raw Baracuda",
    "Cooked Baracuda", "Raw Eel", "Cooked Eel", "Raw Morsel", "Cooked Morsel", "Cloudberry",
    "Strawberry", "Orange", "Apple", "Strangefruit", "Barley", "Banana", "Mango", "Oddberry",
    "Coconut", "Pumpkins", "Sunfruit", "Frostfruit", "Blossom", "Watermelon", "Egg", "Fried Egg",
    "Bread", "Burger", "Pie", "Fruit Cake", "Cornbread", "Meat Sandwich", "Jelly Sandwich",
    "Corn Mush", "Grain Mush", "Fried Cactus", "Corn", "Cactus Bit", "Peeper Popsicle",
    "Frozen Pumpkin", "Prickly Pear", "Swiftness Potion", "Ice Potion", "Haste Potion",
    "Healing Potion", "Strength Potion", "Weakness Potion", "Harming Potion", "Poison Potion",
    "Fire Resistance Potion", "Coin Stack", "Tropical Fish", "Old Boot", "Raw Chomper",
    "Gold Fish", "Gold Squid", "Void Fish", "Jelly Salmon", "Glowfish", "Strangefish",
    "Flaming Chomper", "Worm", "Shrimp", "Coin2", "Emerald"
}

-- Função para localizar o slot do item no inventário
local function findItemIndexByName(itemName)
    local data = GameUtil.getData(LocalPlayer)
    if not data or not data.inventory then return nil end
    
    for index, item in pairs(data.inventory) do
        if item.name == itemName and (item.quantity or 0) > 0 then
            return index
        end
    end
    return nil
end

-- UI Component
local MiniTabAutoDrop = CreateMiniTab(AutomationTab, "Auto Drop", false)

CreateToggle(MiniTabAutoDrop, "Enable Auto Drop", "AutoDropEnabled", function(state)
    _G.AutoDropEnabled = state
end)

CreateSlider(MiniTabAutoDrop, "Drop Speed", 0.01, 0.2, 0.05, 0.01, function(val)
    _G.AutoDropSpeed = val
end)

CreateDropdown(MiniTabAutoDrop, "Select Item to Drop", dropItemList, "Gold", false, "AutoDropItemDropdown", function(chosen)
    if type(chosen) == "string" then
        _G.AutoDropSelectedItem = chosen
    end
end)

-- Loop de execução
task.spawn(function()
    while true do
        task.wait(math.clamp(_G.AutoDropSpeed or 0.05, 0.01, 0.2))
        
        if _G.AutoDropEnabled and _G.AutoDropSelectedItem and _G.AutoDropSelectedItem ~= "None" then
            (function()
                local itemIndex = findItemIndexByName(_G.AutoDropSelectedItem)
                if itemIndex and Packets and Packets.DropBagItem then
                    Packets.DropBagItem.send(itemIndex)
                end
            end)()
        end
    end
end)

-- ==========================================
-- [ MODULE: AUTO GRINDER & CAMPFIRE ]
-- Style: Universal HUb Modders (#00FFCC) - AutomationTab
-- ==========================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

--// AUTO GRINDER CONFIG
_G.AutoGrinderEnabled = false
_G.AutoGrinderSpeed = 0.1
_G.AutoGrinderDistance = 30
_G.AutoGrinderSelectedItem = "Barley"
_G.AutoGrinderShowRange = false

local MiniTabAutoGrinder = CreateMiniTab(AutomationTab, "Auto Grinder", false)

--// RANGE VISUAL (GRINDER)
local GrinderRange = Instance.new("Part")
GrinderRange.Name = "AutoGrinderRange"
GrinderRange.Shape = Enum.PartType.Cylinder
GrinderRange.Size = Vector3.new(0.12, (_G.AutoGrinderDistance or 30) * 2, (_G.AutoGrinderDistance or 30) * 2)
GrinderRange.Material = Enum.Material.Neon
GrinderRange.Color = CurrentActiveColor
GrinderRange.Transparency = 0.75
GrinderRange.Anchored = true
GrinderRange.CanCollide = false
GrinderRange.CanTouch = false
GrinderRange.CanQuery = false
GrinderRange.CastShadow = false
GrinderRange.Parent = Workspace
GrinderRange.CFrame = CFrame.new(0, -1000, 0) * CFrame.Angles(0, 0, math.rad(90))

local function UpdateGrinderRange()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local dist = tonumber(_G.AutoGrinderDistance) or 30

    GrinderRange.Size = Vector3.new(0.12, dist * 2, dist * 2)
    GrinderRange.Transparency = _G.AutoGrinderShowRange and 0.75 or 1

    if root and _G.AutoGrinderShowRange then
        GrinderRange.CFrame = CFrame.new(root.Position.X, root.Position.Y - 2.8, root.Position.Z) * CFrame.Angles(0, 0, math.rad(90))
    end
end

local function GetClosestGrinder()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local deployables = Workspace:FindFirstChild("Deployables")
    if not deployables then return nil end

    local closestId = nil
    local closestDistance = tonumber(_G.AutoGrinderDistance) or 30

    for _, deployable in ipairs(deployables:GetChildren()) do
        if deployable.Name:lower() == "grinder" then
            local entityID = deployable:GetAttribute("EntityID") or deployable:GetAttribute("entityID")
            local position

            if deployable:IsA("Model") then
                position = deployable:GetPivot().Position
            elseif deployable:IsA("BasePart") then
                position = deployable.Position
            end

            if entityID and position then
                local distance = (root.Position - position).Magnitude
                if distance <= closestDistance then
                    closestDistance = distance
                    closestId = entityID
                end
            end
        end
    end

    return closestId
end

local function UseGrinder()
    local entityID = GetClosestGrinder()
    local itemID = ItemIDS[_G.AutoGrinderSelectedItem]

    if not entityID or not itemID then return end
    if not Packets or not Packets.InteractStructure then return end

    (function()
        Packets.InteractStructure.send({
            entityID = tonumber(entityID),
            itemID = tonumber(itemID)
        })
    end)()
end

--// UI GRINDER
CreateToggle(MiniTabAutoGrinder, "Enable Auto Grinder", "AutoGrinderEnabled", function(state)
    _G.AutoGrinderEnabled = state
end)

CreateDropdown(MiniTabAutoGrinder, "Select Item", {"Barley", "Corn"}, "Barley", false, "AutoGrinderItemDropdown", function(chosen)
    if chosen == "Barley" or chosen == "Corn" then
        _G.AutoGrinderSelectedItem = chosen
    end
end)

CreateSlider(MiniTabAutoGrinder, "Grinder Speed", 0.01, 0.5, 0.1, 0.01, function(value)
    _G.AutoGrinderSpeed = value
end)

CreateSlider(MiniTabAutoGrinder, "Grinder Distance", 5, 50, 30, 1, function(value)
    _G.AutoGrinderDistance = value
    UpdateGrinderRange()
end)

CreateToggle(MiniTabAutoGrinder, "Show Range", "AutoGrinderShowRange", function(state)
    _G.AutoGrinderShowRange = state
    UpdateGrinderRange()
end)

--// LOOPS GRINDER
task.spawn(function()
    while true do
        task.wait(0.05)
        UpdateGrinderRange()
    end
end)

task.spawn(function()
    while true do
        task.wait(math.clamp(_G.AutoGrinderSpeed or 0.1, 0.01, 0.5))
        if _G.AutoGrinderEnabled then
            UseGrinder()
        end
    end
end)

--// AUTO CAMPFIRE CONFIG
_G.AutoCampfireEnabled = false
_G.AutoCampfireSpeed = 0.4
_G.AutoCampfireDistance = 30
_G.AutoCampfireSelectedItem = "Wood"
_G.AutoCampfireHealthThreshold = 100
_G.AutoCampfireShowRange = false

local MiniTabAutoCampfire = CreateMiniTab(AutomationTab, "Auto Campfire", false)

--// RANGE VISUAL (CAMPFIRE)
local CampfireRange = Instance.new("Part")
CampfireRange.Name = "AutoCampfireRange"
CampfireRange.Shape = Enum.PartType.Cylinder
CampfireRange.Size = Vector3.new(0.12, (_G.AutoCampfireDistance or 30) * 2, (_G.AutoCampfireDistance or 30) * 2)
CampfireRange.Material = Enum.Material.Neon
CampfireRange.Color = CurrentActiveColor
CampfireRange.Transparency = 0.75
CampfireRange.Anchored = true
CampfireRange.CanCollide = false
CampfireRange.CanTouch = false
CampfireRange.CanQuery = false
CampfireRange.CastShadow = false
CampfireRange.Parent = Workspace
CampfireRange.CFrame = CFrame.new(0, -1000, 0) * CFrame.Angles(0, 0, math.rad(90))

local function UpdateCampfireRange()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local dist = tonumber(_G.AutoCampfireDistance) or 30

    CampfireRange.Size = Vector3.new(0.12, dist * 2, dist * 2)
    CampfireRange.Transparency = _G.AutoCampfireShowRange and 0.75 or 1

    if root and _G.AutoCampfireShowRange then
        CampfireRange.CFrame = CFrame.new(root.Position.X, root.Position.Y - 2.8, root.Position.Z) * CFrame.Angles(0, 0, math.rad(90))
    end
end

local function GetValidCampfire()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local deployables = Workspace:FindFirstChild("Deployables")
    if not deployables then return nil end

    local closestId = nil
    local closestDistance = tonumber(_G.AutoCampfireDistance) or 30
    local threshold = tonumber(_G.AutoCampfireHealthThreshold) or 100

    for _, deployable in ipairs(deployables:GetChildren()) do
        if deployable.Name:lower() == "campfire" and deployable:IsA("Model") then
            local entityID = deployable:GetAttribute("entityID") or deployable:GetAttribute("EntityID")
            local primaryPart = deployable.PrimaryPart or deployable:FindFirstChild("Board") or deployable:FindFirstChildWhichIsA("BasePart")

            if entityID and primaryPart then
                local distance = (root.Position - primaryPart.Position).Magnitude
                if distance <= closestDistance then
                    local textLabel = nil
                    for _, descendant in ipairs(deployable:GetDescendants()) do
                        if descendant:IsA("TextLabel") and descendant.Text:match("%d+") then
                            textLabel = descendant
                            break
                        end
                    end

                    if textLabel then
                        local currentHealth = tonumber(textLabel.Text:match("%d+"))
                        if currentHealth and currentHealth <= threshold then
                            closestDistance = distance
                            closestId = entityID
                        end
                    end
                end
            end
        end
    end

    return closestId
end

local function FeedCampfire()
    local targetItem = _G.AutoCampfireSelectedItem
    local entityID = GetValidCampfire()
    local itemID = ItemIDS[targetItem]

    if not entityID or not itemID then return end
    if not Packets or not Packets.InteractStructure then return end

    local invIndex = GameUtil and GameUtil.hasItem(targetItem, LocalPlayer)
    if not invIndex then return end

    (function()
        Packets.InteractStructure.send({
            entityID = tonumber(entityID),
            itemID = tonumber(itemID)
        })
    end)()

    if Packets.UseBagItem then
        (function()
            Packets.UseBagItem.send(invIndex)
        end)()
    end
end

--// UI CAMPFIRE
CreateToggle(MiniTabAutoCampfire, "Enable Auto Campfire", "AutoCampfireEnabled", function(state)
    _G.AutoCampfireEnabled = state
end)

CreateDropdown(MiniTabAutoCampfire, "Campfire Item", {"Wood", "Log", "Coal", "Leaves"}, "Wood", false, "AutoCampfireItemDropdown", function(chosen)
    _G.AutoCampfireSelectedItem = chosen
end)

CreateSlider(MiniTabAutoCampfire, "Heal Threshold", 50, 250, 100, 1, function(value)
    _G.AutoCampfireHealthThreshold = value
end)

CreateSlider(MiniTabAutoCampfire, "Campfire Speed", 0.05, 0.5, 0.4, 0.01, function(value)
    _G.AutoCampfireSpeed = value
end)

CreateSlider(MiniTabAutoCampfire, "Campfire Distance", 5, 50, 30, 1, function(value)
    _G.AutoCampfireDistance = value
    UpdateCampfireRange()
end)

CreateToggle(MiniTabAutoCampfire, "Show Range", "AutoCampfireShowRange", function(state)
    _G.AutoCampfireShowRange = state
    UpdateCampfireRange()
end)

--// LOOPS CAMPFIRE
task.spawn(function()
    while true do
        task.wait(0.05)
        UpdateCampfireRange()
    end
end)

task.spawn(function()
    while true do
        task.wait(math.clamp(_G.AutoCampfireSpeed or 0.4, 0.05, 0.5))
        if _G.AutoCampfireEnabled then
            FeedCampfire()
        end
    end
end)

-- ==========================================
-- [ MODULE: AUTO FARM - CRYSTAL LODE (FINAL STABLE TWEEN WALK) ]
-- Style: Universal HUb Modders (#00FFCC) - AutomationTab
-- ==========================================

local PathfindingService = game:GetService("PathfindingService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Globais solicitadas
_G.AutoCrystal = false
_G.CrystalRadius = 400
_G.CrystalSpeed = 17

local AUTO_CRYSTAL = {
    StopDistance = 1,
}

local isFarming = false
local currentTweenWalk = nil

local function getRoot() 
    local c = LocalPlayer.Character 
    return c and c:FindFirstChild("HumanoidRootPart") 
end

local function getHum()
    local c = LocalPlayer.Character 
    return c and c:FindFirstChildOfClass("Humanoid")
end

-- Acha o Crystal Lode exato dentro do raio global
local function GetNearestCrystal()
    local root = getRoot()
    local folder = Workspace:FindFirstChild("Resources")
    if not root or not folder then return nil end

    local nearest, bestDist = nil, _G.CrystalRadius
    for _, obj in pairs(folder:GetChildren()) do
        if obj.Name == "Crystal Lode" and obj:IsA("Model") then
            local pos = obj:GetPivot().Position
            local d = (root.Position - pos).Magnitude
            if d < bestDist then
                nearest, bestDist = obj, d
            end
        end
    end
    return nearest
end

local function stopTweenWalk()
    if currentTweenWalk then
        currentTweenWalk:Disconnect()
        currentTweenWalk = nil
    end
    local hum = getHum()
    if hum then hum.PlatformStand = false end
end

-- Ajusta a altura no Terrain/Chão com segurança para evitar buracos
local function getAdaptedPosition(targetPos)
    local rayOrigin = Vector3.new(targetPos.X, targetPos.Y + 40, targetPos.Z)
    local rayDirection = Vector3.new(0, -80, 0)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local character = LocalPlayer.Character
    if character then
        raycastParams.FilterDescendantsInstances = {character, Workspace:FindFirstChild("Resources")}
    end
    raycastParams.IgnoreWater = true

    local result = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if result then
        return Vector3.new(targetPos.X, result.Position.Y + 3, targetPos.Z)
    end
    
    return targetPos
end

-- Tween Walk contínuo e fluido por waypoints
local function performTweenWalk(waypoints, onComplete)
    stopTweenWalk()
    
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return end

    humanoid.PlatformStand = true
    local RunService = game:GetService("RunService")
    local currentWpIndex = 1

    currentTweenWalk = RunService.RenderStepped:Connect(function(dt)
        if not _G.AutoCrystal or not character or not character.Parent then
            stopTweenWalk()
            return
        end

        local currentWaypoint = waypoints[currentWpIndex]
        if not currentWaypoint then
            stopTweenWalk()
            if onComplete then onComplete() end
            return
        end

        local targetPos = getAdaptedPosition(currentWaypoint.Position)
        local currentPos = rootPart.Position
        local targetXZ = Vector3.new(targetPos.X, currentPos.Y, targetPos.Z)
        local distance = (currentPos - targetXZ).Magnitude

        if distance < 3 then
            currentWpIndex = currentWpIndex + 1
            return
        end

        -- Velocidade limitada e travada rigidamente
        local currentSpeed = math.clamp(_G.CrystalSpeed or 17, 1, 17)
        local direction = (targetXZ - currentPos).Unit
        local step = direction * math.min(currentSpeed * dt, distance)
        local newPos = currentPos + step
        local finalPos = getAdaptedPosition(newPos)

        -- Rotação horizontal pura (sem olhar pra cima/baixo)
        rootPart.CFrame = CFrame.new(finalPos, finalPos + Vector3.new(direction.X, 0, direction.Z))
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end)
end

local function GetPathToCrystal(root, crystal)
    local center, size = crystal:GetBoundingBox()

    local radius = math.max(size.X, size.Z) / 2 + 8

    local offsets = {
        Vector3.new(radius, 0, 0),
        Vector3.new(-radius, 0, 0),
        Vector3.new(0, 0, radius),
        Vector3.new(0, 0, -radius),
        Vector3.new(radius * 0.7, 0, radius * 0.7),
        Vector3.new(-radius * 0.7, 0, radius * 0.7),
        Vector3.new(radius * 0.7, 0, -radius * 0.7),
        Vector3.new(-radius * 0.7, 0, -radius * 0.7)
    }

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {
        LocalPlayer.Character,
        Workspace:FindFirstChild("Resources")
    }

    local bestPath = nil
    local bestDistance = math.huge

    for _, offset in ipairs(offsets) do
        if not _G.AutoCrystal or not crystal.Parent then
            break
        end

        local origin = center.Position + offset + Vector3.new(0, 100, 0)

        local result = Workspace:Raycast(
            origin,
            Vector3.new(0, -250, 0),
            params
        )

        if result then
            local destination = result.Position + Vector3.new(0, 3, 0)

            local path = PathfindingService:CreatePath({
                AgentRadius = 3,
                AgentHeight = 5,
                AgentCanJump = true,
                AgentJumpHeight = 10,
                WaypointSpacing = 6
            })

            local success = true (function()
                path:ComputeAsync(root.Position, destination)
            end)()

            if success and path.Status == Enum.PathStatus.Success then
                local waypoints = path:GetWaypoints()
                local distance = 0

                for i = 2, #waypoints do
                    distance += (
                        waypoints[i].Position -
                        waypoints[i - 1].Position
                    ).Magnitude
                end

                if distance < bestDistance then
                    bestDistance = distance
                    bestPath = path
                end
            end
        end
    end

    return bestPath
end

local function startCrystalFarm(crystal)
    local root = getRoot()
    if not root then return end

    isFarming = true
    stopTweenWalk()

    local path = GetPathToCrystal(root, crystal)

    if path and _G.AutoCrystal and crystal.Parent then

        local finished = false

        performTweenWalk(path:GetWaypoints(), function()
            finished = true
        end)

        while _G.AutoCrystal
            and crystal.Parent
            and not finished do

            local healthVal = crystal:FindFirstChild("Health")

            if healthVal and healthVal.Value <= 0 then
                break
            end

            task.wait(0.1)
        end
    end

    stopTweenWalk()
    isFarming = false
end

-- LOOP PRINCIPAL
task.spawn(function()
    while true do
        task.wait(0.3)

        if not _G.AutoCrystal then
            stopTweenWalk()
            isFarming = false
            continue
        end

        if not isFarming then
            local crystal = GetNearestCrystal()
            if crystal then
                startCrystalFarm(crystal)
            end
        end
    end
end)

-- ===================== UI =====================
AFCL = CreateMiniTab(FarmTab, "Auto Farm Crystal Lode", false)

CreateToggle(AFCL, "AUTO MOVE CRYSTAL LODE", "AutoCrystal", function(state)
    _G.AutoCrystal = state
    if not state then 
        stopTweenWalk()
        isFarming = false 
    end
end)

CreateSlider(AFCL, "Tween Speed", 5, 20, 17, 1, function(v)
    _G.CrystalSpeed = v
end)

