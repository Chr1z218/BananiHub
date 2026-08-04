-- ==========================================================
-- 🍌 BANANIHUB v2.6 • INTERFACE REFRESH 🍌
-- Release status: Available
-- L = Open / Close
-- ==========================================================
-- Clean up an older copy before creating a new UI.
do
    local Environment = getgenv and getgenv() or _G
    local PreviousUnload = Environment.__BANANIHUB_UNLOAD
    if type(PreviousUnload) == "function" then
        pcall(PreviousUnload)
    end
    Environment.__BANANIHUB_UNLOAD = nil
end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlaceInfo = {
    Name =
        (game.Name and game.Name ~= "")
        and game.Name
        or "Unknown Experience",
    Creator = "Loading...",
    IconImageAssetId = 0
}
local BANANIHUB_VERSION = "2.7"
local UIToggleKey = Enum.KeyCode.L
--==============================================================
-- RAYFIELD
--==============================================================
local DEFAULT_GRAY_THEME = {
    TextColor = Color3.fromRGB(247, 247, 242),
    Background = Color3.fromRGB(29, 29, 31),
    Topbar = Color3.fromRGB(36, 36, 39),
    Shadow = Color3.fromRGB(12, 12, 14),
    NotificationBackground = Color3.fromRGB(34, 34, 37),
    NotificationActionsBackground = Color3.fromRGB(250, 204, 54),
    TabBackground = Color3.fromRGB(42, 42, 45),
    TabStroke = Color3.fromRGB(78, 70, 42),
    TabBackgroundSelected = Color3.fromRGB(250, 204, 54),
    TabTextColor = Color3.fromRGB(232, 232, 226),
    SelectedTabTextColor = Color3.fromRGB(35, 29, 8),
    ElementBackground = Color3.fromRGB(43, 43, 46),
    ElementBackgroundHover = Color3.fromRGB(62, 57, 37),
    SecondaryElementBackground = Color3.fromRGB(35, 35, 38),
    ElementStroke = Color3.fromRGB(126, 103, 34),
    SecondaryElementStroke = Color3.fromRGB(72, 65, 42),
    SliderBackground = Color3.fromRGB(78, 70, 39),
    SliderProgress = Color3.fromRGB(250, 204, 54),
    SliderStroke = Color3.fromRGB(255, 229, 133),
    ToggleBackground = Color3.fromRGB(43, 43, 46),
    ToggleEnabled = Color3.fromRGB(250, 204, 54),
    ToggleDisabled = Color3.fromRGB(99, 99, 104),
    ToggleEnabledStroke = Color3.fromRGB(255, 232, 143),
    ToggleDisabledStroke = Color3.fromRGB(126, 126, 132),
    ToggleEnabledOuterStroke = Color3.fromRGB(183, 145, 29),
    ToggleDisabledOuterStroke = Color3.fromRGB(68, 68, 73),
    DropdownSelected = Color3.fromRGB(62, 56, 35),
    DropdownUnselected = Color3.fromRGB(43, 43, 46),
    InputBackground = Color3.fromRGB(39, 39, 42),
    InputStroke = Color3.fromRGB(126, 103, 34),
    PlaceholderColor = Color3.fromRGB(176, 169, 139),
    ButtonBackground = Color3.fromRGB(250, 204, 54),
    ButtonBackgroundHover = Color3.fromRGB(255, 218, 86),
    ButtonTextColor = Color3.fromRGB(35, 29, 8),
    ButtonStroke = Color3.fromRGB(24, 24, 27)
}
local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Chr1z218/BananiUi/refs/heads/main/source.lua"
))()
local Window = Rayfield:CreateWindow({
    Name = "🍌 BANANIHUB • v" .. BANANIHUB_VERSION,
    LoadingTitle = "🍌 BANANIHUB",
    LoadingSubtitle = "v" .. BANANIHUB_VERSION .. " • Preparing interface...",
    Theme = DEFAULT_GRAY_THEME,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BANANIHUB",
        FileName = "Settings_v2_6"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})
task.defer(function()
    if Window and Window.ModifyTheme then
        Window.ModifyTheme(DEFAULT_GRAY_THEME)
    end
end)
--==============================================================
-- VARIABLES
--==============================================================
local FlyEnabled = false
local NoclipEnabled = false
local FastWalkEnabled = false
local HighJumpEnabled = false
local InfiniteJumpEnabled = false
local AutoJumpEnabled = false
local FreezeEnabled = false
local FullbrightEnabled = false
local AntiFlingEnabled = false
local AntiAFKEnabled = false
local ChamsEnabled = false
local NPCChamsEnabled = false
local HitboxEnabled = false
local LowGraphicsEnabled = false
local FreecamEnabled = false
local CameraShakeEnabled = false
local Spectating = false
local AntiVoidEnabled = false
local AntiRagdollEnabled = false
local SpiderClimbEnabled = false
local BoxESPEnabled = false
local HealthESPEnabled = false
local FlySpeed = 50
local WalkSpeed = 16
local JumpPower = 50
local FreecamSpeed = 50
local CameraShakeStrength = 0.3
local ChamsFillTransparency = 0.5
local ChamsOutlineTransparency = 0
local ChamsFillColor = Color3.fromRGB(255, 221, 0)
local ChamsOutlineColor = Color3.fromRGB(255, 255, 255)
local ChamsTeamColorsEnabled = false
local SavedPosition = nil
local SelectedPlayer = nil
local SpectatorTarget = nil
local FlyConnection
local AutoJumpConnection
local NoclipConnection
local StatusConnection
local ChamsConnection
local NPCChamsConnection
local HitboxConnection
local FreecamConnection
local CameraShakeConnection
local SpectatorConnection
local ServerStatusConnection
local StatsStatusConnection
local AntiVoidConnection
local AntiRagdollConnection
local SpiderClimbConnection
local ESPConnection
local Unloaded = false
local Runtime = {
    Connections = {},
    NoclipOriginalCollision = setmetatable({}, {__mode = "k"}),
    PerformanceConnections = {},
    PerformanceGeneration = 0,
    AvatarThumbnailCache = {},
    LastStatsUserId = nil,
    RefreshPlayersPending = false,
    HumanoidDefaults = setmetatable({}, {__mode = "k"}),
    AnchorStates = setmetatable({}, {__mode = "k"}),
    FreezeConnection = nil,
    FreezeRoot = nil,
    FreezeCFrame = nil,
    FreezeAnchoredState = nil,
    LightingSnapshot = nil,
    HomeExperienceParagraph = nil,
    HomeGameLabel = nil,
    HomeFavoritesParagraph = nil,
    SettingsInfoParagraph = nil,
    CurrentThemeName = "Default",
    PreferencesFile = "BANANIHUB/UserPreferences.json",
    Favorites = {},
    FavoriteOptions = {
        "Fly",
        "Noclip",
        "Spider Climb",
        "Fast Walk",
        "High Jump",
        "Infinite Jump",
        "Auto Jump",
        "Freeze",
        "Anti Void",
        "Anti Ragdoll",
        "Anti-Fling",
        "Anti-AFK",
        "Teleport Tool",
        "Named Waypoints",
        "Fullbright",
        "Performance Mode",
        "Player Chams",
        "NPC Highlights",
        "Box ESP",
        "Health ESP",
        "Freecam",
        "Spectator",
        "Stats",
        "Server Actions"
    }
}
Runtime.LoadingStage = "Loading library..."
Runtime.VisitedServers = Runtime.VisitedServers or {}
Runtime.AvoidCurrentServer = true
Runtime.AvoidVisitedServers = true
Runtime.CompactMode = Runtime.CompactMode == true
local function SetLoadingStage(Stage)
    Runtime.LoadingStage = tostring(Stage or "")
    pcall(function()
        if Window.SetLoadingSubtitle then
            Window:SetLoadingSubtitle(Runtime.LoadingStage)
        elseif Window.ModifyLoadingSubtitle then
            Window:ModifyLoadingSubtitle(Runtime.LoadingStage)
        end
    end)
    print("BANANIHUB | " .. Runtime.LoadingStage)
end
SetLoadingStage("Creating tabs...")
local function TrackConnection(Connection)
    if Connection then
        table.insert(Runtime.Connections, Connection)
    end
    return Connection
end
TrackConnection(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = workspace.CurrentCamera or Camera
end))
local OriginalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
}
local OriginalGraphics = setmetatable({}, {__mode = "k"})
local FreecamCFrame = Camera.CFrame
local FreecamRotation = Vector2.zero
local FreecamMouseConnection
local FreecamEndConnection
local FreecamChangedConnection
local FreecamScrollStep = 5
local FreecamSmoothEnabled = false
local FreecamSmoothness = 0.18
local FreecamCinematicEnabled = false
local SavedFreecamCFrame = nil
local FreecamOriginalFOV = Camera.FieldOfView
local Waypoints = {}
local WaypointDropdown
local DeleteWaypointDropdown
Runtime.WaypointOrder = Runtime.WaypointOrder or {}
Runtime.WaypointRoute = Runtime.WaypointRoute or {}
Runtime.RouteCurrentIndex = 1
Runtime.RouteDelay = 0.5
Runtime.RouteLoop = false
Runtime.RouteRunning = false
Runtime.RoutePaused = false
Runtime.RouteStatus = "Idle"
Runtime.RouteRunId = 0
Runtime.RouteSelectedWaypoint = nil
Runtime.RouteSelectedCheckpoint = nil
local PlayerDropdown
local SpectatorDropdown
local Dashboard
local SpectatorInfo
local ServerInformation
local StatsInformation
local StatsAvatarLabel
local HelpInformation
local StatsPlayerDropdown
local SelectedStatsPlayer = Player
local ChamsSettingsCreated = false
local CustomThemeName = "Banana"
local SelectedThemeFile = nil
local ThemeFileDropdown
local CustomTheme = {
    TextColor = Color3.fromRGB(255, 248, 214),
    Background = Color3.fromRGB(28, 24, 12),
    Topbar = Color3.fromRGB(42, 35, 14),
    Shadow = Color3.fromRGB(10, 8, 3),
    NotificationBackground = Color3.fromRGB(35, 29, 12),
    NotificationActionsBackground = Color3.fromRGB(255, 224, 72),
    TabBackground = Color3.fromRGB(55, 46, 17),
    TabStroke = Color3.fromRGB(104, 85, 20),
    TabBackgroundSelected = Color3.fromRGB(255, 218, 54),
    TabTextColor = Color3.fromRGB(255, 242, 181),
    SelectedTabTextColor = Color3.fromRGB(44, 34, 3),
    ElementBackground = Color3.fromRGB(45, 37, 14),
    ElementBackgroundHover = Color3.fromRGB(58, 48, 18),
    SecondaryElementBackground = Color3.fromRGB(37, 31, 12),
    ElementStroke = Color3.fromRGB(91, 73, 19),
    SecondaryElementStroke = Color3.fromRGB(71, 58, 17),
    SliderBackground = Color3.fromRGB(112, 89, 19),
    SliderProgress = Color3.fromRGB(255, 214, 43),
    SliderStroke = Color3.fromRGB(255, 231, 107),
    ToggleBackground = Color3.fromRGB(50, 41, 14),
    ToggleEnabled = Color3.fromRGB(255, 210, 34),
    ToggleDisabled = Color3.fromRGB(100, 89, 58),
    ToggleEnabledStroke = Color3.fromRGB(255, 231, 103),
    ToggleDisabledStroke = Color3.fromRGB(127, 113, 74),
    ToggleEnabledOuterStroke = Color3.fromRGB(177, 139, 22),
    ToggleDisabledOuterStroke = Color3.fromRGB(75, 65, 38),
    DropdownSelected = Color3.fromRGB(67, 55, 18),
    DropdownUnselected = Color3.fromRGB(45, 37, 14),
    InputBackground = Color3.fromRGB(41, 34, 13),
    InputStroke = Color3.fromRGB(100, 82, 20),
    PlaceholderColor = Color3.fromRGB(191, 169, 93)
}
--==============================================================
-- HELPERS
--==============================================================
local function GetExperienceThumbnail()
    local IconId = tonumber(PlaceInfo.IconImageAssetId)
    if not IconId or IconId <= 0 then
        return nil
    end
    return "rbxthumb://type=Asset&id="
        .. tostring(IconId)
        .. "&w=420&h=420"
end
local function RefreshExperienceParagraphs()
    local Thumbnail = GetExperienceThumbnail()
    local Details =
        "Creator: " .. tostring(PlaceInfo.Creator)
        .. "\nBananiHub Version: " .. BANANIHUB_VERSION
    if Runtime.HomeGameLabel then
        pcall(function()
            Runtime.HomeGameLabel:Set(
                tostring(PlaceInfo.Name),
                Thumbnail
            )
        end)
    end
    if Runtime.HomeExperienceParagraph then
        pcall(function()
            Runtime.HomeExperienceParagraph:Set({
                Title = "Game Details",
                Content = Details
            })
        end)
    end
end
task.spawn(function()
    local Success, Info = pcall(function()
        return MarketplaceService:GetProductInfo(
            game.PlaceId,
            Enum.InfoType.Asset
        )
    end)
    if Success and type(Info) == "table" then
        PlaceInfo.Name = Info.Name or PlaceInfo.Name
        PlaceInfo.IconImageAssetId =
            tonumber(Info.IconImageAssetId)
            or PlaceInfo.IconImageAssetId
        if Info.Creator and Info.Creator.Name then
            PlaceInfo.Creator = Info.Creator.Name
        else
            PlaceInfo.Creator = "Unknown"
        end
    else
        PlaceInfo.Creator = "Unknown"
    end
    if not Unloaded then
        RefreshExperienceParagraphs()
    end
end)
local function Character()
    return Player.Character
end
local function Humanoid()
    local C = Character()
    return C and C:FindFirstChildOfClass("Humanoid")
end
local function Root()
    local C = Character()
    return C and C:FindFirstChild("HumanoidRootPart")
end
local function Notify(Title, Content)
    if Unloaded then return end
    pcall(function()
        Rayfield:Notify({
            Title = tostring(Title or "BananiHub"),
            Content = tostring(Content or ""),
            Duration = 3
        })
    end)
end
Runtime.SavePreferences = function()
    if not writefile then return false end
    pcall(function()
        if makefolder and isfolder and not isfolder("BANANIHUB") then
            makefolder("BANANIHUB")
        end
    end)
    local Favorites = {}
    for Name, Enabled in pairs(Runtime.Favorites) do
        if Enabled then
            table.insert(Favorites, Name)
        end
    end
    table.sort(Favorites)
    local Success = pcall(function()
        writefile(
            Runtime.PreferencesFile,
            HttpService:JSONEncode({
                Theme = Runtime.CurrentThemeName,
                Keybind = UIToggleKey.Name,
                Favorites = Favorites
            })
        )
    end)
    return Success
end
Runtime.LoadPreferences = function()
    if not readfile or not isfile or not isfile(Runtime.PreferencesFile) then
        return
    end
    local Success, Data = pcall(function()
        return HttpService:JSONDecode(
            readfile(Runtime.PreferencesFile)
        )
    end)
    if not Success or type(Data) ~= "table" then
        return
    end
    if type(Data.Theme) == "string" then
        Runtime.CurrentThemeName = Data.Theme
    end
    if type(Data.Keybind) == "string"
        and Enum.KeyCode[Data.Keybind] then
        UIToggleKey = Enum.KeyCode[Data.Keybind]
    end
    Runtime.Favorites = {}
    if type(Data.Favorites) == "table" then
        for _, Name in ipairs(Data.Favorites) do
            Runtime.Favorites[tostring(Name)] = true
        end
    end
end
Runtime.GetFavoriteList = function()
    local Favorites = {}
    for Name, Enabled in pairs(Runtime.Favorites) do
        if Enabled then
            table.insert(Favorites, Name)
        end
    end
    table.sort(Favorites)
    return Favorites
