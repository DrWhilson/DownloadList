hl.on("hyprland.start", function()
	hl.exec_cmd("waybar & hyprpaper & hypridle & sddm-greeter --display HDMI-A-1")
	hl.exec_cmd("wayscriber --daemon")
end)
