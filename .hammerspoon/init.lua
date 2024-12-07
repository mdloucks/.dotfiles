local hyper = { "ctrl", "alt" }

hs.hotkey.bind(hyper, "R", function()
	hs.reload()
end)

local function bindApplicationHotkey(appBundleID, key)
	hs.hotkey.bind(hyper, key, function()
		hs.application.launchOrFocusByBundleID(appBundleID)
		-- hs.application.launchOrFocus(appBundleID)
	end)
end

-- osascript -e 'id of app "Slack"'
local function bindApplications(keysAndApps)
	for appBundleID, key in pairs(keysAndApps) do
		bindApplicationHotkey(appBundleID, key)
	end
end

local appsToBind = {
    ["org.alacritty"] = "t",  
    ["org.mozilla.firefox"] = "f",
    ["com.apple.iphonesimulator"] = "s",
    ["com.apple.systempreferences"] = "p",
    ["com.1password.1password"] = "1",
    ["com.google.Chrome"] = "w",

    ["com.apple.iCal"] = "c",
    ["com.apple.mail"] = "e",
    ["com.apple.MobileSMS"] = "m",
    ["com.apple.notes"] = "n",
    ["com.apple.finder"] = "x",
    ["com.apple.reminders"] = "r",

    ["com.tinyspeck.slackmacgap"] = "v",  
    ["com.spotify.client"] = "a",  
}


bindApplications(appsToBind)

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- tile window to right
hs.hotkey.bind(hyper, "Right", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w / 2)
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

-- tile window to left
hs.hotkey.bind(hyper, "Left", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

-- tile window to center
hs.hotkey.bind(hyper, "g", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.w = max.w / 1.5
	f.h = max.h / 1.2
	f.x = max.x + (max.w - f.w) / 2
	f.y = max.y + (max.h - f.h) / 2
	win:setFrame(f)
end)

-- hs.hotkey.bind(hyper, "1", function()
--     local win = hs.window.focusedWindow()
--     local screen = win:screen()
--     local max = screen:frame()
--     -- local laptopScreen = "ES-22F1"
--
--     local windowLayout = {
--         {"com.apple.iCal", nil, screen, hs.geometry.rect(0.15, 0.05, 0.25, 0.27), nil, nil},
--         {"com.apple.reminders",  nil, screen, hs.geometry.rect(0.59, 0.05, 0.25, 0.25), nil, nil},
--         -- {"com.tinyspeck.slackmacgap",    nil,          laptopScreen, hs.layout.right50,   nil, nil},
--         -- {"iTunes",  "iTunes",     laptopScreen, hs.layout.maximized, nil, nil},
--         -- {"iTunes",  "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
--     }
--     hs.layout.apply(windowLayout)
--
--     -- then focus them
--
--   -- hs.application.launchOrFocusByBundleID("org.mozilla.firefox")
--   -- hs.application.launchOrFocusByBundleID("com.tinyspeck.slackmacgap")
-- end)

-- local screen_watcher = hs.screen.watcher.new(
--   function ()
--     print("Received hs.screen.watcher event")
--     local screens = hs.screen.allScreens()
--     print("  Screens: %s", hs.inspect(screens))
--     if #screens > 0 and hs.fnutils.every(screens,
--                                          function (s) return s:name() ~= "Color LCD" end) then
--       print("  'Color LCD' display is gone but other screens remain - detecting this as 'lid close'")
--       hs.execute("diskutil unmount ~/filesystems/dash.magnusbox.com/")
--       print("unmounted!")
--     end
--   end
-- ):start()

hs.loadSpoon("EjectMenu")
spoon.EjectMenu.eject_on_lid_close = true
spoon.EjectMenu.eject_on_sleep = true
spoon.EjectMenu:start()