end
Runtime.UpdatePreferenceDisplays = function()
    local Favorites = Runtime.GetFavoriteList()
    local FavoriteText =
        #Favorites > 0
        and table.concat(Favorites, ", ")
        or "None selected"
    if Runtime.HomeFavoritesParagraph then
        pcall(function()
            Runtime.HomeFavoritesParagraph:Set({
                Title = "⭐ Favorites",
                Content = FavoriteText
            })
        end)
    end
    if Runtime.SettingsInfoParagraph then
        local ConfigCount = 0
        local WaypointCount = 0
        for _ in pairs(Waypoints) do
            WaypointCount += 1
        end
        if listfiles then
            local Success, Files =
                pcall(listfiles, "BANANIHUB/NamedConfigs")
            if Success and type(Files) == "table" then
                for _, FilePath in ipairs(Files) do
                    if tostring(FilePath):match("%.json$") then
                        ConfigCount += 1
                    end
                end
            end
        end
        pcall(function()
            Runtime.SettingsInfoParagraph:Set({
                Title = "⚙️ BananiHub Preferences",
                Content =
                    "Theme: "
                    .. tostring(Runtime.CurrentThemeName)
                    .. "\nKeybind: "
                    .. tostring(UIToggleKey.Name)
                    .. "\nFeature Values: saved through named configs"
                    .. "\nSaved Presets / Configs: "
                    .. tostring(ConfigCount)
                    .. "\nWaypoints: "
                    .. tostring(WaypointCount)
                    .. "\nFavorites: "
                    .. tostring(#Favorites)
            })
        end)
    end
end
Runtime.LoadPreferences()
local function ResolveLogLine(Line)
    local NumericLine = tonumber(Line)
    if NumericLine then
        return math.floor(NumericLine)
    end
    if debug and type(debug.info) == "function" then
        local Success, Result = pcall(function()
            return debug.info(4, "l")
        end)
        if Success and tonumber(Result) then
            return math.floor(tonumber(Result))
        end
    end
    return nil
end
local function InferLogFeature(Message)
    local Text = string.lower(tostring(Message or ""))
    for _, Feature in ipairs({
        "Freecam",
        "Spectator",
        "Stats",
        "Server",
        "Settings",
        "Configs",
        "Theme",
        "Teleport",
        "Waypoint",
        "Performance",
        "Chams",
        "ESP",
        "Fly",
        "Noclip",
        "Player",
        "Visuals"
    }) do
        if string.find(Text, string.lower(Feature), 1, true) then
            return Feature
        end
    end
    return "General"
end
local function AddActionLog(Level, Message, Feature, Line)
    if Unloaded then return end
    local ValidLevels = {
        Success = true,
        Warning = true,
        Error = true,
        Information = true
    }
    Level = ValidLevels[Level] and Level or "Information"
    local ResolvedLine = ResolveLogLine(Line)
    if not ResolvedLine then
        ResolvedLine =
            tonumber(
                tostring(Message or ""):match(":(%d+):")
            )
    end
    local Output =
        "BANANIHUB"
        .. "\nFeature: "
        .. tostring(Feature or InferLogFeature(Message))
        .. "\nResult: "
        .. Level
        .. "\nMessage: "
        .. tostring(Message or "")
        .. "\nLine: "
        .. tostring(ResolvedLine or "Unavailable")
    if Level == "Error" or Level == "Warning" then
        warn(Output)
    else
        print(Output)
    end
end
local function LogSuccess(Message, Feature, Line)
    AddActionLog("Success", Message, Feature, Line)
end
local function LogWarning(Message, Feature, Line)
    AddActionLog("Warning", Message, Feature, Line)
end
local function LogError(Message, Feature, Line)
    AddActionLog("Error", Message, Feature, Line)
end
local function LogInformation(Message, Feature, Line)
    AddActionLog("Information", Message, Feature, Line)
end
Runtime.CopyValue = function(Label, Value)
    if not setclipboard then
        Notify(
            "Copy",
            "Clipboard access is unsupported."
        )
        LogWarning(
            tostring(Label) .. " copy failed: clipboard unsupported",
            "Home"
        )
        return false
    end
    local Success, ErrorMessage =
        pcall(setclipboard, tostring(Value))
    if Success then
        Notify("Copied", tostring(Label) .. " copied.")
        LogSuccess(tostring(Label) .. " copied", "Home")
        return true
    end
    Notify(
        "Copy",
        "Copy failed: " .. tostring(ErrorMessage)
    )
    LogWarning(
        tostring(Label)
        .. " copy failed: "
        .. tostring(ErrorMessage),
        "Home"
    )
    return false
end
local function GetDisplayNames(Filter)
    local List = {}
    local LowerFilter = string.lower(Filter or "")
    for _, P in ipairs(Players:GetPlayers()) do
        if P ~= Player then
            local SearchText = string.lower(P.DisplayName .. " " .. P.Name)
            if LowerFilter == "" or string.find(SearchText, LowerFilter, 1, true) then
                table.insert(
                    List,
                    P.DisplayName .. " (@" .. P.Name .. ")"
                )
            end
        end
    end
    table.sort(List)
    return List
end
local function FindPlayerByDisplayName(Name)
    local SearchName = tostring(Name or "")
    local Username =
        SearchName:match("%(@([^%)]+)%)$")
        or SearchName:match("^@(.+)$")
    for _, P in ipairs(Players:GetPlayers()) do
        if (Username and P.Name == Username)
            or P.DisplayName == SearchName
            or P.Name == SearchName then
            return P
        end
    end
    return nil
end
local function CharacterState(H)
    if not H then return "N/A" end
    return tostring(H:GetState()):gsub("Enum.HumanoidStateType.", "")
end
local function HealthBar(H)
    if not H or H.MaxHealth <= 0 then
        return "🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥 N/A"
    end
    local Ratio = math.clamp(H.Health / H.MaxHealth, 0, 1)
    local Filled = math.floor(Ratio * 10 + 0.5)
    local Empty = 10 - Filled
    local Block
    if Ratio > 0.60 then
        Block = "🟩"
    elseif Ratio > 0.30 then
        Block = "🟨"
    else
        Block = "🟥"
    end
    return string.rep(Block, Filled)
        .. string.rep("⬛", Empty)
        .. " "
        .. math.floor(H.Health)
        .. "/"
        .. math.floor(H.MaxHealth)
end
local function GetPing()
    local Success, Value = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    end)
    return Success and Value or "N/A"
end
local function GetPlayerFromModel(Model)
    return Players:GetPlayerFromCharacter(Model)
end
local function IsNPC(Model)
    return Model:IsA("Model")
        and Model:FindFirstChildOfClass("Humanoid")
        and not GetPlayerFromModel(Model)
end
--==============================================================
-- WAYPOINT STORAGE
--==============================================================
local WaypointFile = "BANANIHUB_Waypoints_" .. tostring(game.PlaceId) .. ".json"
local function EncodeCFrame(CF)
    return {CF:GetComponents()}
end
local function DecodeCFrame(Data)
    if type(Data) ~= "table" or #Data < 12 then return nil end
    return CFrame.new(table.unpack(Data))
end
Runtime.NormalizeWaypointOrder = function()
    local CleanOrder = {}
    local Seen = {}
    for _, Name in ipairs(Runtime.WaypointOrder or {}) do
        if type(Name) == "string"
            and Waypoints[Name] ~= nil
            and not Seen[Name] then
            Seen[Name] = true
            table.insert(CleanOrder, Name)
        end
    end
    local Missing = {}
    for Name in pairs(Waypoints) do
        if type(Name) == "string" and not Seen[Name] then
            table.insert(Missing, Name)
        end
    end
    table.sort(Missing)
    for _, Name in ipairs(Missing) do
        table.insert(CleanOrder, Name)
    end
    Runtime.WaypointOrder = CleanOrder
end
local function LoadWaypoints()
    Waypoints = {}
    Runtime.WaypointOrder = {}
    if isfile and readfile and isfile(WaypointFile) then
        local Success, Data = pcall(function()
            return HttpService:JSONDecode(readfile(WaypointFile))
        end)
        if Success and type(Data) == "table" then
            if type(Data.Points) == "table" then
                Waypoints = Data.Points
                Runtime.WaypointOrder =
                    type(Data.Order) == "table"
                    and Data.Order
                    or {}
            else
                Waypoints = Data
            end
        end
    end
    Runtime.NormalizeWaypointOrder()
end
local function SaveWaypoints()
    if not writefile then return end
    Runtime.NormalizeWaypointOrder()
    pcall(function()
        local Encoded = HttpService:JSONEncode({
            Version = 2,
            Order = Runtime.WaypointOrder,
            Points = Waypoints
        })
        writefile(WaypointFile, Encoded)
    end)
end
local function GetWaypointNames()
    Runtime.NormalizeWaypointOrder()
    return table.clone(Runtime.WaypointOrder)
end
local function RefreshWaypoints()
    local Names = GetWaypointNames()
    if WaypointDropdown then
        WaypointDropdown:Refresh(Names)
    end
    if DeleteWaypointDropdown then
        DeleteWaypointDropdown:Refresh(Names)
    end
    if Runtime.RefreshRouteDropdowns then
        Runtime.RefreshRouteDropdowns()
    end
    if Runtime.UpdateRouteUI then
        Runtime.UpdateRouteUI()
    end
end
LoadWaypoints()
--==============================================================
-- FLY
--==============================================================
local function StopFly()
    FlyEnabled = false
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    local R = Root()
    if R then
        local Velocity = R:FindFirstChild("BananiFlyVelocity")
        local Gyro = R:FindFirstChild("BananiFlyGyro")
        if Velocity then Velocity:Destroy() end
        if Gyro then Gyro:Destroy() end
        -- Zero leftover momentum so toggling off stops you instantly
        -- instead of coasting (which looked like fly never turned off).
        R.AssemblyLinearVelocity = Vector3.zero
        R.AssemblyAngularVelocity = Vector3.zero
    end
end
local function StartFly()
    StopFly()
    local R = Root()
    if not R then
        Notify("Fly", "Your character is not ready.")
        return
    end
    FlyEnabled = true
    local Velocity = Instance.new("BodyVelocity")
    Velocity.Name = "BananiFlyVelocity"
    Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    Velocity.Velocity = Vector3.zero
    Velocity.Parent = R
    local Gyro = Instance.new("BodyGyro")
    Gyro.Name = "BananiFlyGyro"
    Gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    Gyro.P = 90000
    Gyro.D = 500
    Gyro.Parent = R
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not FlyEnabled or not R.Parent or not Velocity.Parent then
            StopFly()
            return
        end
        local Direction = Vector3.zero
        local CF = Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction += CF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction -= CF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction -= CF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction += CF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Direction += Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Direction -= Vector3.yAxis end
        if Direction.Magnitude > 0 then Direction = Direction.Unit end
        Velocity.Velocity = Direction * FlySpeed
        Gyro.CFrame = CF
    end)
end
--==============================================================
-- MOVEMENT / PLAYER STATE
--==============================================================
local function SetNoclip(Value)
    NoclipEnabled = Value
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    if not Value then
        for Part, OriginalCanCollide in pairs(Runtime.NoclipOriginalCollision) do
            if Part and Part.Parent then
                pcall(function()
                    Part.CanCollide = OriginalCanCollide
                end)
            end
        end
        Runtime.NoclipOriginalCollision = setmetatable({}, {__mode = "k"})
        return
    end
    local Accumulator = 0
    NoclipConnection = RunService.Stepped:Connect(function(_, Delta)
        Accumulator += Delta or 0
        if Accumulator < 0.15 then return end
        Accumulator = 0
        local C = Character()
        if not C then return end
        for _, Object in ipairs(C:GetDescendants()) do
            if Object:IsA("BasePart") then
                if Runtime.NoclipOriginalCollision[Object] == nil then
                    Runtime.NoclipOriginalCollision[Object] = Object.CanCollide
                end
                if Object.CanCollide then
                    Object.CanCollide = false
                end
            end
        end
    end)
end
local function UpdateMovement()
    local H = Humanoid()
    if not H then return end
    local Defaults = Runtime.HumanoidDefaults[H]
    if not Defaults then
        Defaults = {
            WalkSpeed = H.WalkSpeed,
            JumpPower = H.JumpPower,
            JumpHeight = H.JumpHeight,
            AutoRotate = H.AutoRotate
        }
        Runtime.HumanoidDefaults[H] = Defaults
    end
    if FreezeEnabled then
        H.WalkSpeed = 0
        H.JumpPower = 0
        H.JumpHeight = 0
        H.AutoRotate = false
        return
    end
    H.WalkSpeed = FastWalkEnabled and WalkSpeed or Defaults.WalkSpeed
    if HighJumpEnabled then
        if H.UseJumpPower then
            H.JumpPower = JumpPower
        else
            H.JumpHeight = math.max(Defaults.JumpHeight, JumpPower / 7)
        end
    else
        H.JumpPower = Defaults.JumpPower
        H.JumpHeight = Defaults.JumpHeight
    end
    H.AutoRotate = Defaults.AutoRotate
end
local function DisconnectFreeze()
    if Runtime.FreezeConnection then
        pcall(function()
            Runtime.FreezeConnection:Disconnect()
        end)
        Runtime.FreezeConnection = nil
    end
end
local function SetFreeze(Value)
    FreezeEnabled = Value == true
    DisconnectFreeze()
    local H = Humanoid()
    local R = Root()
    if not FreezeEnabled then
        local FrozenRoot = Runtime.FreezeRoot
        if FrozenRoot and FrozenRoot.Parent then
            FrozenRoot.AssemblyLinearVelocity = Vector3.zero
            FrozenRoot.AssemblyAngularVelocity = Vector3.zero
            if not FreecamEnabled and not Spectating then
                FrozenRoot.Anchored = Runtime.FreezeAnchoredState == true
            end
        end
        Runtime.FreezeRoot = nil
        Runtime.FreezeCFrame = nil
        Runtime.FreezeAnchoredState = nil
        UpdateMovement()
        return
    end
    if not H or not R then
        FreezeEnabled = false
        Notify("Freeze", "Your character is not ready.")
        UpdateMovement()
        return
    end
    Runtime.FreezeRoot = R
    Runtime.FreezeCFrame = R.CFrame
    Runtime.FreezeAnchoredState = R.Anchored
    UpdateMovement()
    R.AssemblyLinearVelocity = Vector3.zero
    R.AssemblyAngularVelocity = Vector3.zero
    R.Anchored = true
    Runtime.FreezeConnection = RunService.Heartbeat:Connect(function()
        if not FreezeEnabled or Unloaded then return end
        local CurrentHumanoid = Humanoid()
        local CurrentRoot = Root()
        if not CurrentHumanoid or not CurrentRoot then return end
        if Runtime.FreezeRoot ~= CurrentRoot then
            Runtime.FreezeRoot = CurrentRoot
            Runtime.FreezeCFrame = CurrentRoot.CFrame
            Runtime.FreezeAnchoredState = CurrentRoot.Anchored
        end
        CurrentHumanoid.WalkSpeed = 0
        CurrentHumanoid.JumpPower = 0
        CurrentHumanoid.JumpHeight = 0
        CurrentHumanoid.AutoRotate = false
        CurrentRoot.AssemblyLinearVelocity = Vector3.zero
        CurrentRoot.AssemblyAngularVelocity = Vector3.zero
        CurrentRoot.Anchored = true
        if Runtime.FreezeCFrame then
            CurrentRoot.CFrame = Runtime.FreezeCFrame
        end
    end)
end
local AutoJumpCooldown = false
do
    local Accumulator = 0
    AutoJumpConnection = RunService.Heartbeat:Connect(function(Delta)
        if not AutoJumpEnabled then
            Accumulator = 0
            return
        end
        Accumulator += Delta
        if Accumulator < 0.10 then return end
        Accumulator = 0
        local H = Humanoid()
        if not H or H.Health <= 0 then return end
        if H.FloorMaterial ~= Enum.Material.Air and not AutoJumpCooldown then
            AutoJumpCooldown = true
            H:ChangeState(Enum.HumanoidStateType.Jumping)
            task.delay(0.25, function()
                AutoJumpCooldown = false
            end)
        end
    end)
end
TrackConnection(UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local H = Humanoid()
        if H and H.Health > 0 then
            H:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end))
do
    local Accumulator = 0
    TrackConnection(RunService.Heartbeat:Connect(function(Delta)
        if not AntiFlingEnabled then
            Accumulator = 0
            return
        end
        Accumulator += Delta
        if Accumulator < 0.10 then return end
        Accumulator = 0
        local R = Root()
        if R and (
            R.AssemblyLinearVelocity.Magnitude > 250
            or R.AssemblyAngularVelocity.Magnitude > 100
        ) then
            R.AssemblyLinearVelocity = Vector3.zero
            R.AssemblyAngularVelocity = Vector3.zero
        end
    end))
end
TrackConnection(Player.Idled:Connect(function()
    if AntiAFKEnabled then
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end))
--==============================================================
-- TWEEN TRAVEL (shared by waypoint teleport and the route)
--==============================================================
Runtime.TweenSpeed = Runtime.TweenSpeed or 80  -- studs per second
Runtime.TweenActive = false
Runtime.TweenCancel = false
Runtime.RouteTravelMode = Runtime.RouteTravelMode or "Teleport"
local function CancelTween()
    if Runtime.TweenActive then
        Runtime.TweenCancel = true
    end
end
-- Smoothly slides the root to TargetCFrame. Yields until arrival or cancel.
-- Returns true if it reached the destination.
local function TweenRootTo(TargetCFrame)
    if not TargetCFrame then return false end
    local R = Root()
    local H = Humanoid()
    if not R then return false end
    if Runtime.TweenActive then
        Runtime.TweenCancel = true
        repeat task.wait() until not Runtime.TweenActive or Unloaded
    end
    Runtime.TweenActive = true
    Runtime.TweenCancel = false
    local StartCFrame = R.CFrame
    local Distance = (TargetCFrame.Position - StartCFrame.Position).Magnitude
    local Duration = math.clamp(Distance / math.max(Runtime.TweenSpeed, 1), 0.05, 120)
    local RestoreNoclip = not NoclipEnabled
    if RestoreNoclip then SetNoclip(true) end
    local WasPlatformStand = H and H.PlatformStand or false
    if H then H.PlatformStand = true end
    local Elapsed = 0
    while Elapsed < Duration do
        if Runtime.TweenCancel or Unloaded then break end
        local CurrentRoot = Root()
        if not CurrentRoot or not CurrentRoot.Parent then break end
        Elapsed += RunService.Heartbeat:Wait()
        local Alpha = TweenService:GetValue(
            math.clamp(Elapsed / Duration, 0, 1),
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.InOut
        )
        CurrentRoot.CFrame = StartCFrame:Lerp(TargetCFrame, Alpha)
        CurrentRoot.AssemblyLinearVelocity = Vector3.zero
    end
    local Reached = not Runtime.TweenCancel
    local FinalRoot = Root()
    if FinalRoot and FinalRoot.Parent and Reached then
        FinalRoot.CFrame = TargetCFrame
        FinalRoot.AssemblyLinearVelocity = Vector3.zero
    end
    local FinalHumanoid = Humanoid()
    if FinalHumanoid then FinalHumanoid.PlatformStand = WasPlatformStand end
    if RestoreNoclip then SetNoclip(false) end
    Runtime.TweenActive = false
    Runtime.TweenCancel = false
    return Reached
