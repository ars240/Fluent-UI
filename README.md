# Fluent – Docs

## Load
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/ars240/Fluent-UI/main/fluent.lua"))()
local UI = Fluent
```
Matcha's `loadstring` doesn't pass back return values, so use the global `Fluent`.

## Window
```lua
local Window = UI:CreateWindow({
    Title = "My Hub", SubTitle = "v1.0",
    Size = Vector2.new(620, 480),
    Theme = "Dark",          -- see UI.Themes
    Compact = true,
    Search = true,           -- search box
    UserInfo = true,         -- avatar card
    MinimizeKey = "End",
    Tags = { { Text = "v1.0" }, { Text = "beta", Color = Color3.fromRGB(250, 204, 21) } },
})
```
Other options: `Font`, `TextSize`, `Shadow`, `Translucent`, `Shine`, `ShineColor`, `Resize`, `MinSize`, `TabWidth`, `ConfigName`, `FPS`, `UserInfoTitle`, `UserInfoSubtitle`, `UserInfoColor`, `UserInfoTop`.

Window methods: `AddTab`, `SelectTab(i)`, `Show()`, `Hide()`, `Dialog(cfg)`, `BuildConfigSection(tab)`, `BuildInterfaceSection(tab)`.

## Tabs & sections
```lua
local Main = Window:AddTab({ Title = "Main", Icon = "home" })
local s   = Main:AddSection("Combat", "crosshair")
local adv = Main:AddCollapsibleSection("Advanced", "sliders-horizontal", false) -- starts closed
```
See **Icons** below.

## Elements
First argument is the flag (used for configs and `UI.Options[flag]`).
```lua
s:AddToggle("auto",  { Title = "Auto shoot", Description = "...", Default = true, Callback = function(v) end })
s:AddToggle("fly",   { Title = "Fly", Keybind = { Default = "F", Mode = "Toggle" } }) -- keybind on the toggle
s:AddSlider("rate",  { Title = "Rate", Min = 0, Max = 300, Default = 145, Callback = function(v) end })
s:AddDropdown("tgt", { Title = "Target", Values = { "First", "Last" }, Default = 1, Multi = false, Callback = function(v) end })
s:AddInput("nm",     { Title = "Name", Placeholder = "type here...", Callback = function(text) end })
s:AddKeybind("kb",   { Title = "Toggle key", Default = "F", Mode = "Toggle", Callback = function() end }) -- Always / Toggle / Hold
s:AddColorpicker("col", { Title = "Color", Default = Color3.fromRGB(96, 205, 255), Transparency = 0, UpdateOnChange = false })
s:AddButton({ Title = "Reload", Description = "...", Callback = function() end })
s:AddParagraph({ Title = "Info", Content = "Text..." })
s:AddCode({ Title = "Script", Code = "print(1)", OnCopy = function() end })
s:AddImage({ Image = "https://...", AspectRatio = "16:9" })
s:AddButtonRow({ { Title = "A", Callback = fn }, { Title = "B", Callback = fn } })
s:AddDivider()
s:AddSpace({ Height = 6 })
```

### Columns
```lua
local cols = s:AddGroup({ Columns = 2, Gap = 8 })
local left, right = cols:AddElement(), cols:AddElement()
left:AddToggle("l1", { Title = "Left" })
right:AddButton({ Title = "Right" })
```

### Element methods
| Method | Works on |
|---|---|
| `:SetValue(v)` / `:Get()` | toggle, slider, dropdown, input, keybind, colorpicker |
| `:OnChanged(fn)` | value elements |
| `:SetValues(list)` | dropdown |
| `:SetTitle(t)` / `:SetDescription(t)` | all |
| `:SetContent(t)` | paragraph |
| `:SetCode(t)` / `:SetImage(url)` | code / image |
| `:GetState()` / `:OnClick(fn)` | keybind |
| `:Destroy()` | all |

Read any value: `UI.Options.auto.Value`
Keybinds: click the key box to rebind, right click it to pick the mode.
Color pickers: changes apply on mouse release (every move with `UpdateOnChange = true`); click outside to close.
Notifications: no `Duration` = stays until closed; hovering pauses the timer.

## Notify & dialog
```lua
UI:Notify({ Title = "Saved", Content = "Config saved", SubContent = "optional grey line", Duration = 3 })
UI:Notify({ Title = "Update", Content = "Rejoin?", Buttons = { { Title = "Yes", Callback = function() end }, { Title = "No" } } })

