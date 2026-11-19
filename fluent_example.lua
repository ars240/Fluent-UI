loadstring(game:HttpGet("https://raw.githubusercontent.com/ars240/Fluent-UI/main/fluent.lua"))()
local UI = Fluent

local Window = UI:CreateWindow({
    Title = "Example Hub", SubTitle = "by you", Size = Vector2.new(640, 500), Theme = "Dark",
    Search = true, UserInfo = true, MinimizeKey = "End",
    Tags = { { Text = "v1.0" }, { Text = "beta", Color = Color3.fromRGB(240, 190, 60) } },
})

local Combat = Window:AddTab({ Title = "Combat", Icon = "crosshair" })
local Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" })
local Player = Window:AddTab({ Title = "Player", Icon = "user" })
local Misc = Window:AddTab({ Title = "Misc", Icon = "box" })
local Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })

local Aim = Combat:AddSection("Aimbot", "target")
Aim:AddToggle("AimEnabled", { Title = "Enabled", Description = "Locks onto the closest target", Default = false })
Aim:AddKeybind("AimKey", { Title = "Aim key", Mode = "Hold", Default = "MB2" })
Aim:AddDropdown("AimPart", { Title = "Target part", Values = { "Head", "Torso", "Closest" }, Default = 1 })
Aim:AddSlider("AimFOV", { Title = "FOV", Min = 10, Max = 500, Default = 120, Rounding = 0 })
Aim:AddSlider("AimSmooth", { Title = "Smoothness", Description = "Higher is slower", Min = 1, Max = 20, Default = 5, Rounding = 0 })

local AimChecks = Combat:AddCollapsibleSection("Checks", "shield-check", false)
AimChecks:AddToggle("CheckTeam", { Title = "Team check", Default = true })
AimChecks:AddToggle("CheckWall", { Title = "Wall check", Default = true })
AimChecks:AddDropdown("CheckIgnore", { Title = "Ignore", Values = { "Friends", "Admins", "Downed" }, Multi = true, Default = { "Friends" } })

local Trigger = Combat:AddSection("Triggerbot", "mouse-pointer-click")
Trigger:AddToggle("TriggerEnabled", { Title = "Enabled", Default = false })
Trigger:AddSlider("TriggerDelay", { Title = "Delay (ms)", Min = 0, Max = 500, Default = 60, Rounding = 0 })

local Esp = Visuals:AddSection("ESP", "scan-eye")
Esp:AddToggle("EspEnabled", { Title = "Enabled", Default = false })
local EspCols = Esp:AddGroup({ Columns = 2, Gap = 8 })
local EspLeft, EspRight = EspCols:AddElement(), EspCols:AddElement()
EspLeft:AddToggle("EspBoxes", { Title = "Boxes", Default = true })
EspLeft:AddToggle("EspNames", { Title = "Names", Default = true })
EspRight:AddToggle("EspHealth", { Title = "Health", Default = false })
EspRight:AddToggle("EspTracers", { Title = "Tracers", Default = false })
Esp:AddColorpicker("EspColor", { Title = "ESP color", Default = Color3.fromRGB(96, 205, 255) })
Esp:AddSlider("EspDistance", { Title = "Max distance", Min = 50, Max = 5000, Default = 1500, Rounding = 0 })

local World = Visuals:AddSection("World", "sun")
World:AddToggle("Fullbright", { Title = "Fullbright", Default = false })
World:AddSlider("FieldOfView", { Title = "Field of view", Min = 30, Max = 120, Default = 70, Rounding = 0 })
World:AddDropdown("Skybox", { Title = "Skybox", Values = { "Default", "Night", "Space", "Sunset" }, Default = 1 })

local Move = Player:AddSection("Movement", "footprints")
Move:AddToggle("SpeedEnabled", { Title = "Speed", Default = false })
Move:AddSlider("SpeedValue", { Title = "Walk speed", Min = 16, Max = 200, Default = 16, Rounding = 0 })
Move:AddToggle("InfJump", { Title = "Infinite jump", Default = false })
Move:AddKeybind("FlyKey", { Title = "Fly", Description = "Toggle flying", Mode = "Toggle", Default = "F" })

local Teleport = Player:AddSection("Teleport", "map-pin")
Teleport:AddDropdown("TpTarget", { Title = "Player", Values = { "Player1", "Player2", "Player3" }, Default = 1 })
Teleport:AddButtonRow({ { Title = "Teleport", Callback = function() end }, { Title = "Spectate", Callback = function() end } })

local Server = Misc:AddSection("Server", "server")
Server:AddInput("JobId", { Title = "Job id", Placeholder = "paste a job id..." })
Server:AddButtonRow({ { Title = "Join", Callback = function() end }, { Title = "Rejoin", Callback = function() end } })
Server:AddButton({ Title = "Server hop", Description = "Joins a different server", Callback = function()
    Window:Dialog({ Title = "Server hop", Content = "Leave this server?", Buttons = {
        { Title = "Hop", Callback = function() end },
        { Title = "Cancel" },
    } })
end })

local Info = Misc:AddSection("Info", "info")
Info:AddParagraph({ Title = "Example Hub", Content = "This is a UI example. None of these features do anything." })
Info:AddCode({ Title = "Loader", Code = 'loadstring(game:HttpGet("https://example.com/hub.lua"))' })

Window:BuildInterfaceSection(Settings)
Window:BuildConfigSection(Settings)

UI:Notify({ Title = "Example Hub", Content = "Loaded. Press End to minimize.", Type = "Success", Duration = 4 })