end
--==============================================================
-- LIGHTING / VISUALS
--==============================================================
local function CaptureLightingSnapshot()
    Runtime.LightingSnapshot = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        FogEnd = Lighting.FogEnd,
        GlobalShadows = Lighting.GlobalShadows,
        EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
    }
end
local function RefreshLightingState()
    local Base = Runtime.LightingSnapshot or OriginalLighting
    if FullbrightEnabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
    else
        Lighting.Brightness = Base.Brightness
        Lighting.ClockTime = Base.ClockTime
        Lighting.FogEnd = Base.FogEnd
    end
    Lighting.GlobalShadows =
        (FullbrightEnabled or LowGraphicsEnabled) and false or Base.GlobalShadows
    Lighting.EnvironmentDiffuseScale =
        LowGraphicsEnabled and 0 or Base.EnvironmentDiffuseScale
    Lighting.EnvironmentSpecularScale =
        LowGraphicsEnabled and 0 or Base.EnvironmentSpecularScale
end
local function SetFullbright(Value)
    if Value and not FullbrightEnabled and not LowGraphicsEnabled then
        CaptureLightingSnapshot()
    end
    FullbrightEnabled = Value
    RefreshLightingState()
    if not FullbrightEnabled and not LowGraphicsEnabled then
        Runtime.LightingSnapshot = nil
    end
end
local function ApplyHighlight(Model, Name, TargetPlayer)
    if not Model or not Model.Parent then return end
    local Highlight = Model:FindFirstChild(Name)
    if not Highlight then
        Highlight = Instance.new("Highlight")
        Highlight.Name = Name
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.Parent = Model
    end
    local FillColor = ChamsFillColor
    local OutlineColor = ChamsOutlineColor
    if Name == "BananiPlayerChams"
        and ChamsTeamColorsEnabled
        and TargetPlayer
        and TargetPlayer.Team then
        FillColor = TargetPlayer.TeamColor.Color
        OutlineColor = TargetPlayer.TeamColor.Color
    end
    Highlight.FillColor = FillColor
    Highlight.OutlineColor = OutlineColor
    Highlight.FillTransparency = ChamsFillTransparency
    Highlight.OutlineTransparency = ChamsOutlineTransparency
end
local function ClearHighlights(Name)
    for _, Object in ipairs(workspace:GetDescendants()) do
        if Object:IsA("Highlight") and Object.Name == Name then
            Object:Destroy()
        end
    end
end
local function SetChams(Value)
    ChamsEnabled = Value
    if ChamsConnection then
        ChamsConnection:Disconnect()
        ChamsConnection = nil
    end
    if not Value then
        ClearHighlights("BananiPlayerChams")
        return
    end
    local function Refresh()
        for _, Target in ipairs(Players:GetPlayers()) do
            if Target ~= Player and Target.Character then
                ApplyHighlight(Target.Character, "BananiPlayerChams", Target)
            end
        end
    end
    local Accumulator = 0
    Refresh()
    ChamsConnection = RunService.Heartbeat:Connect(function(Delta)
        Accumulator += Delta
        if Accumulator < 0.50 then return end
        Accumulator = 0
        Refresh()
    end)
end
local function SetNPCChams(Value)
    NPCChamsEnabled = Value
    if NPCChamsConnection then
        NPCChamsConnection:Disconnect()
        NPCChamsConnection = nil
    end
    if not Value then
        ClearHighlights("BananiNPCChams")
        return
    end
    local function TryApply(Object)
        if not NPCChamsEnabled or not Object then return end
        local Model
        if Object:IsA("Model") then
            Model = Object
        else
            Model = Object:FindFirstAncestorOfClass("Model")
        end
        if Model and IsNPC(Model) then
            ApplyHighlight(Model, "BananiNPCChams")
        end
    end
    task.spawn(function()
        local Descendants = workspace:GetDescendants()
        for Index, Object in ipairs(Descendants) do
            if not NPCChamsEnabled or Unloaded then return end
            if Object:IsA("Model") or Object:IsA("Humanoid") then
                TryApply(Object)
            end
            if Index % 250 == 0 then task.wait() end
        end
    end)
    NPCChamsConnection = workspace.DescendantAdded:Connect(function(Object)
        if NPCChamsEnabled and (Object:IsA("Model") or Object:IsA("Humanoid")) then
            task.defer(TryApply, Object)
        end
    end)
end
local function SetHitboxes(Value)
    HitboxEnabled = Value
    if HitboxConnection then
        HitboxConnection:Disconnect()
        HitboxConnection = nil
    end
    local function Clear()
        for _, Target in ipairs(Players:GetPlayers()) do
            local C = Target.Character
            local R = C and C:FindFirstChild("HumanoidRootPart")
            local Existing = R and R:FindFirstChild("BananiHitbox")
            if Existing then Existing:Destroy() end
        end
    end
    if not Value then
        Clear()
        return
    end
    local function Refresh()
        for _, Target in ipairs(Players:GetPlayers()) do
            if Target ~= Player and Target.Character then
                local R = Target.Character:FindFirstChild("HumanoidRootPart")
                if R and not R:FindFirstChild("BananiHitbox") then
                    local Box = Instance.new("BoxHandleAdornment")
                    Box.Name = "BananiHitbox"
                    Box.Adornee = R
                    Box.AlwaysOnTop = true
                    Box.ZIndex = 10
                    Box.Size = R.Size
                    Box.Transparency = 0.5
                    Box.Color3 = ChamsFillColor
                    Box.Parent = R
                end
            end
        end
    end
    local Accumulator = 0
    Refresh()
    HitboxConnection = RunService.Heartbeat:Connect(function(Delta)
        Accumulator += Delta
        if Accumulator < 0.50 then return end
        Accumulator = 0
        Refresh()
    end)
end
local function SetLowGraphics(Value)
    if Value == LowGraphicsEnabled then return end
    if Value and not LowGraphicsEnabled and not FullbrightEnabled then
        CaptureLightingSnapshot()
    end
    LowGraphicsEnabled = Value
    Runtime.PerformanceGeneration += 1
    local Generation = Runtime.PerformanceGeneration
    for _, Connection in ipairs(Runtime.PerformanceConnections) do
        pcall(function() Connection:Disconnect() end)
    end
    Runtime.PerformanceConnections = {}
    local function IsEffect(Object)
        return Object:IsA("ParticleEmitter")
            or Object:IsA("Trail")
            or Object:IsA("Beam")
            or Object:IsA("Smoke")
            or Object:IsA("Fire")
            or Object:IsA("Sparkles")
            or Object:IsA("BloomEffect")
            or Object:IsA("BlurEffect")
            or Object:IsA("SunRaysEffect")
            or Object:IsA("DepthOfFieldEffect")
            or Object:IsA("ColorCorrectionEffect")
    end
    local function SaveOriginal(Object, Data)
        if OriginalGraphics[Object] == nil then
            OriginalGraphics[Object] = Data
        end
    end
    local function ApplyObject(Object)
        if not Value or not Object or not Object.Parent
            or Generation ~= Runtime.PerformanceGeneration then
            return
        end
        if Object:IsA("BasePart") then
            SaveOriginal(Object, {
                Material = Object.Material,
                Reflectance = Object.Reflectance,
                CastShadow = Object.CastShadow
            })
            pcall(function()
                Object.Material = Enum.Material.SmoothPlastic
                Object.Reflectance = 0
                Object.CastShadow = false
            end)
        elseif IsEffect(Object) then
            SaveOriginal(Object, { Enabled = Object.Enabled })
            pcall(function() Object.Enabled = false end)
        end
    end
    if not Value then
        RefreshLightingState()
        if not FullbrightEnabled then
            Runtime.LightingSnapshot = nil
        end
        local SavedGraphics = OriginalGraphics
        OriginalGraphics = setmetatable({}, {__mode = "k"})
        task.spawn(function()
            local Index = 0
            for Object, Data in pairs(SavedGraphics) do
                if Generation ~= Runtime.PerformanceGeneration then return end
                if Object and Object.Parent then
                    for Property, OriginalValue in pairs(Data) do
                        pcall(function() Object[Property] = OriginalValue end)
                    end
                end
                Index += 1
                if Index % 250 == 0 then task.wait() end
            end
            if Generation == Runtime.PerformanceGeneration and not Unloaded then
                LogSuccess("Performance Mode disabled and visuals restored")
            end
        end)
        return
    end
    OriginalGraphics = setmetatable({}, {__mode = "k"})
    RefreshLightingState()
    table.insert(Runtime.PerformanceConnections,
        workspace.DescendantAdded:Connect(function(Object)
            task.defer(ApplyObject, Object)
        end))
    table.insert(Runtime.PerformanceConnections,
        Lighting.ChildAdded:Connect(function(Object)
            task.defer(ApplyObject, Object)
        end))
    task.spawn(function()
        local DisabledCount = 0
        local SimplifiedCount = 0
        local Descendants = workspace:GetDescendants()
        for Index, Object in ipairs(Descendants) do
            if not LowGraphicsEnabled
                or Generation ~= Runtime.PerformanceGeneration
                or Unloaded then
                return
            end
            if Object:IsA("BasePart") then
                SimplifiedCount += 1
            elseif IsEffect(Object) then
                DisabledCount += 1
            end
            ApplyObject(Object)
            if Index % 250 == 0 then task.wait() end
        end
        for _, Object in ipairs(Lighting:GetChildren()) do
            ApplyObject(Object)
        end
        if Generation == Runtime.PerformanceGeneration then
            LogSuccess(
                "Performance Mode enabled: "
                .. DisabledCount .. " effects disabled, "
                .. SimplifiedCount .. " parts simplified"
            )
        end
    end)
end
local StopSpectating
local function SetCharacterLocked(Value)
    local R = Root()
    if not R then return end
    if Value then
        if Runtime.AnchorStates[R] == nil then
            Runtime.AnchorStates[R] = R.Anchored
        end
        R.Anchored = true
        R.AssemblyLinearVelocity = Vector3.zero
        R.AssemblyAngularVelocity = Vector3.zero
    else
        local OriginalAnchored = Runtime.AnchorStates[R]
        if OriginalAnchored ~= nil then
            R.Anchored = OriginalAnchored
            Runtime.AnchorStates[R] = nil
        end
    end
end
--==============================================================
-- FREECAM
--==============================================================
local FreecamLooking = false
local function DisconnectFreecamInputs()
    for _, Connection in ipairs({
        FreecamMouseConnection,
        FreecamEndConnection,
        FreecamChangedConnection
    }) do
        if Connection then
            pcall(function() Connection:Disconnect() end)
        end
    end
    FreecamMouseConnection = nil
    FreecamEndConnection = nil
    FreecamChangedConnection = nil
end
local function StopFreecam()
    local WasEnabled = FreecamEnabled
    FreecamEnabled = false
    FreecamLooking = false
    if FreecamConnection then
        FreecamConnection:Disconnect()
        FreecamConnection = nil
    end
    DisconnectFreecamInputs()
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    Camera.CameraType = Enum.CameraType.Custom
    Camera.FieldOfView = FreecamOriginalFOV
    local H = Humanoid()
    if H and not Spectating then
        Camera.CameraSubject = H
    end
    if not Spectating then
        SetCharacterLocked(false)
    end
    if WasEnabled then
        LogSuccess("Freecam disabled")
    end
end
local function StartFreecam()
    StopSpectating()
    StopFreecam()
    if not Root() then
        Notify("Freecam", "Your character is unavailable.")
        LogWarning("Freecam failed: character unavailable")
        return
    end
    SetCharacterLocked(true)
    FreecamEnabled = true
    FreecamCFrame = Camera.CFrame
    FreecamOriginalFOV = Camera.FieldOfView
    local X, Y = FreecamCFrame:ToOrientation()
    FreecamRotation = Vector2.new(X, Y)
    Camera.CameraType = Enum.CameraType.Scriptable
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    if FreecamCinematicEnabled then
        Camera.FieldOfView = 50
    end
    FreecamMouseConnection = UserInputService.InputBegan:Connect(function(Input, Processed)
        if Processed or not FreecamEnabled then return end
        if Input.UserInputType == Enum.UserInputType.MouseButton2 then
            FreecamLooking = true
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
        end
    end)
    FreecamEndConnection = UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton2 then
            FreecamLooking = false
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)
    FreecamChangedConnection = UserInputService.InputChanged:Connect(function(Input)
        if not FreecamEnabled then return end
        if Input.UserInputType == Enum.UserInputType.MouseMovement and FreecamLooking then
            local Sensitivity = FreecamCinematicEnabled and 0.0018 or 0.0028
            FreecamRotation -= Vector2.new(Input.Delta.Y, Input.Delta.X) * Sensitivity
            FreecamRotation = Vector2.new(
                math.clamp(FreecamRotation.X, -1.55, 1.55),
                FreecamRotation.Y
            )
        elseif Input.UserInputType == Enum.UserInputType.MouseWheel then
            local Direction = Input.Position.Z > 0 and 1 or -1
            FreecamSpeed = math.clamp(FreecamSpeed + Direction * FreecamScrollStep, 5, 250)
        end
    end)
    FreecamConnection = RunService.RenderStepped:Connect(function(Delta)
        if not FreecamEnabled then return end
        local Rotation = CFrame.fromOrientation(FreecamRotation.X, FreecamRotation.Y, 0)
        local Direction = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction += Rotation.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction -= Rotation.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction -= Rotation.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction += Rotation.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then Direction += Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then Direction -= Vector3.yAxis end
        if Direction.Magnitude > 0 then Direction = Direction.Unit end
        local SpeedMultiplier = FreecamCinematicEnabled and 0.45 or 1
        local Position = FreecamCFrame.Position + Direction * FreecamSpeed * SpeedMultiplier * Delta
        local TargetCFrame = CFrame.new(Position) * Rotation
        FreecamCFrame = TargetCFrame
        if FreecamSmoothEnabled or FreecamCinematicEnabled then
            local Amount = FreecamCinematicEnabled
                and math.min(FreecamSmoothness, 0.12)
                or FreecamSmoothness
            local Alpha = 1 - math.pow(1 - math.clamp(Amount, 0.02, 1), Delta * 60)
            Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, Alpha)
        else
            Camera.CFrame = TargetCFrame
        end
    end)
    LogSuccess("Freecam enabled")
end
local function SaveFreecamPosition()
    if not FreecamEnabled then
        Notify("Freecam", "Enable Freecam first.")
        return
    end
    SavedFreecamCFrame = Camera.CFrame
    Notify("Freecam", "Camera position saved.")
end
local function ReturnToSavedFreecamPosition()
    if not SavedFreecamCFrame then
        Notify("Freecam", "Save a camera position first.")
        return
    end
    if not FreecamEnabled then StartFreecam() end
    FreecamCFrame = SavedFreecamCFrame
    Camera.CFrame = SavedFreecamCFrame
    local X, Y = SavedFreecamCFrame:ToOrientation()
    FreecamRotation = Vector2.new(X, Y)
    LogSuccess("Returned to saved Freecam position")
end
local function SetCameraShake(Value)
    CameraShakeEnabled = Value
    if CameraShakeConnection then
        CameraShakeConnection:Disconnect()
        CameraShakeConnection = nil
    end
    if not Value then return end
    CameraShakeConnection = RunService.RenderStepped:Connect(function()
        if CameraShakeEnabled and not FreecamEnabled then
            local Offset = Vector3.new(
                (math.random() - 0.5) * CameraShakeStrength,
                (math.random() - 0.5) * CameraShakeStrength,
                0
            )
            Camera.CFrame = Camera.CFrame * CFrame.new(Offset)
        end
    end)
end
StopSpectating = function()
    Spectating = false
    if SpectatorConnection then
        SpectatorConnection:Disconnect()
        SpectatorConnection = nil
    end
    Camera.CameraType = Enum.CameraType.Custom
    local H = Humanoid()
    if H and not FreecamEnabled then
        Camera.CameraSubject = H
    end
    if not FreecamEnabled then
        SetCharacterLocked(false)
    end
    if SpectatorInfo then
        local SelectedText = SpectatorTarget
            and ("Selected: " .. SpectatorTarget.DisplayName .. " (@" .. SpectatorTarget.Name .. ")")
            or "Select a player above."
        SpectatorInfo:Set({ Title = "Spectator", Content = SelectedText })
    end
