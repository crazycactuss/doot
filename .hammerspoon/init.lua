hs.hotkey.bind({"cmd", "ctrl"}, "t", function()
  hs.application.launchOrFocus("Terminal")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "e", function()
    em = hs.application.get("Emacs")
    if em == nil then
      hs.application.launchOrFocus("Emacs")
    else
      em:activate()
    end
end)
hs.hotkey.bind({"cmd", "ctrl"}, "g", function()
  hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "s", function()
  hs.application.launchOrFocus("Slack")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "b", function()
  hs.application.launchOrFocus("Between")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "i", function()
  hs.application.launchOrFocus("IntelliJ IDEA")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "f", function()
  hs.application.launchOrFocus("Finder")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "c", function()
  hs.application.launchOrFocus("Citrix Viewer")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "o", function()
  hs.application.launchOrFocus("Spotify")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "u", function()
  hs.application.launchOrFocus("Visual Studio Code")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "a", function()
  hs.application.launchOrFocus("Google Calendar")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "m", function()
  hs.application.launchOrFocus("Google Mail")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "k", function()
  hs.application.launchOrFocus("Facebook Messenger")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "d", function()
  hs.application.launchOrFocus("Todoist")
end)
hs.hotkey.bind({"cmd", "ctrl"}, "u", function()
    hs.application.launchOrFocus("Visual Studio Code")
end)
