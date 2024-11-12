-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config = {
	color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"FiraCode Nerd Font",
	}),
	enable_scroll_bar = false,
	enable_tab_bar = false,
	keys = {
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
	},
	window_close_confirmation = "NeverPrompt",
}
-- and finally, return the configuration to wezterm
return config