end
local function StartSpectating(Target)
    if not Target or Target == Player then
        Notify("Spectator", "Select another player first.")
        return
    end
    StopFreecam()
    StopSpectating()
    SetCharacterLocked(true)
    SpectatorTarget = Target
    Spectating = true
    LogSuccess("Spectating " .. Target.DisplayName)
    local InitialCharacter = Target.Character
    local InitialHumanoid = InitialCharacter and InitialCharacter:FindFirstChildOfClass("Humanoid")
    if InitialHumanoid then
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = InitialHumanoid
    end
    local Accumulator = 0.25
    SpectatorConnection = RunService.Heartbeat:Connect(function(Delta)
        if not Spectating or not SpectatorTarget or not SpectatorTarget.Parent then
            StopSpectating()
            return
        end
        Accumulator += Delta
        if Accumulator < 0.25 then return end
        Accumulator = 0
        local TargetCharacter = SpectatorTarget.Character
        local TargetHumanoid = TargetCharacter and TargetCharacter:FindFirstChildOfClass("Humanoid")
        local TargetRoot = TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart")
        local MyRoot = Root()
        if TargetHumanoid then
            Camera.CameraType = Enum.CameraType.Custom
            Camera.CameraSubject = TargetHumanoid
        end
        if SpectatorInfo then
            local Distance = MyRoot and TargetRoot
                and math.floor((MyRoot.Position - TargetRoot.Position).Magnitude) or 0
            local Health = TargetHumanoid
                and (math.floor(TargetHumanoid.Health) .. "/" .. math.floor(TargetHumanoid.MaxHealth))
                or "N/A"
            local Speed = TargetHumanoid and math.floor(TargetHumanoid.WalkSpeed) or "N/A"
            SpectatorInfo:Set({
                Title = "👀 " .. SpectatorTarget.DisplayName,
                Content =
                    "Username: @" .. SpectatorTarget.Name
                    .. "\nHealth: " .. Health
                    .. "\nDistance: " .. tostring(Distance) .. " studs"
                    .. "\nState: " .. CharacterState(TargetHumanoid)
                    .. "\nWalkSpeed: " .. tostring(Speed)
                    .. "\nAccount Age: " .. tostring(SpectatorTarget.AccountAge) .. " days"
                    .. "\nUser ID: " .. tostring(SpectatorTarget.UserId)
            })
        end
    end)
end
local function GetSpectatorCandidates()
    local List = {}
    for _, Target in ipairs(Players:GetPlayers()) do
        if Target ~= Player then
            table.insert(List, Target)
        end
    end
    table.sort(List, function(A, B)
        return string.lower(A.DisplayName .. A.Name) < string.lower(B.DisplayName .. B.Name)
    end)
    return List
end
local function SwitchSpectator(Direction)
    local Candidates = GetSpectatorCandidates()
    if #Candidates == 0 then
        StopSpectating()
        Notify("Spectator", "No other players are available.")
        return
    end
    local CurrentIndex = 0
    for Index, Target in ipairs(Candidates) do
        if Target == SpectatorTarget then
            CurrentIndex = Index
            break
        end
    end
    local NextIndex
    if Direction < 0 then
        NextIndex = CurrentIndex > 1 and CurrentIndex - 1 or #Candidates
    else
        NextIndex = CurrentIndex < #Candidates and CurrentIndex + 1 or 1
    end
    SpectatorTarget = Candidates[NextIndex]
    if Spectating then
        StartSpectating(SpectatorTarget)
    elseif SpectatorInfo then
        SpectatorInfo:Set({
            Title = "Spectator",
            Content = "Selected: " .. SpectatorTarget.DisplayName .. " (@" .. SpectatorTarget.Name .. ")"
        })
    end
end
--==============================================================
-- PLAYER LIST REFRESH
--==============================================================
local function RefreshPlayers()
    local Names = GetDisplayNames()
    if PlayerDropdown then PlayerDropdown:Refresh(Names) end
    if SpectatorDropdown then SpectatorDropdown:Refresh(Names) end
    if Runtime.RefreshStatsPlayers then Runtime.RefreshStatsPlayers() end
    if SelectedPlayer and not FindPlayerByDisplayName(SelectedPlayer) then
        SelectedPlayer = nil
    end
    if SpectatorTarget and not SpectatorTarget.Parent then
        SpectatorTarget = nil
    end
end
local function SchedulePlayerRefresh()
    if Runtime.RefreshPlayersPending then return end
    Runtime.RefreshPlayersPending = true
    task.defer(function()
        Runtime.RefreshPlayersPending = false
        if not Unloaded then RefreshPlayers() end
    end)
end
TrackConnection(Players.PlayerAdded:Connect(function(Target)
    SchedulePlayerRefresh()
    LogInformation(Target.DisplayName .. " joined the server.", "Server")
end))
TrackConnection(Players.PlayerRemoving:Connect(function(Target)
    local WasSpectated = Spectating and SpectatorTarget == Target
    LogInformation("Player left: " .. Target.DisplayName .. " (@" .. Target.Name .. ")", "Spectator")
    SchedulePlayerRefresh()
    if WasSpectated then
        task.defer(function()
            if Unloaded then return end
            SpectatorTarget = nil
            local Candidates = GetSpectatorCandidates()
            if #Candidates > 0 then
                SpectatorTarget = Candidates[1]
                StartSpectating(SpectatorTarget)
                LogInformation("Automatically switched to " .. SpectatorTarget.DisplayName, "Spectator")
            else
                StopSpectating()
                Notify("Spectator", "The player left and nobody else is available.")
            end
        end)
    end
end))
--==============================================================
-- EXTRA PLAYER PROTECTION / MOVEMENT
--==============================================================
local LastSafeCFrame = nil
local AntiVoidHeight = -50
local function SetAntiVoid(Value)
    AntiVoidEnabled = Value
    if AntiVoidConnection then
        AntiVoidConnection:Disconnect()
        AntiVoidConnection = nil
    end
    if not Value then return end
    local Accumulator = 0
    AntiVoidConnection = RunService.Heartbeat:Connect(function(Delta)
        Accumulator += Delta
        if Accumulator < 0.10 then return end
        Accumulator = 0
        local R = Root()
        local H = Humanoid()
        if not R or not H or H.Health <= 0 then return end
        if H.FloorMaterial ~= Enum.Material.Air and R.Position.Y > AntiVoidHeight + 15 then
            LastSafeCFrame = R.CFrame
        elseif R.Position.Y <= AntiVoidHeight and LastSafeCFrame then
            R.AssemblyLinearVelocity = Vector3.zero
            R.AssemblyAngularVelocity = Vector3.zero
            R.CFrame = LastSafeCFrame + Vector3.new(0, 4, 0)
            Notify("Anti Void", "Returned you to your last safe position.")
        end
    end)
end
local function SetAntiRagdoll(Value)
    AntiRagdollEnabled = Value
    if AntiRagdollConnection then
        AntiRagdollConnection:Disconnect()
        AntiRagdollConnection = nil
    end
    if not Value then return end
    local Accumulator = 0
    AntiRagdollConnection = RunService.Heartbeat:Connect(function(Delta)
        Accumulator += Delta
        if Accumulator < 0.10 then return end
        Accumulator = 0
        local H = Humanoid()
        if not H or H.Health <= 0 then return end
        H.PlatformStand = false
        H.Sit = false
        local State = H:GetState()
        if State == Enum.HumanoidStateType.Ragdoll
            or State == Enum.HumanoidStateType.FallingDown
            or State == Enum.HumanoidStateType.Physics then
            H:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end
local function SetSpiderClimb(Value)
    SpiderClimbEnabled = Value
    if SpiderClimbConnection then
        SpiderClimbConnection:Disconnect()
        SpiderClimbConnection = nil
    end
    if not Value then return end
    local Accumulator = 0
    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Exclude
    SpiderClimbConnection = RunService.Heartbeat:Connect(function(Delta)
        Accumulator += Delta
        if Accumulator < 0.05 then return end
        Accumulator = 0
        local R = Root()
        local H = Humanoid()
        local C = Character()
        if not R or not H or not C then return end
        Params.FilterDescendantsInstances = {C}
        local Result = workspace:Raycast(R.Position, R.CFrame.LookVector * 3.5, Params)
        if Result and UserInputService:IsKeyDown(Enum.KeyCode.W) then
            R.AssemblyLinearVelocity = Vector3.new(R.AssemblyLinearVelocity.X, 32, R.AssemblyLinearVelocity.Z)
            H:ChangeState(Enum.HumanoidStateType.Climbing)
        end
    end)
end
--==============================================================
-- BOX / HEALTH ESP
--==============================================================
local function RemoveESPFromCharacter(CharacterModel)
    if not CharacterModel then return end
    local RootPart = CharacterModel:FindFirstChild("HumanoidRootPart")
    if RootPart then
        local Existing = RootPart:FindFirstChild("BananiESP")
        if Existing then Existing:Destroy() end
    end
end
local function UpdatePlayerESP(Target)
    if Target == Player then return end
    local C = Target.Character
    local R = C and C:FindFirstChild("HumanoidRootPart")
    local H = C and C:FindFirstChildOfClass("Humanoid")
    if not C or not R or not H or (not BoxESPEnabled and not HealthESPEnabled) then
        RemoveESPFromCharacter(C)
        return
    end
    local Billboard = R:FindFirstChild("BananiESP")
    if not Billboard then
        Billboard = Instance.new("BillboardGui")
        Billboard.Name = "BananiESP"
        Billboard.AlwaysOnTop = true
        Billboard.Size = UDim2.fromOffset(70, 100)
        Billboard.StudsOffset = Vector3.new(0, 0.5, 0)
        Billboard.Adornee = R
        Billboard.Parent = R
        local Box = Instance.new("Frame")
        Box.Name = "Box"
        Box.AnchorPoint = Vector2.new(0.5, 0.5)
        Box.Position = UDim2.fromScale(0.5, 0.5)
        Box.Size = UDim2.fromOffset(38, 76)
        Box.BackgroundTransparency = 1
        Box.Parent = Billboard
        local Stroke = Instance.new("UIStroke")
        Stroke.Name = "BoxStroke"
        Stroke.Thickness = 1
        Stroke.Color = Color3.fromRGB(255, 221, 0)
        Stroke.Parent = Box
        local HealthBack = Instance.new("Frame")
        HealthBack.Name = "HealthBack"
        HealthBack.Position = UDim2.new(0, 10, 0, 12)
        HealthBack.Size = UDim2.fromOffset(3, 76)
        HealthBack.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        HealthBack.BorderSizePixel = 0
        HealthBack.Parent = Billboard
        local HealthFill = Instance.new("Frame")
        HealthFill.Name = "HealthFill"
        HealthFill.AnchorPoint = Vector2.new(0, 1)
        HealthFill.Position = UDim2.fromScale(0, 1)
        HealthFill.Size = UDim2.fromScale(1, 1)
        HealthFill.BorderSizePixel = 0
        HealthFill.Parent = HealthBack
        local HealthText = Instance.new("TextLabel")
        HealthText.Name = "HealthText"
        HealthText.BackgroundTransparency = 1
        HealthText.Position = UDim2.new(0, 0, 1, -12)
        HealthText.Size = UDim2.new(1, 0, 0, 12)
        HealthText.Font = Enum.Font.GothamBold
        HealthText.TextSize = 9
        HealthText.TextColor3 = Color3.new(1, 1, 1)
        HealthText.TextStrokeTransparency = 0.3
        HealthText.Parent = Billboard
    end
    Billboard.Enabled = true  -- re-enable if the distance cull hid it earlier
    local Box = Billboard:FindFirstChild("Box")
    local HealthBack = Billboard:FindFirstChild("HealthBack")
    local HealthText = Billboard:FindFirstChild("HealthText")
    if Box then Box.Visible = BoxESPEnabled end
    if HealthBack then HealthBack.Visible = HealthESPEnabled end
    if HealthText then HealthText.Visible = HealthESPEnabled end
    if HealthESPEnabled and HealthBack and HealthText then
        local Ratio = math.clamp(H.Health / math.max(H.MaxHealth, 1), 0, 1)
        local Fill = HealthBack:FindFirstChild("HealthFill")
        if Fill then
            Fill.Size = UDim2.fromScale(1, Ratio)
            Fill.BackgroundColor3 =
                Color3.fromRGB(255, 60, 60):Lerp(Color3.fromRGB(70, 255, 100), Ratio)
        end
        HealthText.Text =
            Target.DisplayName .. "  " .. math.floor(H.Health) .. "/" .. math.floor(H.MaxHealth)
    end
end
local function SetPlayerESP()
    if ESPConnection then
        ESPConnection:Disconnect()
        ESPConnection = nil
    end
    if not BoxESPEnabled and not HealthESPEnabled then
        for _, Target in ipairs(Players:GetPlayers()) do
            RemoveESPFromCharacter(Target.Character)
        end
        return
    end
    local Accumulator = 0
    ESPConnection = RunService.Heartbeat:Connect(function(Delta)
        Accumulator += Delta
        if Accumulator < 0.20 then return end  -- 5 refreshes/sec is smooth and far lighter than 10
        Accumulator = 0
        local MyRoot = Root()
        local Origin = MyRoot and MyRoot.Position
        for _, Target in ipairs(Players:GetPlayers()) do
            -- Skip far players: their ESP isn't readable anyway and updating it wastes frames.
            local TargetRoot = Target ~= Player and Target.Character
                and Target.Character:FindFirstChild("HumanoidRootPart")
            if Origin and TargetRoot and (TargetRoot.Position - Origin).Magnitude > 800 then
                local Existing = TargetRoot:FindFirstChild("BananiESP")
                if Existing then Existing.Enabled = false end
            else
                UpdatePlayerESP(Target)
            end
        end
    end)
end
--==============================================================
-- SAFE CALLBACKS
--==============================================================
local function SafeFeatureCallback(Feature, Callback)
    return function(...)
        local Arguments = table.pack(...)
        local Success = xpcall(function()
            return Callback(table.unpack(Arguments, 1, Arguments.n))
        end, function(ErrorMessage)
            local Message = tostring(ErrorMessage)
            local Line = tonumber(Message:match(":(%d+):")) or tonumber(Message:match("line%s+(%d+)"))
            AddActionLog("Error", Message, tostring(Feature or "Unknown"), Line)
            Notify("Feature Error", tostring(Feature or "Unknown") .. " failed. Check the executor output.")
            return Message
        end)
        return Success
    end
end
local function ProtectTabCallbacks(Tab)
    if type(Tab) ~= "table" or Tab.__BananiProtected then return Tab end
    Tab.__BananiProtected = true
    for _, MethodName in ipairs({
        "CreateButton", "CreateToggle", "CreateSlider",
        "CreateDropdown", "CreateInput", "CreateKeybind", "CreateColorPicker"
    }) do
        local Original = Tab[MethodName]
        if type(Original) == "function" then
            Tab[MethodName] = function(Self, Options, ...)
                if type(Options) == "table" and type(Options.Callback) == "function" then
                    Options.Callback = SafeFeatureCallback(Options.Name or MethodName, Options.Callback)
                end
                return Original(Self, Options, ...)
            end
        end
    end
    return Tab
end
do
    local OriginalCreateTab = Window.CreateTab
    if type(OriginalCreateTab) == "function" then
        Window.CreateTab = function(Self, ...)
            return ProtectTabCallbacks(OriginalCreateTab(Self, ...))
        end
    end
end
--==============================================================
-- HOME TAB
--==============================================================
do
    local HomeTab = Window:CreateTab("🏠 Home", 4483362458)
    Dashboard = HomeTab:CreateParagraph({
        Title = "🍌 BANANIHUB • v" .. BANANIHUB_VERSION,
        Content = "Loading..."
    })
    HomeTab:CreateParagraph({
        Title = "✅ Release Status",
        Content = "Available • Interface refresh installed • Press " .. UIToggleKey.Name .. " to open or close"
    })
    local SessionStart = os.clock()
    local FrameCount = 0
    local LastFPSUpdate = os.clock()
    local CurrentFPS = 0
    TrackConnection(RunService.RenderStepped:Connect(function()
        FrameCount += 1
    end))
    do
        local Accumulator = 1
        StatusConnection = RunService.Heartbeat:Connect(function(Delta)
            Accumulator += Delta
            if Accumulator < 1 then return end
            Accumulator = 0
            local Now = os.clock()
            local Elapsed = math.max(Now - LastFPSUpdate, 0.001)
            CurrentFPS = math.floor(FrameCount / Elapsed)
            FrameCount = 0
            LastFPSUpdate = Now
            local H = Humanoid()
            local SessionSeconds = math.floor(Now - SessionStart)
            local Minutes = math.floor(SessionSeconds / 60)
            local Seconds = SessionSeconds % 60
            if Dashboard then
                Dashboard:Set({
                    Title = "🍌 BANANIHUB • v" .. BANANIHUB_VERSION,
                    Content =
                        "👤 Player: " .. Player.DisplayName
                        .. "\n❤️ HP: " .. HealthBar(H)
                        .. "\n🎞️ FPS: " .. tostring(CurrentFPS)
                        .. "\n📶 Ping: " .. GetPing()
                        .. "\n🧍 State: " .. CharacterState(H)
                        .. "\n👥 Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
                        .. "\n⏱️ Session: " .. string.format("%02d:%02d", Minutes, Seconds)
                })
            end
        end)
    end
    HomeTab:CreateSection("🎮 Experience")
    do
        local Success, Label = pcall(function()
            return HomeTab:CreateLabel(tostring(PlaceInfo.Name), GetExperienceThumbnail())
        end)
        if Success and Label then
            Runtime.HomeGameLabel = Label
        end
    end
    Runtime.HomeExperienceParagraph = HomeTab:CreateParagraph({
        Title = "Game Details",
        Content = "Creator: " .. tostring(PlaceInfo.Creator) .. "\nBananiHub Version: " .. BANANIHUB_VERSION
    })
    HomeTab:CreateButton({
        Name = "🔗 Copy Game Link",
        Callback = function()
            local JoinLink = "https://www.roblox.com/games/start?placeId=" .. tostring(game.PlaceId)
            local CurrentServerId = tostring(game.JobId or "")
            if CurrentServerId ~= "" then
                JoinLink = JoinLink .. "&gameInstanceId=" .. HttpService:UrlEncode(CurrentServerId)
            end
            Runtime.CopyValue("Current server link", JoinLink)
        end
    })
    ServerInformation = HomeTab:CreateParagraph({ Title = "🌐 Current Server", Content = "Loading..." })
    Runtime.RefreshServerInfo = function()
        if not ServerInformation then return end
        pcall(function()
            ServerInformation:Set({
                Title = "🌐 Current Server",
                Content =
                    "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
                    .. "\nPing: " .. GetPing()
                    .. "\nServer ID: " .. tostring(game.JobId)
                    .. "\nStatus: Connected"
            })
        end)
    end
    Runtime.RefreshServerInfo()
    do
        local Accumulator = 2
        ServerStatusConnection = RunService.Heartbeat:Connect(function(Delta)
            if Unloaded then return end
            Accumulator += Delta
            if Accumulator < 2 then return end
            Accumulator = 0
            Runtime.RefreshServerInfo()
        end)
    end
    RefreshExperienceParagraphs()
    HomeTab:CreateSection("⭐ Pinned Features")
    Runtime.HomeFavoritesParagraph = HomeTab:CreateParagraph({ Title = "⭐ Favorites", Content = "None selected" })
    Runtime.UpdatePreferenceDisplays()
    HomeTab:CreateSection("🌐 Server Browser")
    Runtime.ServerSelectionParagraph = HomeTab:CreateParagraph({
        Title = "Selected Server",
        Content = "Players: Unknown\nPing estimate: Unknown\nServer ID: Unknown\nStatus: Waiting"
    })
    HomeTab:CreateToggle({
        Name = "Avoid Current Server", CurrentValue = true, Flag = "Server_AvoidCurrent",
        Callback = function(Value) Runtime.AvoidCurrentServer = Value end
    })
    HomeTab:CreateToggle({
        Name = "Avoid Previously Visited Servers", CurrentValue = true, Flag = "Server_AvoidVisited",
        Callback = function(Value) Runtime.AvoidVisitedServers = Value end
    })
    HomeTab:CreateButton({
        Name = "🔄 Rejoin Current Server",
        Callback = function()
            if Runtime.ServerRequestBusy then
                Notify("Server", "A server action is already running.")
                return
            end
            Runtime.ServerRequestBusy = true
            task.spawn(function()
                local Success, ErrorMessage = pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
                end)
                Runtime.ServerRequestBusy = false
                if not Success then
                    Notify("Rejoin", "Teleport failed: " .. tostring(ErrorMessage))
                end
            end)
        end
    })
    HomeTab:CreateButton({
        Name = "🎲 Join Random Server",
        Callback = function()
            if Runtime.ServerHop then Runtime.ServerHop("Random") else Notify("Server", "Server tools are still loading.") end
        end
    })
    HomeTab:CreateButton({
        Name = "👤 Join Smallest Server",
        Callback = function()
            if Runtime.ServerHop then Runtime.ServerHop("Smallest") else Notify("Server", "Server tools are still loading.") end
        end
    })
    HomeTab:CreateButton({
        Name = "👥 Join Largest Available Server",
        Callback = function()
            if Runtime.ServerHop then Runtime.ServerHop("Largest") else Notify("Server", "Server tools are still loading.") end
        end
    })
    HomeTab:CreateSection("📜 What's New")
    HomeTab:CreateParagraph({
        Title = "v2.6 • Interface Refresh",
        Content =
            "• Added a clear Available release-status card to Home"
            .. "\n• Refreshed BananiHub branding and version display"
            .. "\n• Organized controls into clearer feature categories"
            .. "\n• Improved tab, section, button, and setting names"
            .. "\n• Cleaned the Home, Player, Travel, Visuals, Camera, Stats, Guide, and Settings layouts"
            .. "\n• Preserved existing flags, callbacks, configs, and feature behavior"
    })
    HomeTab:CreateParagraph({
        Title = "v2.5 • Previous Release",
        Content =
            "• Fixed Fly so it disables cleanly"
            .. "\n• Rebuilt saved waypoints and route controls"
            .. "\n• Added tween speed and route delay settings"
            .. "\n• Improved route playback and removed dead code"
    })
