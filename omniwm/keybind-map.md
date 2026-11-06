# OmniWM keybind mapping (from aerospace/.aerospace.toml)

OmniWM settings live in `~/.config/omniwm/settings.toml` + GUI (Settings > Keyboard Shortcuts).
Modifier `Alt` = Option. OmniWM uses `Hyper` = Ctrl+Option+Shift+Cmd by default.

## Layout
- alt-/ -> (Niri/Dwindle toggle per workspace) `Toggle Workspace Layout`
- alt-, -> (accordion) not 1:1; use Niri tabbed containers
- alt-space -> toggle float/tiling
- alt-shift-f -> fullscreen

## Focus (hjkl)
- alt-h/j/k/l -> Focus Left/Down/Up/Right

## Move
- alt-shift-h/j/k/l -> Move Left/Down/Up/Right

## Resize
- alt-- / alt-= -> resize smart
- alt-shift-r mode -> resize mode (use cycle-size / omniwmctl command cycle-size)

## Workspaces
- alt-1..9, alt-a,d,e,m,n,o,p,q,r,s,u,v,x,y,z -> switch-workspace <n>
- alt-tab -> switch-workspace back-and-forth
- alt-shift-tab -> move-workspace-to-monitor next
- alt-shift-1..9,b,c,d,e,g,m,n,o,p,q,s,t,u,v,w,x,y,z -> move-to-workspace <n>

## Apps
- alt-b -> Firefox, alt-c -> Calculator, alt-f -> Finder, alt-g/t -> Ghostty, alt-w -> WhatsApp

## Window mgmt
- alt-shift-0 -> close window

## Modes
- alt-shift-; -> (OmniWM has no modal modes; use command palette)
- alt-shift-a -> abbesion mode (move) -> not 1:1
- alt-shift-r -> resize mode -> use cycle-size

## Floating rules (on-window-detected)
- Calculator, System Settings, Activity Monitor, Calendar, Finder, OpenSuperWhisper, Orion Preview -> floating

## Notes
- Disable AeroSpace before enabling OmniWM to avoid double-management.
- SketchyBar stopped; OmniWM has its own bar + menu-bar concealment.