Window:Dialog({
    Title = "Rename", Content = "New name:", Input = { Placeholder = "name..." },
    Buttons = { { Title = "OK", Callback = function(text) end }, { Title = "Cancel" } },
})
```

## Configs & settings
```lua
UI:SetFolder("MyHub")
Window:BuildInterfaceSection(SettingsTab) -- theme, font, text size...
Window:BuildConfigSection(SettingsTab)    -- save / load / autoload
UI:LoadAutoloadConfig()
```
Also: `UI:SaveConfig(name)`, `UI:LoadConfig(name)`, `UI:GetConfigs()`, `UI:SetAutoload(name)`, `UI:SetIgnoreIndexes({ "flag" })`.

## Library
| Function | Does |
|---|---|
| `UI:SetTheme(name)` / `UI:RegisterCustomTheme(name, colors)` | themes |
| `UI:SetFont(name)` / `UI:SetTextSize(size)` | text |
| `UI:SetCompact(on)` / `UI:SetTranslucent(on)` / `UI:SetShadow(on)` | look |
| `UI:SetShineSweep(on, color)` | shine effect |
| `UI:Minimize()` / `UI:Maximize()` | show / hide |
| `UI:OnUnload(fn)` / `UI:OnThemeChanged(fn)` | events |
| `UI:Stop()` / `UI:Destroy()` | close the UI |

## Fonts
Built in: `Segoe UI` (default), `Poppins`, `Bahnschrift`, `Consolas`, `Matcha`.
```lua
UI:SetFont("Poppins")   -- or Font = "Poppins" in CreateWindow
UI:SetFont("Matcha")    -- Matcha's own font everywhere
```
Grey/white text size 18+ (title, tab header) is drawn from letter images built into `fluent.lua`. Nothing extra to download.
Smaller text and colored text use Matcha's font (Matcha can't tint images).
Only built-in fonts work.

## Icons
Go on tabs, sections and any element:
```lua
Window:AddTab({ Title = "Visuals", Icon = "eye" })
Main:AddSection("ESP", "scan-eye")
Main:AddCollapsibleSection("Checks", "shield-check", false)
s:AddToggle("esp", { Title = "ESP", Icon = "eye" })
s:AddButton({ Title = "Rejoin", Icon = "refresh-cw", Callback = function() end })
```
| Icon value | Source |
|---|---|
| `"eye"` | Lucide: find names at lucide.dev |
| `"phosphor-eye"` / `"phosphor-eye-bold"` | Phosphor: phosphoricons.com, weights `thin` `light` `bold` `fill` `duotone` |
| `"https://.../icon.png"` | any image link |

Icons download the first time and are saved, so later loads are instant.

### Ready icons (Lucide, 437, all checked)
| Use | Icons |
|---|---|
| Tabs | `home` `settings` `layers` `box` `package` `list` `sliders-horizontal` `info` `house` `menu` `layout-grid` `layout-dashboard` `panels-top-left` `app-window` `blocks` `grid-3x3` `folder-open` `bookmark` `tag` `tags` `hash` `at-sign` `circle-help` `book-open` `newspaper` `file-text` `scroll` `notebook-pen` |
| Combat | `crosshair` `target` `sword` `swords` `axe` `hammer` `bomb` `skull` `shield` `shield-check` `flame` `zap` `shield-alert` `shield-off` `shield-half` `locate` `locate-fixed` `focus` `biohazard` `radiation` `flame-kindling` `slash` `ban` `octagon-x` `circle-x` `siren` `heart-crack` |
| Visuals | `eye` `eye-off` `scan-eye` `radar` `palette` `paintbrush` `sun` `moon` `sparkles` `wand-2` `glasses` `binoculars` `camera` `video` `image` `aperture` `scan` `scan-face` `scan-line` `contrast` `lightbulb` `lamp` `sunrise` `sunset` `cloud` `cloud-moon` `rainbow` `brush` `pipette` `droplets` `blend` `layers-2` `box-select` `square-dashed` |
| Player | `user` `users` `heart` `footprints` `move` `gauge` `activity` `ghost` `bot` `user-round` `user-check` `user-x` `user-plus` `user-minus` `user-cog` `users-round` `contact` `smile` `frown` `angry` `baby` `person-standing` `accessibility` `hand` `hand-metal` `thumbs-up` `thumbs-down` `dumbbell` `heart-pulse` `brain` `bone` `shirt` |
| Movement | `arrow-up` `arrow-down` `arrow-left` `arrow-right` `arrow-up-right` `move-3d` `move-vertical` `move-horizontal` `chevrons-up` `chevrons-down` `repeat` `shuffle` `undo-2` `redo-2` `corner-down-right` `route` `milestone` `signpost` `flag` `flag-triangle-right` `locate-off` `anchor` `feather` |
| World / teleport | `map` `map-pin` `compass` `navigation` `globe` `mountain` `tree-pine` `droplet` `snowflake` `wind` `earth` `map-pinned` `map-pin-off` `mountain-snow` `tree-deciduous` `trees` `leaf` `sprout` `flower` `flower-2` `palmtree` `tent` `castle` `church` `landmark` `building` `building-2` `factory` `warehouse` `store` `school` `hospital` `waves` `cloud-rain` `cloud-lightning` `cloud-snow` `thermometer` `sun-moon` `orbit` `satellite` |
| Vehicles | `car` `plane` `rocket` `bike` `bus` `truck` `train-front` `tram-front` `ship` `sailboat` `helicopter` `tractor` `fuel` `plane-takeoff` `plane-landing` `car-front` `caravan` |
| Farming / economy | `coins` `dollar-sign` `gem` `shopping-cart` `gift` `trophy` `medal` `crown` `star` `pickaxe` `fish` `wallet` `banknote` `credit-card` `piggy-bank` `receipt` `shopping-bag` `shopping-basket` `package-open` `package-plus` `boxes` `archive` `vault` `badge-dollar-sign` `badge-percent` `percent` `trending-up` `trending-down` `chart-line` `chart-pie` `award` `ribbon` `diamond` |
| Items / tools / food | `apple` `cherry` `carrot` `egg` `cookie` `pizza` `beef` `fish-symbol` `cake` `coffee` `cup-soda` `wine` `beer` `candy` `ice-cream-cone` `soup` `utensils` `flask-conical` `flask-round` `test-tube` `pill` `syringe` `bandage` `backpack` `briefcase` `key-round` `wrench` `scissors` `shovel` `magnet` `battery` `battery-charging` `plug` `cog` `puzzle` |
| Games / animals | `gamepad-2` `dices` `gamepad` `joystick` `dice-1` `dice-5` `dice-6` `spade` `club` `heart-handshake` `cat` `dog` `bird` `rabbit` `turtle` `squirrel` `rat` `snail` `worm` `paw-print` |
| Server / chat / sound | `server` `wifi` `link` `refresh-cw` `rotate-ccw` `log-out` `power` `timer` `clock` `bell` `triangle-alert` `server-cog` `server-crash` `database` `hard-drive` `cpu` `memory-stick` `router` `signal` `wifi-off` `cloud-upload` `cloud-download` `refresh-ccw` `rotate-cw` `loader` `history` `calendar` `alarm-clock` `hourglass` `timer-reset` `radio` `antenna` `share-2` `send` `mail` `message-circle` `message-square` `megaphone` `volume-2` `volume-x` `mic` `mic-off` `headphones` `music` |
| Input / search | `keyboard` `mouse-pointer-click` `key` `lock` `unlock` `toggle-left` `mouse` `mouse-pointer` `mouse-pointer-2` `pointer` `hand-grab` `keyboard-music` `command` `option` `delete` `space` `toggle-right` `circle-power` `fingerprint` `scan-search` `search` `zoom-in` `zoom-out` `filter` `funnel` `list-filter` `arrow-up-down` |
| Files / config | `save` `folder` `download` `upload` `copy` `clipboard` `trash-2` `file` `file-plus` `file-minus` `file-check` `file-x` `file-code` `file-json` `folder-plus` `folder-minus` `folder-check` `folder-x` `save-all` `import` `clipboard-check` `clipboard-copy` `clipboard-list` `pen` `pencil` `eraser` `edit-3` `settings-2` `sliders-vertical` `list-checks` `check-check` `circle-check` `square-check` |
| Dev | `code` `terminal` `bug` `bar-chart-3` `code-xml` `braces` `brackets` `binary` `git-branch` `git-commit-horizontal` `bug-off` `bug-play` `terminal-square` `variable` `function-square` `regex` `workflow` `network` `component` |
| Shapes | `play` `pause` `square` `circle` `check` `x` `triangle` `hexagon` `octagon` `pentagon` `star-half` `heart-off` `circle-dot` `circle-dashed` `circle-plus` `circle-minus` `square-plus` `square-minus` `plus` `minus` `equal` `divide` `infinity` `sparkle` `asterisk` |