end
--==============================================================
-- PLAYER TAB
--==============================================================
do
    local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
    PlayerTab:CreateParagraph({
        Title = "👤 Player Controls",
        Content = "Character actions, movement modes, speed settings, jumping, and protection."
    })

    PlayerTab:CreateSection("🧍 Character Actions")
    PlayerTab:CreateButton({
        Name = "🔄 Respawn Character",
        Callback = function()
            local H = Humanoid()
            if H then H.Health = 0 end
        end
    })
    PlayerTab:CreateToggle({
        Name = "🧊 Freeze Position", Flag = "Player_Freeze", CurrentValue = false, Callback = SetFreeze
    })

    PlayerTab:CreateSection("✈️ Flight & Collision")
    PlayerTab:CreateToggle({
        Name = "✈️ Fly", Flag = "Player_Fly", CurrentValue = false,
        Callback = function(Value)
            if Value then StartFly() else StopFly() end
        end
    })
    PlayerTab:CreateSlider({
        Name = "Fly Speed", Flag = "Player_FlySpeed", Range = {10, 150}, Increment = 5, CurrentValue = 50,
        Callback = function(Value) FlySpeed = Value end
    })
    PlayerTab:CreateToggle({
        Name = "🚧 Noclip", Flag = "Player_Noclip", CurrentValue = false, Callback = SetNoclip
    })
    PlayerTab:CreateToggle({
        Name = "🕷️ Spider Climb", Flag = "Player_SpiderClimb", CurrentValue = false, Callback = SetSpiderClimb
    })

    PlayerTab:CreateSection("🏃 Speed & Jump")
    PlayerTab:CreateToggle({
        Name = "⚡ Fast Walk", Flag = "Player_FastWalk", CurrentValue = false,
        Callback = function(Value) FastWalkEnabled = Value UpdateMovement() end
    })
    PlayerTab:CreateSlider({
        Name = "Walk Speed", Flag = "Player_WalkSpeed", Range = {16, 100}, Increment = 1, CurrentValue = 16,
        Callback = function(Value) WalkSpeed = Value UpdateMovement() end
    })
    PlayerTab:CreateToggle({
        Name = "🦘 High Jump", Flag = "Player_HighJump", CurrentValue = false,
        Callback = function(Value) HighJumpEnabled = Value UpdateMovement() end
    })
    PlayerTab:CreateSlider({
        Name = "Jump Power", Flag = "Player_JumpPower", Range = {50, 150}, Increment = 5, CurrentValue = 50,
        Callback = function(Value) JumpPower = Value UpdateMovement() end
    })
    PlayerTab:CreateToggle({
        Name = "♾️ Infinite Jump", Flag = "Player_InfiniteJump", CurrentValue = false,
        Callback = function(Value) InfiniteJumpEnabled = Value end
    })
    PlayerTab:CreateToggle({
        Name = "🤸 Auto Jump", Flag = "Player_AutoJump", CurrentValue = false,
        Callback = function(Value) AutoJumpEnabled = Value end
    })

    PlayerTab:CreateSection("🛡️ Protection & Session")
    PlayerTab:CreateToggle({
        Name = "🕳️ Anti Void", Flag = "Player_AntiVoid", CurrentValue = false, Callback = SetAntiVoid
    })
    PlayerTab:CreateToggle({
        Name = "🧍 Anti Ragdoll", Flag = "Player_AntiRagdoll", CurrentValue = false, Callback = SetAntiRagdoll
    })
    PlayerTab:CreateToggle({
        Name = "🛡️ Anti-Fling", Flag = "Player_AntiFling", CurrentValue = false,
        Callback = function(Value) AntiFlingEnabled = Value end
    })
    PlayerTab:CreateToggle({
        Name = "💤 Anti-AFK", Flag = "Player_AntiAFK", CurrentValue = false,
        Callback = function(Value) AntiAFKEnabled = Value end
    })
end
--==============================================================
-- TELEPORT TOOL
--==============================================================
local TeleportToolName = "Banani Teleporter"
local function RemoveTeleportTool()
    local Backpack = Player:FindFirstChildOfClass("Backpack")
    local C = Character()
    local BackpackTool = Backpack and Backpack:FindFirstChild(TeleportToolName)
    local EquippedTool = C and C:FindFirstChild(TeleportToolName)
    if BackpackTool then BackpackTool:Destroy() end
    if EquippedTool then EquippedTool:Destroy() end
end
local function GiveTeleportTool()
    local Backpack = Player:FindFirstChildOfClass("Backpack")
    if not Backpack then
        Notify("Teleport Tool", "Your Backpack is not ready.")
        return
    end
    RemoveTeleportTool()
    local Tool = Instance.new("Tool")
    Tool.Name = TeleportToolName
    Tool.ToolTip = "Click anywhere to teleport"
    Tool.RequiresHandle = false
    Tool.CanBeDropped = false
    Tool.Parent = Backpack
    local Mouse = Player:GetMouse()
    local Cooldown = false
    Tool.Activated:Connect(function()
        if Cooldown then return end
        local R = Root()
        if not R or not Mouse.Hit then return end
        Cooldown = true
        R.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
        task.delay(0.25, function() Cooldown = false end)
    end)
    Notify("🍌 Teleport Tool", "Equip Banani Teleporter and click anywhere.")
end
--==============================================================
-- WAYPOINT ROUTE ENGINE
-- Play repeats the loop. Pause holds your spot. Stop resets to #1.
--==============================================================
Runtime.GetRouteRemoveOptions = function()
    local Options = {}
    for Index, Name in ipairs(Runtime.WaypointRoute) do
        table.insert(Options, tostring(Index) .. ". " .. Name)
    end
    return Options
end
Runtime.RefreshRouteDropdowns = function()
    if Runtime.RouteAddDropdown then
        Runtime.RouteAddDropdown:Refresh(GetWaypointNames())
    end
    if Runtime.RouteRemoveDropdown then
        Runtime.RouteRemoveDropdown:Refresh(Runtime.GetRouteRemoveOptions())
    end
