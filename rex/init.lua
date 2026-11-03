-- daniel's rex config
-- ============================

local P = "ctrl+b>"

-- send a literal ctrl+b by pressing it twice
rex.bind(P .. "ctrl+b", "pane.send_key", { key = "ctrl+b" })

-- reload
rex.bind(P .. "r", "client.config.reload")

-- command palette
rex.bind(P .. "space", "client.palette.toggle")

-- find (tmux copy-mode search)
rex.bind(P .. "/", "client.find.open")

-- tabs
rex.bind(P .. "c", "client.tab.new")
rex.bind(P .. "n", "client.tab.next")
rex.bind(P .. "p", "client.tab.previous")
rex.bind(P .. ",", "client.tab.rename")
-- rex has no close confirm yet, fake tmux's kill-window y/n with a mode
rex.mode("confirm_close", { exclusive = true })
rex.bind(P .. "shift+7", "client.mode.enter", { name = "confirm_close", once = true })
rex.bind("confirm_close/y", "client.tab.close")
rex.bind("confirm_close/n", "client.mode.exit")
for i = 1, 9 do
	rex.bind(P .. i, "client.tab.goto", { index = i })
end

-- tmux-afterkill: close every tab after the current one
rex.action({
	name = "afterkill",
	title = "Close Tabs After This One",
	run = function()
		local view = rex.session.view({})
		local after = false
		for _, w in ipairs(view.windows) do
			if after then
				rex.session.close_window({ window_id = w.window_id })
			end
			if w.window_id == view.active_window_id then
				after = true
			end
		end
	end,
})
rex.bind(P .. "shift+k", "afterkill")

-- panes
rex.bind(P .. "shift+5", "pane.split", { direction = "right" })
rex.bind(P .. "shift+'", "pane.split", { direction = "down" })
rex.bind(P .. "z", "pane.zoom")
-- pane.close is broken when bound in init.lua (rex bug), close via the server
rex.action({
	name = "close_pane",
	title = "Close Pane",
	run = function(ctx)
		rex.call("block.close", { session_id = ctx.session_id, block_id = ctx.block_id })
	end,
})
-- same y/n confirm as ctrl+b & (see confirm_close above)
rex.mode("confirm_close_pane", { exclusive = true })
rex.bind(P .. "x", "client.mode.enter", { name = "confirm_close_pane", once = true })
rex.bind("confirm_close_pane/y", "close_pane")
rex.bind("confirm_close_pane/n", "client.mode.exit")

-- vim-like pane switching
rex.bind(P .. "h", "pane.focus.left")
rex.bind(P .. "j", "pane.focus.down")
rex.bind(P .. "k", "pane.focus.up")
rex.bind(P .. "l", "pane.focus.right")

-- sessions
rex.bind(P .. "s", "session.switch")
rex.bind(P .. "shift+4", "session.rename")

-- tmux display-popup -> floating layer running a command
local function cwd(ctx)
	local r = rex.block.call("com.superlogical.terminal", "pwd", { block_id = ctx.block_id })
	if r and r.pwd then
		return (r.pwd:gsub("^file://[^/]*", ""))
	end
end

local function popup(name, title, w, h, command)
	rex.action({
		name = name,
		title = title,
		category = "Popups",
		run = function(ctx)
			rex.session.new_layer({
				bounds = { (1 - w) / 2, (1 - h) / 2, w, h },
				focus = true,
				layout = rex.layout.block({
					flavor = "com.superlogical.terminal.shell",
					label = title,
					options = { command = type(command) == "function" and command(ctx) or command, cwd = cwd(ctx) },
				}),
			})
		end,
	})
end

local home = os.getenv("HOME")

-- popups
-- sessionser
popup("rexionizer", "Rexionizer", 0.65, 0.65, function(ctx)
	-- A session can be open on several devices. Target the one that opened the popup.
	return {
		"env",
		"REX_CLIENT=" .. assert(ctx.client_id, "rexionizer needs an originating client"),
		"zsh",
		"-lc",
		"REX_POPUP=1 rexionizer",
	}
end)
rex.bind(P .. "f", "rexionizer")
popup("rexshuffle", "Rexshuffle", 0.5, 0.5, { "zsh", "-lc", "rexshuffle" })
rex.bind(P .. "m", "rexshuffle")
popup("lazygit", "Lazygit", 0.9, 0.9, { "zsh", "-lc", "XDG_CONFIG_HOME=$HOME/.config lazygit" })
rex.bind(P .. "g", "lazygit")
popup("list_keys", "List Keys", 0.8, 0.8, { "zsh", "-lc", "rex keymap | fzf" })
rex.bind(P .. "shift+/", "list_keys")
popup("wallpaper", "Wallpaper", 0.5, 0.45, { home .. "/.local/bin/wallpaper" })
rex.bind(P .. "w", "wallpaper")
-- senu
popup("senu_threads", "Senu Threads", 0.65, 0.6, { home .. "/.local/bin/senu", "threads", "--live" })
rex.bind(P .. "a", "senu_threads")
popup("senu_vision", "Senu Vision", 0.65, 0.7, { home .. "/.local/bin/senu", "vision" })
rex.bind(P .. "u", "senu_vision")

-- menu
popup("rexdots", "Rexdots", 0.5, 0.45, { "zsh", "-lc", "rexdots" })
rex.bind(P .. "d", "rexdots")
