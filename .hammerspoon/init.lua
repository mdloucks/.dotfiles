local hyper = { "ctrl", "alt" }

hs.hotkey.bind(hyper, "R", function()
	hs.reload()
end)

local function bindApplicationHotkey(appBundleID, key)
	hs.hotkey.bind(hyper, key, function()
		hs.application.launchOrFocusByBundleID(appBundleID)
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

-- hs.loadSpoon("EjectMenu")
-- spoon.EjectMenu.eject_on_lid_close = true
-- spoon.EjectMenu.eject_on_sleep = true
-- spoon.EjectMenu:start()
