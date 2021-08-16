local wezterm = require 'wezterm';

wezterm.on("open-uri", function(window, pane, uri)
  local start, match_end = uri:find("mailto:")
  if start == 1 then
    local recipient = uri:sub(match_end+1)
    window:perform_action(wezterm.action{SpawnCommandInNewWindow={
         args={"mutt", recipient}
    }}, pane);
    -- prevent the default action from opening in a browser
    return false
  end
  -- otherwise, by not specifying a return value, we allow later
  -- handlers and ultimately the default action to caused the
  -- URI to be opened in the browser
end)

return {
  initial_cols = 140,
  initial_rows = 50,
  color_scheme = "MaterialDark",
  font_size = 15,
  font = wezterm.font("YaHei Consolas Hybrid"),
  keys = {
    {key="d", mods="CMD", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="d", mods="CMD|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "h", mods="CMD|SHIFT",
      action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "l", mods="CMD|SHIFT",
      action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "k", mods="CMD|SHIFT",
      action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "j", mods="CMD|SHIFT",
      action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="k", mods="CMD", action=wezterm.action{ClearScrollback="ScrollbackAndViewport"}},
    {key="w", mods="CTRL", action=wezterm.action{CloseCurrentPane={confirm=true}}},
  },
  mouse_bindings = {
    {
      event={Down={streak=1, button="Left"}},
      mods="CMD",
      action="OpenLinkAtMouseCursor",
    }
  }
}