end
Runtime.UpdateRouteUI = function()
    local Route = Runtime.WaypointRoute
    local Lines = {}
    for Index, Name in ipairs(Route) do
        local Marker = ""
        if Runtime.RouteRunning and Index == Runtime.RouteCurrentIndex then
            Marker = Runtime.RoutePaused and "  ← Paused here" or "  ← Current"
        end
        table.insert(Lines, tostring(Index) .. ". " .. tostring(Name) .. Marker)
    end
    if Runtime.RoutePreviewParagraph then
        Runtime.RoutePreviewParagraph:Set({
            Title = "Current Route (" .. tostring(#Route) .. (#Route == 1 and " Stop)" or " Stops)"),
            Content = #Lines > 0 and table.concat(Lines, "\n") or "No waypoints added yet."
        })
    end
    if Runtime.RouteStatusParagraph then
        local CheckpointText = #Route > 0
            and (tostring(math.clamp(Runtime.RouteCurrentIndex, 1, #Route)) .. " / " .. tostring(#Route))
            or "0 / 0"
        Runtime.RouteStatusParagraph:Set({
            Title = "Route Status",
            Content =
                "Status: " .. tostring(Runtime.RouteStatus)
                .. "\nMode: " .. (Runtime.RouteLoop and "Loop Route" or "Play Once")
                .. "\nWaypoint: " .. CheckpointText
                .. "\nTravel: " .. tostring(Runtime.RouteTravelMode)
                .. "\nTween Speed: " .. tostring(Runtime.TweenSpeed) .. " studs/s"
                .. "\nDelay: " .. tostring(Runtime.RouteDelay)
                .. (Runtime.RouteDelay == 1 and " Second" or " Seconds")
        })
    end
    Runtime.RefreshRouteDropdowns()
end
Runtime.StopWaypointRoute = function(Silent)
    CancelTween()
    Runtime.RouteRunId += 1
    Runtime.RouteRunning = false
    Runtime.RoutePaused = false
    Runtime.RouteStatus = "Idle"
    Runtime.RouteCurrentIndex = 1
    Runtime.UpdateRouteUI()
    if not Silent then
        Notify("Route", "Stopped. Next play starts from waypoint 1.")
    end
end
-- Pause / Resume toggle: one button flips between the two.
Runtime.TogglePauseRoute = function()
    if not Runtime.RouteRunning then
        Notify("Route", "The route is not running.")
        return
    end
    if Runtime.RoutePaused then
        Runtime.RoutePaused = false
        Runtime.RouteStatus = "Running"
        Runtime.UpdateRouteUI()
        Notify("Route", "Resumed from waypoint " .. tostring(Runtime.RouteCurrentIndex) .. ".")
    else
        Runtime.RoutePaused = true
        Runtime.RouteStatus = "Paused"
        CancelTween()
        Runtime.UpdateRouteUI()
        Notify("Route", "Paused at waypoint " .. tostring(Runtime.RouteCurrentIndex) .. ".")
    end
end
-- Starts the route. Loop=false runs once and stops at the end;
-- Loop=true repeats until you Stop. If already paused, this resumes.
Runtime.StartRoute = function(Loop)
    if #Runtime.WaypointRoute == 0 then
        Notify("Route", "Add at least one waypoint to the route first.")
        return
    end
    if Runtime.RouteRunning then
        if Runtime.RoutePaused then
            Runtime.RouteLoop = Loop == true
            Runtime.RoutePaused = false
            Runtime.RouteStatus = "Running"
            Runtime.UpdateRouteUI()
            Notify("Route", "Resumed from waypoint " .. tostring(Runtime.RouteCurrentIndex) .. ".")
        else
            Notify("Route", "Already running. Stop first to switch mode.")
        end
        return
    end
    Runtime.RouteLoop = Loop == true
    Runtime.RouteCurrentIndex = math.clamp(Runtime.RouteCurrentIndex, 1, #Runtime.WaypointRoute)
    Runtime.RouteRunId += 1
    local ThisRun = Runtime.RouteRunId
    Runtime.RouteRunning = true
    Runtime.RoutePaused = false
    Runtime.RouteStatus = Runtime.RouteLoop and "Looping" or "Running"
    Runtime.UpdateRouteUI()
    task.spawn(function()
        while Runtime.RouteRunning and Runtime.RouteRunId == ThisRun and not Unloaded do
            while Runtime.RoutePaused and Runtime.RouteRunning
                and Runtime.RouteRunId == ThisRun and not Unloaded do
                task.wait(0.05)
            end
            if not Runtime.RouteRunning or Runtime.RouteRunId ~= ThisRun or Unloaded then break end
            if Runtime.RouteCurrentIndex > #Runtime.WaypointRoute then
                if Runtime.RouteLoop then
                    Runtime.RouteCurrentIndex = 1
                else
                    -- Play Once finished: stop cleanly and reset to the start.
                    Runtime.RouteRunning = false
                    Runtime.RoutePaused = false
                    Runtime.RouteStatus = "Completed"
                    Runtime.RouteCurrentIndex = 1
                    Runtime.UpdateRouteUI()
                    Notify("Route", "Route finished.")
                    break
                end
            end
            local WaypointName = Runtime.WaypointRoute[Runtime.RouteCurrentIndex]
            local TargetCFrame = DecodeCFrame(Waypoints[WaypointName])
            local R = Root()
            if not TargetCFrame then
                Notify("Route", tostring(WaypointName) .. " is missing. Route stopped.")
                Runtime.StopWaypointRoute(true)
                break
            end
            if not R then
                Notify("Route", "Your character is unavailable. Route stopped.")
                Runtime.StopWaypointRoute(true)
                break
            end
            Runtime.UpdateRouteUI()
            if Runtime.RouteTravelMode == "Tween" then
                TweenRootTo(TargetCFrame)
            else
                R.CFrame = TargetCFrame
                R.AssemblyLinearVelocity = Vector3.zero
            end
            if not Runtime.RouteRunning or Runtime.RouteRunId ~= ThisRun or Unloaded then break end
            local Waited = 0
            while Waited < Runtime.RouteDelay and Runtime.RouteRunning
                and Runtime.RouteRunId == ThisRun and not Unloaded do
                if Runtime.RoutePaused then
                    task.wait(0.05)
                else
                    local Step = math.min(0.10, Runtime.RouteDelay - Waited)
                    task.wait(Step)
                    Waited += Step
                end
            end
            if Runtime.RouteRunning and Runtime.RouteRunId == ThisRun and not Runtime.RoutePaused then
                Runtime.RouteCurrentIndex += 1
            end
        end
    end)
end
-- Back-compat aliases.
Runtime.PlayWaypointRoute = function() Runtime.StartRoute(false) end
Runtime.PauseWaypointRoute = Runtime.TogglePauseRoute
--==============================================================
-- TELEPORT / WAYPOINTS TAB
--==============================================================
do
    local TeleportTab = Window:CreateTab("📍 Travel", 4483362458)
    TeleportTab:CreateParagraph({
        Title = "📍 Travel Tools",
        Content = "Quick travel, player selection, saved positions, waypoints, and route playback."
    })
    local WaypointName = ""
    local SelectedWaypoint = nil
    local SelectedDeleteWaypoint = nil
    -- ---------- Teleport Tool ----------
    TeleportTab:CreateSection("🖱️ Teleporter Tool")
    TeleportTab:CreateParagraph({
        Title = "Banani Teleporter",
        Content = "Adds a tool to your hotbar. Equip it and click anywhere to teleport."
    })
    TeleportTab:CreateButton({ Name = "🍌 Add Teleporter Tool", Callback = GiveTeleportTool })
    TeleportTab:CreateButton({ Name = "🗑️ Remove Teleporter Tool", Callback = RemoveTeleportTool })
    -- ---------- Player Teleport ----------
    TeleportTab:CreateSection("👥 Player Travel")
    local Names = GetDisplayNames()
    PlayerDropdown = TeleportTab:CreateDropdown({
        Name = "Select Player", Options = Names,
        CurrentOption = Names[1] and {Names[1]} or {}, SearchBarEnabled = true,
        Callback = function(Option) SelectedPlayer = type(Option) == "table" and Option[1] or Option end
    })
    TeleportTab:CreateButton({
        Name = "📍 Travel To Selected Player",
        Callback = function()
            local Target = SelectedPlayer and FindPlayerByDisplayName(SelectedPlayer)
            local TargetRoot = Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")
            local R = Root()
            if R and TargetRoot then
                R.CFrame = TargetRoot.CFrame + Vector3.new(0, 3, 0)
            else
                Notify("Teleport", "The selected player or character is unavailable.")
            end
        end
    })
    -- ---------- Quick Positions ----------
    TeleportTab:CreateSection("⚡ Quick Save")
    TeleportTab:CreateButton({
        Name = "💾 Save Temporary Position",
        Callback = function()
            local R = Root()
            if R then SavedPosition = R.CFrame Notify("📍 Position Saved", "Temporary position saved.") end
        end
    })
    TeleportTab:CreateButton({
        Name = "📍 Return To Temporary Position",
        Callback = function()
            local R = Root()
            if R and SavedPosition then R.CFrame = SavedPosition end
        end
    })
    -- ---------- Named Waypoints ----------
    TeleportTab:CreateSection("🗂️ Saved Waypoints")
    TeleportTab:CreateParagraph({
        Title = "Save & Travel",
        Content = "Name a spot and save it. Then teleport instantly or tween smoothly to any saved waypoint. Waypoints keep the order you saved them."
    })
    TeleportTab:CreateInput({
        Name = "Waypoint Name", PlaceholderText = "Example: Shop", RemoveTextAfterFocusLost = false,
        Callback = function(Text) WaypointName = Text end
    })
    TeleportTab:CreateButton({
        Name = "➕ Save Waypoint",
        Callback = function()
            local R = Root()
            local CleanName = tostring(WaypointName):match("^%s*(.-)%s*$")
            if not R or CleanName == "" then
                Notify("Waypoint", "Enter a waypoint name first.")
                return
            end
            local IsNew = Waypoints[CleanName] == nil
            Waypoints[CleanName] = EncodeCFrame(R.CFrame)
            if IsNew then table.insert(Runtime.WaypointOrder, CleanName) end
            SaveWaypoints()
            RefreshWaypoints()
            Runtime.UpdatePreferenceDisplays()
            Notify("Waypoint Saved", IsNew and (CleanName .. " added.") or (CleanName .. " updated."))
        end
    })
    WaypointDropdown = TeleportTab:CreateDropdown({
        Name = "Select Waypoint", Options = GetWaypointNames(),
        CurrentOption = {}, SearchBarEnabled = true,
        Callback = function(Option) SelectedWaypoint = type(Option) == "table" and Option[1] or Option end
    })
    TeleportTab:CreateButton({
        Name = "⚡ Travel To Waypoint",
        Callback = function()
            local CF = SelectedWaypoint and DecodeCFrame(Waypoints[SelectedWaypoint])
            local R = Root()
            if R and CF then
                R.CFrame = CF
                R.AssemblyLinearVelocity = Vector3.zero
            else
                Notify("Waypoint", "Select a valid saved waypoint first.")
            end
        end
    })
    TeleportTab:CreateButton({
        Name = "🎯 Smooth Travel To Waypoint",
        Callback = function()
            local CF = SelectedWaypoint and DecodeCFrame(Waypoints[SelectedWaypoint])
            if not CF then
                Notify("Waypoint", "Select a valid saved waypoint first.")
                return
            end
            task.spawn(function()
                Notify("Waypoint", "Tweening to " .. tostring(SelectedWaypoint))
                TweenRootTo(CF)
            end)
        end
    })
    DeleteWaypointDropdown = TeleportTab:CreateDropdown({
        Name = "Delete Waypoint", Options = GetWaypointNames(),
        CurrentOption = {}, SearchBarEnabled = true,
        Callback = function(Option) SelectedDeleteWaypoint = type(Option) == "table" and Option[1] or Option end
    })
    TeleportTab:CreateButton({
        Name = "🗑️ Delete Selected Waypoint",
        Callback = function()
            if not SelectedDeleteWaypoint or not Waypoints[SelectedDeleteWaypoint] then
                Notify("Waypoint", "Select a waypoint to delete first.")
                return
            end
            local Deleted = SelectedDeleteWaypoint
            Waypoints[Deleted] = nil
            SelectedDeleteWaypoint = nil
            for Index = #Runtime.WaypointOrder, 1, -1 do
                if Runtime.WaypointOrder[Index] == Deleted then
                    table.remove(Runtime.WaypointOrder, Index)
                end
            end
            for Index = #Runtime.WaypointRoute, 1, -1 do
                if Runtime.WaypointRoute[Index] == Deleted then
                    table.remove(Runtime.WaypointRoute, Index)
                end
            end
            Runtime.RouteCurrentIndex = math.clamp(Runtime.RouteCurrentIndex, 1, math.max(#Runtime.WaypointRoute, 1))
            SaveWaypoints()
            RefreshWaypoints()
            Runtime.UpdatePreferenceDisplays()
            Notify("Waypoint Deleted", Deleted)
        end
    })
    -- ---------- Route Builder ----------
    TeleportTab:CreateSection("🧭 Route Builder")
    TeleportTab:CreateParagraph({
        Title = "Build Your Route",
        Content = "Add saved waypoints one at a time — the route follows the exact order you add them. Duplicates are blocked."
    })
    Runtime.RoutePreviewParagraph = TeleportTab:CreateParagraph({
        Title = "Current Route (0 Stops)", Content = "No waypoints added yet."
    })
    Runtime.RouteAddDropdown = TeleportTab:CreateDropdown({
        Name = "Add Waypoint To Route", Options = GetWaypointNames(),
        CurrentOption = {}, SearchBarEnabled = true,
        Callback = function(Option)
            local Name = type(Option) == "table" and Option[1] or Option
            if not Name or not Waypoints[Name] then return end
            for _, ExistingName in ipairs(Runtime.WaypointRoute) do
                if ExistingName == Name then
                    Notify("Route", Name .. " is already in the route.")
                    return
                end
            end
            table.insert(Runtime.WaypointRoute, Name)
            Runtime.UpdateRouteUI()
            Notify("Route", "Added " .. tostring(#Runtime.WaypointRoute) .. ". " .. Name)
        end
    })
    Runtime.RouteRemoveDropdown = TeleportTab:CreateDropdown({
        Name = "Remove Waypoint From Route", Options = Runtime.GetRouteRemoveOptions(),
        CurrentOption = {}, SearchBarEnabled = true,
        Callback = function(Option) Runtime.RouteSelectedCheckpoint = type(Option) == "table" and Option[1] or Option end
    })
    TeleportTab:CreateButton({
        Name = "❌ Remove Selected From Route",
        Callback = function()
            local Selected = Runtime.RouteSelectedCheckpoint
            local RemoveIndex = tonumber(tostring(Selected or ""):match("^(%d+)%."))
            if not RemoveIndex or not Runtime.WaypointRoute[RemoveIndex] then
                Notify("Route", "Select a waypoint to remove.")
                return
            end
            local RemovedName = table.remove(Runtime.WaypointRoute, RemoveIndex)
            if RemoveIndex < Runtime.RouteCurrentIndex then
                Runtime.RouteCurrentIndex -= 1
            end
            Runtime.RouteCurrentIndex = math.clamp(Runtime.RouteCurrentIndex, 1, math.max(#Runtime.WaypointRoute, 1))
            Runtime.RouteSelectedCheckpoint = nil
            if #Runtime.WaypointRoute == 0 then
                Runtime.StopWaypointRoute(true)
            else
                Runtime.UpdateRouteUI()
            end
            Notify("Route", "Removed " .. tostring(RemovedName))
        end
    })
    TeleportTab:CreateButton({
        Name = "🗑 Clear Whole Route",
        Callback = function()
            Runtime.StopWaypointRoute(true)
            table.clear(Runtime.WaypointRoute)
            Runtime.RouteSelectedCheckpoint = nil
            Runtime.UpdateRouteUI()
            Notify("Route", "Route cleared.")
        end
    })
    -- ---------- Route Controls ----------
    TeleportTab:CreateSection("▶️ Route Playback")
    TeleportTab:CreateDropdown({
        Name = "Travel Mode", Options = {"Teleport", "Tween"},
        CurrentOption = {"Teleport"}, Flag = "Route_TravelMode",
        Callback = function(Option)
            Runtime.RouteTravelMode = type(Option) == "table" and Option[1] or Option
            Runtime.UpdateRouteUI()
        end
    })
    TeleportTab:CreateSlider({
        Name = "Tween Speed", Flag = "Route_TweenSpeed", Range = {20, 400}, Increment = 10, CurrentValue = 80,
        Callback = function(Value)
            Runtime.TweenSpeed = Value
            Runtime.UpdateRouteUI()
        end
    })
    TeleportTab:CreateDropdown({
        Name = "Delay Between Waypoints",
        Options = {"0.5 Seconds", "1 Second", "2 Seconds", "3 Seconds", "4 Seconds", "5 Seconds",
            "6 Seconds", "7 Seconds", "8 Seconds", "9 Seconds", "10 Seconds"},
        CurrentOption = {"0.5 Seconds"}, Flag = "Route_Delay",
        Callback = function(Option)
            local Text = type(Option) == "table" and Option[1] or Option
            Runtime.RouteDelay = math.clamp(tonumber(tostring(Text):match("[%d%.]+")) or 0.5, 0.5, 10)
            Runtime.UpdateRouteUI()
        end
    })
    Runtime.RouteStatusParagraph = TeleportTab:CreateParagraph({
        Title = "Route Status",
        Content = "Status: Idle\nMode: Play Once\nWaypoint: 0 / 0\nTravel: Teleport\nTween Speed: 80 studs/s\nDelay: 0.5 Seconds"
    })
    TeleportTab:CreateButton({ Name = "▶ Play Once", Callback = function() Runtime.StartRoute(false) end })
    TeleportTab:CreateButton({ Name = "🔁 Loop Route", Callback = function() Runtime.StartRoute(true) end })
    TeleportTab:CreateButton({ Name = "⏸ Pause / Resume", Callback = Runtime.TogglePauseRoute })
    TeleportTab:CreateButton({
        Name = "⏹ Stop (reset to waypoint 1)",
        Callback = function() Runtime.StopWaypointRoute(false) end
    })
    Runtime.UpdateRouteUI()
end
--==============================================================
-- VISUALS TAB
--==============================================================
do
    local VisualsTab = Window:CreateTab("👁️ Visuals", 4483362458)
    VisualsTab:CreateParagraph({ Title = "👁️ Visuals & Performance", Content = "Lighting, highlights, ESP, and performance controls." })
    VisualsTab:CreateSection("🌗 Lighting")
    VisualsTab:CreateToggle({ Name = "🌙 Fullbright", Flag = "Visuals_Fullbright", CurrentValue = false, Callback = SetFullbright })
    VisualsTab:CreateToggle({
        Name = "☀️ Set Daytime", CurrentValue = false,
        Callback = function(Value) if Value then Lighting.ClockTime = 14 end end
    })
    VisualsTab:CreateToggle({
        Name = "🌙 Set Midnight", CurrentValue = false,
        Callback = function(Value) if Value then Lighting.ClockTime = 0 end end
    })
    VisualsTab:CreateSlider({
        Name = "💡 World Brightness", Flag = "Visuals_Brightness", Range = {0, 10}, Increment = 0.5,
        CurrentValue = Lighting.Brightness, Callback = function(Value) Lighting.Brightness = Value end
    })
    VisualsTab:CreateToggle({
        Name = "🌫️ Fog Enabled", Flag = "Visuals_Fog", CurrentValue = true,
        Callback = function(Value) Lighting.FogEnd = Value and 1000 or 100000 end
    })
    VisualsTab:CreateSection("⚙️ Performance")
    VisualsTab:CreateToggle({ Name = "⚙️ Performance Mode", Flag = "Visuals_LowGraphics", CurrentValue = false, Callback = SetLowGraphics })
    VisualsTab:CreateSection("✨ Highlights")
    VisualsTab:CreateToggle({
        Name = "✨ Player Highlights", Flag = "Visuals_PlayerChams", CurrentValue = false,
        Callback = function(Value)
            SetChams(Value)
            if Value and not ChamsSettingsCreated then
                ChamsSettingsCreated = true
                task.defer(function()
                    VisualsTab:CreateSection("🎨 Highlight Settings")
                    VisualsTab:CreateToggle({
                        Name = "🎨 Use Team Colors", Flag = "Visuals_ChamsTeamColors", CurrentValue = false,
                        Callback = function(Enabled) ChamsTeamColorsEnabled = Enabled end
                    })
                    VisualsTab:CreateColorPicker({
                        Name = "Fill Color", Flag = "Visuals_ChamsFillColor", Color = ChamsFillColor,
                        Callback = function(Color) ChamsFillColor = Color end
                    })
                    VisualsTab:CreateColorPicker({
                        Name = "Outline Color", Flag = "Visuals_ChamsOutlineColor", Color = ChamsOutlineColor,
                        Callback = function(Color) ChamsOutlineColor = Color end
                    })
                    VisualsTab:CreateSlider({
                        Name = "Fill Transparency", Flag = "Visuals_ChamsFillTransparency", Range = {0, 1}, Increment = 0.05, CurrentValue = 0.5,
                        Callback = function(Transparency) ChamsFillTransparency = Transparency end
                    })
                    VisualsTab:CreateSlider({
                        Name = "Outline Transparency", Flag = "Visuals_ChamsOutlineTransparency", Range = {0, 1}, Increment = 0.05, CurrentValue = 0,
                        Callback = function(Transparency) ChamsOutlineTransparency = Transparency end
                    })
                    Notify("Player Chams", "Chams settings opened below.")
                end)
            end
        end
    })
    VisualsTab:CreateToggle({ Name = "NPC Highlights", Flag = "Visuals_NPCChams", CurrentValue = false, Callback = SetNPCChams })
    VisualsTab:CreateToggle({ Name = "📦 Hitbox Outline", Flag = "Visuals_Hitboxes", CurrentValue = false, Callback = SetHitboxes })
    VisualsTab:CreateSection("🎯 Player Overlays")
    VisualsTab:CreateToggle({
        Name = "Box ESP", Flag = "Visuals_BoxESP", CurrentValue = false,
        Callback = function(Value) BoxESPEnabled = Value SetPlayerESP() end
    })
    VisualsTab:CreateToggle({
        Name = "Health ESP", Flag = "Visuals_HealthESP", CurrentValue = false,
        Callback = function(Value) HealthESPEnabled = Value SetPlayerESP() end
    })
end
--==============================================================
-- SPECTATOR / CAMERA TAB
--==============================================================
do
    local SpectatorTab = Window:CreateTab("🎥 Camera", 4483362458)
    SpectatorTab:CreateParagraph({ Title = "🎥 Camera & Spectator", Content = "Freecam, camera settings, saved positions, and spectating." })
    SpectatorTab:CreateSection("🎛️ Camera Settings")
    SpectatorTab:CreateSlider({
        Name = "Field of View", Flag = "Camera_FOV", Range = {40, 120}, Increment = 1,
        CurrentValue = math.floor(Camera.FieldOfView),
        Callback = function(Value)
            FreecamOriginalFOV = Value
            if not FreecamCinematicEnabled then Camera.FieldOfView = Value end
        end
    })
    SpectatorTab:CreateToggle({ Name = "Camera Shake Enabled", Flag = "Camera_Shake", CurrentValue = false, Callback = SetCameraShake })
    SpectatorTab:CreateSlider({
        Name = "Camera Shake Strength", Flag = "Camera_ShakeStrength", Range = {0.05, 1}, Increment = 0.05,
        CurrentValue = CameraShakeStrength, Callback = function(Value) CameraShakeStrength = Value end
    })
    SpectatorTab:CreateSection("🎥 Freecam Controls")
    SpectatorTab:CreateParagraph({
        Title = "Freecam Controls",
        Content = "WASD = move\nQ/E = down/up\nHold right-click and move the mouse to look\nMouse wheel = adjust speed"
    })
    SpectatorTab:CreateToggle({
        Name = "🎥 Freecam", Flag = "Freecam_Enabled", CurrentValue = false,
        Callback = function(Value) if Value then StartFreecam() else StopFreecam() end end
    })
    SpectatorTab:CreateSlider({
        Name = "Freecam Speed", Flag = "Freecam_Speed", Range = {5, 250}, Increment = 5, CurrentValue = 50,
        Callback = function(Value) FreecamSpeed = Value end
    })
    SpectatorTab:CreateSlider({
        Name = "Scroll Wheel Step", Flag = "Freecam_ScrollStep", Range = {1, 25}, Increment = 1, CurrentValue = 5,
        Callback = function(Value) FreecamScrollStep = Value end
    })
    SpectatorTab:CreateToggle({
        Name = "Smooth Movement", Flag = "Freecam_Smooth", CurrentValue = false,
        Callback = function(Value) FreecamSmoothEnabled = Value end
    })
    SpectatorTab:CreateSlider({
        Name = "Smoothness", Flag = "Freecam_Smoothness", Range = {0.02, 0.5}, Increment = 0.01, CurrentValue = 0.18,
        Callback = function(Value) FreecamSmoothness = Value end
    })
    SpectatorTab:CreateToggle({
        Name = "Cinematic Mode", Flag = "Freecam_Cinematic", CurrentValue = false,
        Callback = function(Value)
            FreecamCinematicEnabled = Value
            if FreecamEnabled then Camera.FieldOfView = Value and 50 or FreecamOriginalFOV end
        end
    })
    SpectatorTab:CreateSection("📌 Saved Camera Position")
    SpectatorTab:CreateButton({ Name = "💾 Save Camera Position", Callback = SaveFreecamPosition })
    SpectatorTab:CreateButton({ Name = "↩️ Return To Saved Camera", Callback = ReturnToSavedFreecamPosition })
    SpectatorTab:CreateSection("👤 Spectate Target")
    SpectatorDropdown = SpectatorTab:CreateDropdown({
        Name = "Search or Select Player", Options = GetDisplayNames(),
        CurrentOption = {}, SearchBarEnabled = true,
        Callback = function(Option)
            local Name = type(Option) == "table" and Option[1] or Option
            local Target = FindPlayerByDisplayName(Name)
            if Target then
                SpectatorTarget = Target
                if SpectatorInfo and not Spectating then
                    SpectatorInfo:Set({
                        Title = "Spectator",
                        Content = "Selected: " .. Target.DisplayName .. " (@" .. Target.Name .. ")"
                    })
                end
            end
        end
    })
    SpectatorTab:CreateSection("👀 Spectate Controls")
    SpectatorTab:CreateToggle({
        Name = "👀 Spectate", Flag = "Spectator_Enabled", CurrentValue = false,
        Callback = function(Value) if Value then StartSpectating(SpectatorTarget) else StopSpectating() end end
    })
    SpectatorTab:CreateButton({ Name = "⬅️ Previous Player", Callback = function() SwitchSpectator(-1) end })
    SpectatorTab:CreateButton({ Name = "➡️ Next Player", Callback = function() SwitchSpectator(1) end })
    SpectatorTab:CreateSection("📊 Target Status")
    SpectatorInfo = SpectatorTab:CreateParagraph({ Title = "Spectator", Content = "Select a player above." })
end
--==============================================================
-- STATS TAB
--==============================================================
do
    local function GetPlayerStats(Target)
        local Lines = {}
        local SeenNames = {}
        local function ReadContainer(Container)
            if not Container then return end
            for _, Stat in ipairs(Container:GetChildren()) do
                if Stat:IsA("ValueBase") and not SeenNames[Stat.Name] then
                    SeenNames[Stat.Name] = true
                    table.insert(Lines, Stat.Name .. ": " .. tostring(Stat.Value))
                end
            end
        end
        ReadContainer(Target:FindFirstChild("leaderstats"))
        ReadContainer(Target:FindFirstChild("Stats"))
        ReadContainer(Target:FindFirstChild("Data"))
        ReadContainer(Target:FindFirstChild("PlayerData"))
        if #Lines == 0 then return "No public currency or stats found." end
        table.sort(Lines)
        return table.concat(Lines, "\n")
    end
    local function GetToolSummary(Target)
        local Names = {}
        local Seen = {}
        local function ReadTools(Container)
            if not Container then return end
            for _, Object in ipairs(Container:GetChildren()) do
                if Object:IsA("Tool") and not Seen[Object.Name] then
                    Seen[Object.Name] = true
                    table.insert(Names, Object.Name)
                end
            end
        end
        ReadTools(Target.Character)
        ReadTools(Target:FindFirstChildOfClass("Backpack"))
        table.sort(Names)
        if #Names == 0 then return "None" end
        if #Names > 8 then
            local HiddenCount = #Names - 8
            while #Names > 8 do table.remove(Names) end
            return table.concat(Names, ", ") .. " +" .. HiddenCount .. " more"
        end
        return table.concat(Names, ", ")
    end
    local function GetAvatarThumbnail(Target)
        if not Target then return nil end
        local Cached = Runtime.AvatarThumbnailCache[Target.UserId]
        if Cached then return Cached end
        local Success, Thumbnail = pcall(function()
            return Players:GetUserThumbnailAsync(Target.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        end)
        if Success and type(Thumbnail) == "string" then
            Runtime.AvatarThumbnailCache[Target.UserId] = Thumbnail
            return Thumbnail
        end
        return nil
    end
    local function StatsOptionLabel(Target)
        return Target.DisplayName .. " (@" .. Target.Name .. ")"
    end
    local BuildSuccess, BuildError = pcall(function()
        local StatsTab = Window:CreateTab("📊 Stats", 4483362458)
        StatsTab:CreateParagraph({ Title = "📊 Player Stats", Content = "Select a player to view profile, character, tools, distance, and leaderstats." })
        StatsTab:CreateSection("🔎 Player Search")
        Runtime.StatsPlayerMap = {}
        Runtime.RefreshStatsPlayers = function()
            local Options = {}
            local SelfLabel = StatsOptionLabel(Player)
            Runtime.StatsPlayerMap = {}
            for _, Target in ipairs(Players:GetPlayers()) do
                local Label = StatsOptionLabel(Target)
                Runtime.StatsPlayerMap[Label] = Target
                table.insert(Options, Label)
            end
            table.sort(Options, function(A, B) return string.lower(A) < string.lower(B) end)
            local SelfIndex = table.find(Options, SelfLabel)
            if SelfIndex and SelfIndex ~= 1 then
                table.remove(Options, SelfIndex)
                table.insert(Options, 1, SelfLabel)
            end
            if StatsPlayerDropdown then StatsPlayerDropdown:Refresh(Options) end
            return Options
        end
        local StatsOptions = Runtime.RefreshStatsPlayers()
        StatsPlayerDropdown = StatsTab:CreateDropdown({
            Name = "Search or Select Player", Options = StatsOptions,
            CurrentOption = {StatsOptionLabel(Player)}, SearchBarEnabled = true, Flag = "Stats_SelectedPlayer",
            Callback = function(Option)
                local Label = type(Option) == "table" and Option[1] or Option
                local Target = Runtime.StatsPlayerMap and Runtime.StatsPlayerMap[Label]
                if Target then
                    SelectedStatsPlayer = Target
                    Runtime.LastStatsUserId = nil
                    if Runtime.RefreshStats then Runtime.RefreshStats(true) end
                end
            end
        })
        StatsTab:CreateSection("📋 Live Profile")
        StatsAvatarLabel = StatsTab:CreateLabel("Avatar: " .. Player.DisplayName)
        StatsInformation = StatsTab:CreateParagraph({ Title = "Player Stats", Content = "Loading..." })
        Runtime.RefreshStats = function(RefreshAvatar)
            local Target = SelectedStatsPlayer
            if not Target or not Target.Parent then
                SelectedStatsPlayer = Player
                Target = Player
                Runtime.LastStatsUserId = nil
            end
            local TargetCharacter = Target.Character
            local H = TargetCharacter and TargetCharacter:FindFirstChildOfClass("Humanoid")
            local TargetRoot = TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart")
            local MyRoot = Root()
            local Health = H and (math.floor(H.Health) .. "/" .. math.floor(H.MaxHealth)) or "N/A"
            local Distance = MyRoot and TargetRoot
                and (math.floor((MyRoot.Position - TargetRoot.Position).Magnitude) .. " studs") or "N/A"
            local State = H and CharacterState(H) or "N/A"
            local EquippedTool = TargetCharacter and TargetCharacter:FindFirstChildOfClass("Tool")
            local TeamName = Target.Team and Target.Team.Name or "None"
            if StatsInformation then
                pcall(function()
                    StatsInformation:Set({
                        Title = "📊 " .. Target.DisplayName .. " (@" .. Target.Name .. ")",
                        Content =
                            "User ID: " .. tostring(Target.UserId)
                            .. "\nAccount Age: " .. tostring(Target.AccountAge) .. " days"
                            .. "\nTeam: " .. TeamName
                            .. "\nHealth: " .. Health
                            .. "\nState: " .. State
                            .. "\nDistance: " .. Distance
                            .. "\nEquipped Tool: " .. (EquippedTool and EquippedTool.Name or "None")
                            .. "\nBackpack / Tools: " .. GetToolSummary(Target)
                            .. "\n\n💰 Public Stats\n" .. GetPlayerStats(Target)
                    })
                end)
            end
            if RefreshAvatar or Runtime.LastStatsUserId ~= Target.UserId then
                Runtime.LastStatsUserId = Target.UserId
                local RequestedUserId = Target.UserId
                if StatsAvatarLabel then
                    pcall(function() StatsAvatarLabel:Set("Avatar: " .. Target.DisplayName) end)
                end
                task.spawn(function()
                    local Thumbnail = GetAvatarThumbnail(Target)
                    if Unloaded or not Thumbnail or not SelectedStatsPlayer
                        or SelectedStatsPlayer.UserId ~= RequestedUserId then
                        return
                    end
                    if StatsAvatarLabel then
                        pcall(function() StatsAvatarLabel:Set("Avatar: " .. Target.DisplayName, Thumbnail) end)
                    end
                end)
            end
        end
        StatsTab:CreateButton({
            Name = "🔄 Refresh Selected Player",
            Callback = function()
                Runtime.RefreshStatsPlayers()
                Runtime.RefreshStats(true)
            end
        })
        do
            local Accumulator = 2
            StatsStatusConnection = RunService.Heartbeat:Connect(function(Delta)
                if Unloaded then return end
                Accumulator += Delta
                if Accumulator < 2 then return end  -- leaderstat/tool scan is heavy; 2s is plenty
                Accumulator = 0
                Runtime.RefreshStats(false)
            end)
        end
        Runtime.RefreshStats(true)
    end)
    if not BuildSuccess then
        warn("BANANIHUB | Stats tab failed: " .. tostring(BuildError))
    end
end
--==============================================================
-- SERVER HOP
--==============================================================
do
    local function GetPublicServers()
        local URL = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local RequestSuccess, Result = pcall(function() return game:HttpGet(URL, true) end)
        if not RequestSuccess then return nil, tostring(Result) end
        local DecodeSuccess, Data = pcall(function() return HttpService:JSONDecode(Result) end)
        if not DecodeSuccess or type(Data) ~= "table" or type(Data.data) ~= "table" then
            return nil, "The public server response was invalid."
        end
        return Data.data, nil
    end
    Runtime.ServerHop = function(Mode)
        if Runtime.ServerRequestBusy then
            Notify("Server", "A server action is already running.")
            return
        end
        Runtime.ServerRequestBusy = true
        Notify("Server", "Searching for an available server...")
        task.spawn(function()
            local Success, Failure = pcall(function()
                local Servers, FetchError = GetPublicServers()
                if not Servers then error(FetchError or "Could not load the public server list.") end
                local Available = {}
                for _, Server in ipairs(Servers) do
                    local ServerId = tostring(Server.id or "")
                    local Playing = tonumber(Server.playing) or 0
                    local Capacity = tonumber(Server.maxPlayers) or 0
                    local IsCurrent = ServerId == tostring(game.JobId)
                    local WasVisited = Runtime.VisitedServers[ServerId] == true
                    if ServerId ~= "" and Playing < Capacity
                        and (not Runtime.AvoidCurrentServer or not IsCurrent)
                        and (not Runtime.AvoidVisitedServers or not WasVisited) then
                        table.insert(Available, Server)
                    end
                end
                if #Available == 0 then error("No available servers matched the selected filters.") end
                if Mode == "Smallest" then
                    table.sort(Available, function(A, B) return (tonumber(A.playing) or 0) < (tonumber(B.playing) or 0) end)
                elseif Mode == "Largest" then
                    table.sort(Available, function(A, B) return (tonumber(A.playing) or 0) > (tonumber(B.playing) or 0) end)
                else
                    local RandomIndex = math.random(1, #Available)
                    Available[1], Available[RandomIndex] = Available[RandomIndex], Available[1]
                end
                local SelectedServer = Available[1]
                local ServerId = tostring(SelectedServer.id)
                local Playing = tonumber(SelectedServer.playing) or 0
                local Capacity = tonumber(SelectedServer.maxPlayers) or 0
                Runtime.VisitedServers[ServerId] = true
                if Runtime.ServerSelectionParagraph then
                    Runtime.ServerSelectionParagraph:Set({
                        Title = "Selected Server",
                        Content = "Players: " .. Playing .. "/" .. Capacity
                            .. "\nPing estimate: Unknown\nServer ID: " .. ServerId .. "\nStatus: Available"
                    })
                end
                task.wait(0.35)
                TeleportService:TeleportToPlaceInstance(game.PlaceId, ServerId, Player)
            end)
            Runtime.ServerRequestBusy = false
            if not Success then
                Notify("Server Hop", "Failed: " .. tostring(Failure))
            end
        end)
    end
end
--==============================================================
-- BANANI AI / HELP TAB
--==============================================================
do
    local HelpTab = Window:CreateTab("❓ Guide", 4483362458)
    HelpTab:CreateParagraph({
        Title = "❓ BananiHub Guide",
        Content = "Select a feature to see what it does and which category contains it."
    })
    local HelpTopics = {
        ["Fly"] = "Enable Fly in Player > Flight & Collision. WASD to move, Space up, Left Control down. Toggling off zeroes your velocity so you stop instantly.",
        ["Noclip"] = "Noclip lets your character pass through collidable parts while enabled.",
        ["Spider Climb"] = "Face a wall and hold W to climb upward.",
        ["Saved Waypoints"] = "Open Travel > Saved Waypoints. Name a spot, save it, then Teleport or Tween to any saved waypoint.",
        ["Route Builder"] = "Add saved waypoints to a route in the order you want. Pick Teleport or Tween, set tween speed and a 0.5-10s delay (default 0.5s), then use the playback buttons.",
        ["Route Play"] = "Play Once runs the route a single time and stops at the end. Loop Route repeats until you Stop. Pause / Resume holds at your current waypoint and continues from there. Stop halts and resets to waypoint 1.",
        ["Freecam"] = "Open Camera > Freecam Controls. WASD to move, Q/E down/up, hold right-click to look.",
        ["Box ESP"] = "Draws a box around visible player characters.",
        ["Health ESP"] = "Shows a health bar and number near visible player characters.",
        ["Performance Mode"] = "Visuals > Performance. Disables particles, post-processing, shadows, and complex materials. Turning it off restores visuals."
    }
    local Order = {"Fly", "Noclip", "Spider Climb", "Saved Waypoints", "Route Builder", "Route Play", "Freecam", "Box ESP", "Health ESP", "Performance Mode"}
    HelpTab:CreateDropdown({
        Name = "Select a Feature", Options = Order, CurrentOption = {"Route Builder"}, SearchBarEnabled = true,
        Callback = function(Option)
            local Topic = type(Option) == "table" and Option[1] or Option
            if HelpInformation then
                HelpInformation:Set({ Title = "❓ " .. Topic, Content = HelpTopics[Topic] or "No explanation is available." })
            end
        end
    })
    HelpInformation = HelpTab:CreateParagraph({ Title = "❓ Route Builder", Content = HelpTopics["Route Builder"] })
end
--==============================================================
-- MASTER RESET / UNLOAD
--==============================================================
local function MasterReset()
    pcall(StopFly)
    pcall(StopFreecam)
    pcall(StopSpectating)
    pcall(function() SetCameraShake(false) end)
    pcall(function() SetChams(false) end)
    pcall(function() SetNPCChams(false) end)
    pcall(function() SetHitboxes(false) end)
    pcall(function() SetLowGraphics(false) end)
    pcall(function() SetFullbright(false) end)
    pcall(function() SetAntiVoid(false) end)
    pcall(function() SetAntiRagdoll(false) end)
    pcall(function() SetSpiderClimb(false) end)
    pcall(function() SetNoclip(false) end)
    BoxESPEnabled = false
    HealthESPEnabled = false
    AutoJumpEnabled = false
    InfiniteJumpEnabled = false
    AntiFlingEnabled = false
    AntiAFKEnabled = false
    pcall(function() SetFreeze(false) end)
    FastWalkEnabled = false
    HighJumpEnabled = false
    pcall(SetPlayerESP)
    pcall(RemoveTeleportTool)
    if Runtime.StopWaypointRoute then
        pcall(function() Runtime.StopWaypointRoute(true) end)
    end
    pcall(UpdateMovement)
    pcall(function() SetCharacterLocked(false) end)
    Camera.CameraType = Enum.CameraType.Custom
    Camera.FieldOfView = FreecamOriginalFOV
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    local H = Humanoid()
    if H then Camera.CameraSubject = H end
    if Rayfield.Flags then
        for FlagName, Flag in pairs(Rayfield.Flags) do
            if Flag and Flag.Set then
                if string.find(FlagName, "Enabled") or string.find(FlagName, "Fly")
                    or string.find(FlagName, "Noclip") or string.find(FlagName, "ESP")
                    or string.find(FlagName, "Chams") or string.find(FlagName, "Performance") then
                    pcall(function() Flag:Set(false) end)
                end
            end
        end
    end
    Notify("Master Reset", "All active features were reset.")
end
local function UnloadBananiHub()
    if Unloaded then return end
    Unloaded = true
    pcall(StopFly)
    pcall(StopFreecam)
    pcall(StopSpectating)
    pcall(function() SetCameraShake(false) end)
    pcall(function() SetChams(false) end)
    pcall(function() SetNPCChams(false) end)
    pcall(function() SetHitboxes(false) end)
    pcall(function() SetLowGraphics(false) end)
    pcall(function() SetFullbright(false) end)
    pcall(function() SetAntiVoid(false) end)
    pcall(function() SetAntiRagdoll(false) end)
    pcall(function() SetSpiderClimb(false) end)
    BoxESPEnabled = false
    HealthESPEnabled = false
    pcall(SetPlayerESP)
    pcall(RemoveTeleportTool)
    if Runtime.StopWaypointRoute then
        pcall(function() Runtime.StopWaypointRoute(true) end)
    end
    pcall(function() SetNoclip(false) end)
    AutoJumpEnabled = false
    InfiniteJumpEnabled = false
    AntiFlingEnabled = false
    AntiAFKEnabled = false
    pcall(function() SetFreeze(false) end)
    FastWalkEnabled = false
    HighJumpEnabled = false
    pcall(UpdateMovement)
    pcall(function() SetCharacterLocked(false) end)
    local Connections = {
        FlyConnection, AutoJumpConnection, NoclipConnection, StatusConnection,
        ChamsConnection, NPCChamsConnection, HitboxConnection, FreecamConnection,
        FreecamMouseConnection, FreecamEndConnection, FreecamChangedConnection,
        CameraShakeConnection, SpectatorConnection, ServerStatusConnection,
        StatsStatusConnection, AntiVoidConnection, AntiRagdollConnection,
        SpiderClimbConnection, ESPConnection
    }
    for _, Connection in ipairs(Connections) do
        if Connection then pcall(function() Connection:Disconnect() end) end
    end
    for _, Connection in ipairs(Runtime.PerformanceConnections) do
        if Connection then pcall(function() Connection:Disconnect() end) end
    end
    Runtime.PerformanceConnections = {}
    for _, Connection in ipairs(Runtime.Connections) do
        if Connection then pcall(function() Connection:Disconnect() end) end
    end
    Runtime.Connections = {}
    pcall(function()
        for _, Target in ipairs(Players:GetPlayers()) do
            RemoveESPFromCharacter(Target.Character)
        end
    end)
    pcall(function()
        ClearHighlights("BananiPlayerChams")
        ClearHighlights("BananiNPCChams")
    end)
    pcall(function()
        for _, Object in ipairs(workspace:GetDescendants()) do
            if Object.Name == "BananiHitbox" or Object.Name == "BananiESP"
                or Object.Name == "BananiFlyVelocity" or Object.Name == "BananiFlyGyro" then
                Object:Destroy()
            end
        end
    end)
    Camera.CameraType = Enum.CameraType.Custom
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    do
        local Environment = getgenv and getgenv() or _G
        if Environment.__BANANIHUB_UNLOAD == UnloadBananiHub then
            Environment.__BANANIHUB_UNLOAD = nil
        end
    end
    local H = Humanoid()
    if H then Camera.CameraSubject = H end
    if Rayfield.Destroy then
        pcall(function() Rayfield:Destroy() end)
    elseif Rayfield.Unload then
        pcall(function() Rayfield:Unload() end)
    end
end
do
    local Environment = getgenv and getgenv() or _G
    Environment.__BANANIHUB_UNLOAD = UnloadBananiHub
end
--==============================================================
-- SETTINGS TAB
--==============================================================
do
    local BuildSuccess, BuildError = pcall(function()
        local SettingsTab = Window:CreateTab("⚙️ Settings", 4483362458)
        local NamedConfigFolder = "BANANIHUB/NamedConfigs"
        local SelectedConfigName = ""
        local SelectedConfigToLoad = nil
        local ConfigDropdown
        Runtime.SettingsInfoParagraph = SettingsTab:CreateParagraph({
            Title = "⚙️ BananiHub Preferences",
            Content = "Theme: Loading...\nKeybind: " .. UIToggleKey.Name .. "\nWaypoints: Loading...\nFavorites: Loading..."
        })
        SettingsTab:CreateButton({
            Name = "🔄 Refresh Summary",
            Callback = function() Runtime.UpdatePreferenceDisplays() end
        })
        -- Theme presets
        SettingsTab:CreateSection("🎨 Appearance")
        local ThemePresets = { ["Default"] = DEFAULT_GRAY_THEME, ["🍌 Banana"] = CustomTheme,
            ["🌙 Midnight"] = "DarkBlue", ["🟣 Purple"] = "Amethyst", ["🌊 Ocean"] = "Ocean" }
        local function ApplyPresetTheme(Name)
            local Theme = ThemePresets[Name]
            if not Theme then Notify("Themes", "That theme is unavailable.") return end
            local Success = pcall(function() Window.ModifyTheme(Theme) end)
            if not Success then Notify("Themes", "Theme failed to apply.") return end
            Runtime.CurrentThemeName = Name
            Runtime.SavePreferences()
            Runtime.UpdatePreferenceDisplays()
        end
        SettingsTab:CreateDropdown({
            Name = "UI Theme", Flag = "Settings_Theme",
            Options = {"Default", "🍌 Banana", "🌙 Midnight", "🟣 Purple", "🌊 Ocean"},
            CurrentOption = {Runtime.CurrentThemeName},
            Callback = function(Option) ApplyPresetTheme(type(Option) == "table" and Option[1] or Option) end
        })
        -- Configs
        SettingsTab:CreateSection("💾 Presets & Configs")
        local function EnsureNamedConfigFolder()
            if makefolder and isfolder then
                if not isfolder("BANANIHUB") then makefolder("BANANIHUB") end
                if not isfolder(NamedConfigFolder) then makefolder(NamedConfigFolder) end
            end
        end
        local function CleanConfigName(Name)
            local Clean = tostring(Name or ""):match("^%s*(.-)%s*$")
            return (Clean:gsub("[^%w%-%_ ]", ""))
        end
        local function GetNamedConfigs()
            EnsureNamedConfigFolder()
            local Names = {}
            if listfiles then
                local Success, Files = pcall(listfiles, NamedConfigFolder)
                if Success and type(Files) == "table" then
                    for _, FilePath in ipairs(Files) do
                        local Name = tostring(FilePath):match("([^/\\]+)%.json$")
                        if Name then table.insert(Names, Name) end
                    end
                end
            end
            table.sort(Names)
            return Names
        end
        local function RefreshConfigDropdown()
            if ConfigDropdown then ConfigDropdown:Refresh(GetNamedConfigs()) end
        end
        local function PackConfigValue(Value)
            local ValueType = typeof(Value)
            if ValueType == "Color3" then
                return { __type = "Color3", R = math.floor(Value.R * 255 + 0.5),
                    G = math.floor(Value.G * 255 + 0.5), B = math.floor(Value.B * 255 + 0.5) }
            elseif ValueType == "EnumItem" then
                return { __type = "EnumItem", EnumType = tostring(Value.EnumType), Name = Value.Name }
            end
            return Value
        end
        local function UnpackConfigValue(Value)
            if type(Value) ~= "table" then return Value end
            if Value.__type == "Color3" then
                return Color3.fromRGB(Value.R or 255, Value.G or 255, Value.B or 255)
            elseif Value.__type == "EnumItem" then
                local EnumTypeName = tostring(Value.EnumType or ""):match("^Enum%.(.+)$")
                local EnumType = EnumTypeName and Enum[EnumTypeName]
                if EnumType and Value.Name and EnumType[Value.Name] then return EnumType[Value.Name] end
            end
            return Value
        end
        local function CaptureCurrentConfig()
            local Data = {}
            for FlagName, Flag in pairs(Rayfield.Flags or {}) do
                local Value = Flag.CurrentValue or Flag.CurrentKeybind or Flag.CurrentOption or Flag.Color
                if typeof(Flag.CurrentValue) == "boolean" then Value = Flag.CurrentValue end
                if Value ~= nil then Data[FlagName] = PackConfigValue(Value) end
            end
            return HttpService:JSONEncode(Data)
        end
        SettingsTab:CreateInput({
            Name = "Config Name", PlaceholderText = "Example: Grinding", RemoveTextAfterFocusLost = false,
            Callback = function(Value) SelectedConfigName = Value end
        })
        ConfigDropdown = SettingsTab:CreateDropdown({
            Name = "Saved Configs", Options = GetNamedConfigs(), CurrentOption = {}, SearchBarEnabled = true,
            Callback = function(Option) SelectedConfigToLoad = type(Option) == "table" and Option[1] or Option end
        })
        SettingsTab:CreateButton({
            Name = "💾 Save New Preset",
            Callback = function()
                EnsureNamedConfigFolder()
                local Name = CleanConfigName(SelectedConfigName)
                if Name == "" then Notify("Configs", "Enter a config name first.") return end
                if not writefile then Notify("Configs", "File saving is unsupported.") return end
                local Path = NamedConfigFolder .. "/" .. Name .. ".json"
                if isfile and isfile(Path) then Notify("Configs", Name .. " already exists.") return end
                local Success = pcall(function() writefile(Path, CaptureCurrentConfig()) end)
                if Success then
                    SelectedConfigToLoad = Name
                    RefreshConfigDropdown()
                    Runtime.UpdatePreferenceDisplays()
                    Notify("Configs", "Saved " .. Name)
                else
                    Notify("Configs", "Could not save the config.")
                end
            end
        })
        SettingsTab:CreateButton({
            Name = "📂 Load Selected Preset",
            Callback = function()
                local Name = CleanConfigName(SelectedConfigToLoad)
                if Name == "" then Notify("Configs", "Select a config first.") return end
                local Path = NamedConfigFolder .. "/" .. Name .. ".json"
                if not readfile or not isfile or not isfile(Path) then Notify("Configs", "That config was not found.") return end
                local Success, Data = pcall(function() return HttpService:JSONDecode(readfile(Path)) end)
                if not Success or type(Data) ~= "table" then Notify("Configs", "That config is invalid.") return end
                local AppliedCount = 0
                for FlagName, PackedValue in pairs(Data) do
                    local Flag = Rayfield.Flags and Rayfield.Flags[FlagName]
                    if Flag and Flag.Set then
                        pcall(function() Flag:Set(UnpackConfigValue(PackedValue)) end)
                        AppliedCount += 1
                        if AppliedCount % 20 == 0 then task.wait() end
                    end
                end
                Notify("Configs", "Loaded " .. Name)
            end
        })
        SettingsTab:CreateButton({ Name = "🔄 Refresh Preset List", Callback = RefreshConfigDropdown })
        -- Favorites
        SettingsTab:CreateSection("⭐ Pinned Features")
        Runtime.SelectedFavoriteFeature = Runtime.SelectedFavoriteFeature or Runtime.FavoriteOptions[1]
        SettingsTab:CreateDropdown({
            Name = "Select Feature", Options = Runtime.FavoriteOptions,
            CurrentOption = {Runtime.SelectedFavoriteFeature}, SearchBarEnabled = true,
            Callback = function(Option) Runtime.SelectedFavoriteFeature = type(Option) == "table" and Option[1] or Option end
        })
        SettingsTab:CreateButton({
            Name = "⭐ Pin Selected Feature",
            Callback = function()
                local Name = Runtime.SelectedFavoriteFeature
                if not Name or Name == "" then Notify("Favorites", "Select a feature first.") return end
                Runtime.Favorites[Name] = true
                Runtime.SavePreferences()
                Runtime.UpdatePreferenceDisplays()
            end
        })
        SettingsTab:CreateButton({
            Name = "➖ Unpin Selected Feature",
            Callback = function()
                local Name = Runtime.SelectedFavoriteFeature
                if not Name or Name == "" then Notify("Favorites", "Select a feature first.") return end
                Runtime.Favorites[Name] = nil
                Runtime.SavePreferences()
                Runtime.UpdatePreferenceDisplays()
            end
        })
        -- Interface
        SettingsTab:CreateSection("⌨️ Interface Controls")
        SettingsTab:CreateKeybind({
            Name = "Open / Close BananiHub", CurrentKeybind = UIToggleKey.Name,
            HoldToInteract = false, CallOnChange = true, Flag = "Settings_UIKeybind",
            Callback = function(Key)
                local KeyName = typeof(Key) == "EnumItem" and Key.Name or tostring(Key or "")
                if Enum.KeyCode[KeyName] then
                    UIToggleKey = Enum.KeyCode[KeyName]
                    Runtime.SavePreferences()
                    Runtime.UpdatePreferenceDisplays()
                    Notify("Keybind", "UI key changed to " .. KeyName)
                end
            end
        })
        SettingsTab:CreateButton({
            Name = "👁️ Toggle BananiHub Now",
            Callback = function() if Rayfield.ToggleUI then Rayfield:ToggleUI() end end
        })
        -- Script management
        SettingsTab:CreateSection("🧹 Reset & Unload")
        SettingsTab:CreateButton({ Name = "🚨 Reset All Active Features", Callback = MasterReset })
        SettingsTab:CreateButton({ Name = "🗑️ Unload BananiHub", Callback = UnloadBananiHub })
        if Runtime.CurrentThemeName ~= "Default" and ThemePresets[Runtime.CurrentThemeName] then
            task.defer(function() ApplyPresetTheme(Runtime.CurrentThemeName) end)
        end
        Runtime.UpdatePreferenceDisplays()
    end)
    if not BuildSuccess then
        warn("BANANIHUB | Settings tab failed: " .. tostring(BuildError))
    end
end
--==============================================================
-- KEYBIND + CHARACTER RESPAWN + INIT
--==============================================================
TrackConnection(UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed or Unloaded then return end
    if Input.KeyCode == UIToggleKey and Rayfield.ToggleUI then
        Rayfield:ToggleUI()
    end
end))
TrackConnection(Player.CharacterAdded:Connect(function(NewCharacter)
    task.defer(function()
        local H = NewCharacter:WaitForChild("Humanoid", 5)
        if not H or Unloaded then return end
        Camera = workspace.CurrentCamera or Camera
        if FreezeEnabled then
            NewCharacter:WaitForChild("HumanoidRootPart", 5)
            SetFreeze(true)
        else
            UpdateMovement()
        end
        if NoclipEnabled then SetNoclip(true) end
        if FlyEnabled then StartFly() end
        if FreecamEnabled or Spectating then SetCharacterLocked(true) end
    end)
end))
SetLoadingStage("Loading preferences...")
RefreshPlayers()
RefreshWaypoints()
Runtime.UpdatePreferenceDisplays()
if Runtime.RefreshServerInfo then Runtime.RefreshServerInfo() end
LogInformation("BananiHub v" .. BANANIHUB_VERSION .. " loaded", "System")
SetLoadingStage("Ready")
Notify("🍌 BANANIHUB • v" .. BANANIHUB_VERSION, "Available. Press " .. UIToggleKey.Name .. " to toggle.")
