---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "mate-terminal"
local alt_terminal = "cool-retro-term"
local fileManager = "thunar"
local menu = "wofi"
local alt_menu = "rofi"
local browser = "firefox"

local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT" .. "+ T", hl.dsp.exec_cmd(alt_terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT" .. " + E", hl.dsp.exec_cmd(terminal .. " -e spf"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1, action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT" .. " + R", hl.dsp.exec_cmd(alt_menu .. " -show drun"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Print screen
hl.bind("Print", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("SHIFT" .. " + Print", hl.dsp.exec_cmd("grimblast copy screen"))
hl.bind("CTRL" .. " + Print", hl.dsp.exec_cmd("wayscriber --daemon-toggle"))
