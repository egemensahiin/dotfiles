# ----- Import modules in here ----- #
import os
import subprocess
from libqtile.config import Rule, Match, Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from typing import List  # noqa: F401


# ----- Mod key variable; mod1 for ALT key, mod4 for Super key ----- #
mod = "mod4"

# ----- Solarized Colors ----- #
# colorsc = ['#002b36', # 0 
#            '#073642', # 1
#            '#586e75', # 2
#            '#657b83', # 3
#            '#839496', # 4
#            '#93a1a1', # 5
#            '#eee8d5', # 6
#            '#fdf6e3', # 7
#            '#b58900', # 8
#            '#cb4b16', # 9
#            '#dc322f', # 10 
#            '#d33682', # 11
#            '#6c71c4', # 12
#            '#268bd2', # 13
#            '#2aa198', # 14
#            '#859900'] # 15

# ----- Gruvbox Colors ----- #
colorsc = ['#282828', # 0 
           '#cc241d', # 1
           '#98971a', # 2
           '#d79921', # 3
           '#458588', # 4
           '#b16286', # 5
           '#689d6a', # 6
           '#a89984', # 7
           '#928374', # 8
           '#fb4934', # 9
           '#b8bb26', # 10
           '#fabd2f', # 11
           '#83a598', # 12
           '#d3869b', # 13
           '#8ec07c', # 14
           '#ebdbb2',]# 15

# ----- List (literally a list) of key-bindings. Adjust them in here or append after if necessary ----- #
keys = [
    # Switch between windows in current stack pane
    # Use arrow keys. Dont like hjkl combination for navigating.
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "k", lazy.layout.up()),
 
    # # Move winsows up or down in current stack # conflict with bsp bindings
    # Key([mod, "control"], "Down", lazy.layout.shuffle_down()),
    # Key([mod, "control"], "Up", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("xfce4-terminal")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "q", lazy.window.kill()),

    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "e", lazy.shutdown()),
    Key([mod, "control"], "r", lazy.spawncmd('command')),
 
    # --- The rest are my own keys
    Key([mod], "d", lazy.spawn("rofi -show drun")),
    Key([mod, "shift"], "d", lazy.spawn("/home/egemen/.scripts/rofi_web.sh")),
    Key([mod, "shift"], "m", lazy.spawn("/home/egemen/.scripts/monitor_manager_2.py")),
    Key([mod], "p", lazy.spawn("pavucontrol")),
    Key([mod], "o", lazy.spawn("xfce4-terminal -e alsamixer")),
    Key([mod], "t", lazy.spawn("xfce4-terminal -e vim")),
    Key([mod], "b", lazy.spawn("prime-run qutebrowser")),
    Key([mod], "m", lazy.spawn("firefox")),
    Key([mod], "r", lazy.spawn("xfce4-terminal -e ranger")),
    Key([mod], "g", lazy.spawn("gimp")),
    Key([mod], "s", lazy.spawn("spotify")),
    Key([mod], "c", lazy.spawn("code-oss")),
    Key([mod], "v", lazy.spawn("VirtualBox")),
    Key([mod], "n", lazy.spawn("discord")),
    Key([], "Print", lazy.spawn("/home/egemen/.scripts/q_screenshot.sh")),
    Key([mod], "x", lazy.spawn("/home/egemen/.scripts/locker.sh")),
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # Should adjust left and right for bsp layout. feom qtile doc:
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "mod1"], "Up", lazy.layout.flip_down()),
    Key([mod, "mod1"], "k", lazy.layout.flip_down()),
    Key([mod, "mod1"], "Down", lazy.layout.flip_up()),
    Key([mod, "mod1"], "j", lazy.layout.flip_up()),
    Key([mod, "mod1"], "Left", lazy.layout.flip_left()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),
    Key([mod, "mod1"], "Right", lazy.layout.flip_right()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "control"], "Up", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_down()),
    Key([mod, "control"], "Down", lazy.layout.grow_up()),
    Key([mod, "control"], "j", lazy.layout.grow_up()),
    Key([mod, "control"], "Left", lazy.layout.grow_left()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "Right", lazy.layout.grow_right()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
 
    # Media keys:
    Key([], "XF86AudioRaiseVolume", lazy.spawn("ponymix --max-volume 150 increase 5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("ponymix --max-volume 150 decrease 5")),
    Key([], "XF86AudioMute", lazy.spawn("ponymix --max-volume 150 toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl --player=spotify,%any play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl --player=spotify,%any next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl --player=spotify,%any previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl --player=spotify,%any stop")),
 
    # Brightness keys:
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 10%+")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl --min-value=750 set 10%-")),

    # Other XF86Keys (XF86RFKill is working default, don't try to define that):
    Key([], "XF86Calculator", lazy.spawn("galculator")),
    Key([], "XF86TouchpadToggle", lazy.spawn("/home/egemen/.scripts/touchpad_controller.sh"))
]

# ----- My adjustment for groups (more charismatic) ----- #
list_of_groups = {"": "monadtall",
                  "": "monadtall",
                  "": "monadtall",
                  "": "monadtall",
                  "": "monadtall",
#                  "": "monadtall",
                  "": "monadtall",
                  "": "monadtall",
                  "  ": "monadtall",
                  "": "monadtall",
                  "": "monadtall"}

groups = [Group(i, layout=list_of_groups[i]) for i in list(list_of_groups.keys())]

for n, i in enumerate(list(list_of_groups.keys()), 0):
    keys.extend([
        Key([mod], str(n), lazy.group[i].toscreen()),
        Key([mod, "shift"], str(n), lazy.window.togroup(i, switch_group=True))
        ])

# ----- Assign applications to groups ----- #
assignments = {}
# assignments[""] = ["Xfce4-terminal", "xfce4-terminal"]
assignments[""] = ["Chromium", "chromium", "qutebrowser", "Qutebrowser", "Navigator", "Firefox"]
assignments[""] = ["Code-oss", "Geany", "Mousepad",
                    "code-oss", "geany", "mousepad"]
assignments[""] = ["Spotify", "spotify"]
# assignments[""] = ["pcmanfm", "Pcmanfm"]
assignments[""] = ["Mpv", "Gimp-2.10", "Inkscape", "Mplayer", "Vlc", "openshot-qt",
                    "Mpv", "gimp-2.10", "inkscape", "mplayer", "vlc", "openshot"]
# assignments[""] = ["Epdfview", "Et", "Wpp", "libreoffice-startcenter", "libreoffice-writer", "libreoffice-impress", "libreoffice-calc", "libreoffice-draw", "wps", "zathura",
#                     "epdfview", "et", "wpp", "Libreoffice-startcenter", "Libreoffice-writer", "Libreoffice-impress", "Libreoffice-calc", "Libreoffice-draw", "Wps", "Zathura",]
assignments["  " ] = ["PyMOL", "AGFRgui.py",
                       "pyMOL", "agfrgui.py"]
assignments[""] = ["VirtualBox Machine", "VirtualBox Manager"]

@hook.subscribe.client_new
def assign_app_group(client):
    wm_class = client.window.get_wm_class()[0]
    for i in list(assignments.keys()):
        if wm_class in assignments[i]:
            client.togroup(i)
            client.group.cmd_toscreen(toggle=False)

# ----- Layouts adjustment (Max, Tile and TreeTab are just fine enough) ----- #
layouts = [
    layout.Bsp(
        margin=10,
        border_width=0,
        border_normal=colorsc[0],
        border_focus=colorsc[8]
        ),
    # layout.Max(),
    layout.TreeTab(
        active_bg=colorsc[2],
        active_fg=colorsc[0],
        inactive_bg=colorsc[0],
        inactive_fg=colorsc[15],
        bg_color=colorsc[0],
        panel_width=100,
        font="Inconsolata Bold",
        font_size=12,
        ),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(
        margin=15, 
        border_width=0, 
        border_normal=colorsc[0], 
        border_focus=colorsc[8]
        ),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    # layout.Floating()
]

# ----- Widget and bar adjustment ----- #
widget_defaults = dict(
    font='Inconsolata Regular',
    fontsize=12,
    padding=3,
    background=colorsc[0],
)
# Mouse callbacks to use with widgets
def open_calendar(qtile):
    qtile.cmd_spawn("gsimplecal")
def monitor_manager(qtile):
    qtile.cmd_spawn("/home/egemen/.scripts/monitor_manager_2.py")

# I put my widgets here and call them with index if I want
widgets = [
    widget.GroupBox( # [0] --> Groups
        borderwidth=0,
        font="Font Awesome 5 Free Bold",
        fontsize=12,
        highlight_method='block',
        urgent_alert_method='block',
        foreground=colorsc[0],
        inactive=colorsc[7],
        active=colorsc[3],
        urgent_border=colorsc[1],
        block_highlight_text_color=colorsc[0],
        this_current_screen_border=colorsc[2]
        ),
    widget.Prompt( # [1] --> Prompt
        foreground=colorsc[14]
        ),
    widget.WindowName( # [2] --> Window name indicator
        foreground=colorsc[10],
        ),
    widget.TextBox( # [3] --> Text for Updates
        text='PAC:',
        foreground=colorsc[4]
        ),
    widget.Pacman( # [4] --> Updates
        foreground=colorsc[4]
        ),
    widget.CurrentLayoutIcon( # [5] --> Layout icon
        background=colorsc[1],
        scale=0.65,
        foreground=colorsc[0]
        ),
    widget.CurrentLayout( # [6] --> Layout name
        background=colorsc[1],
        foreground=colorsc[0],
        ),
    widget.Volume( # [7] --> Volume percentage
        background=colorsc[4],
        format='{percent: 2.0%}',
        foreground=colorsc[0],
        volume_app="alsamixer"
        ),
    widget.Backlight( # [8] --> Brightness percentage
        background=colorsc[3],
        backlight_name='intel_backlight',
        format='{percent: 2.0%}',
        foreground=colorsc[0]
        ),
    widget.Battery( # [9] --> Battery percentage
        background=colorsc[2],
        format='{char} {percent:2.0%}',
        foreground=colorsc[0],
        charge_char=' ',
        empty_char=' ',
        full_char=' ',
        discharge_char='',
        low_foreground=colorsc[1],
        update_interval=5,
        show_short_text=False
        ),
    widget.CapsNumLockIndicator( # [10] --> Caps/Num indicator
        foreground=colorsc[0],
        background=colorsc[3],
        ),
    widget.Clock( # [11] --> Time
        background=colorsc[5],
        format=' %H:%M:%S |  %d.%m.%Y %a',
        foreground=colorsc[0],
        mouse_callbacks={
            "Button1": open_calendar,
            "Button3": open_calendar,
            },
        ),
    widget.Clock( # [12] --> Date
        background=colorsc[12],
        format='DATE: %d.%m.%Y %a',
        foreground=colorsc[0]
        ),
    widget.Net( # [13] --> Network
        interface="wlp0s20f3",
        background=colorsc[15],
        foreground=colorsc[0],
        format=' {down}  {up}'
        ),
    widget.Memory( # [14] --> Memory usage
        background=colorsc[15],
        format='{MemUsed}M/{MemTotal}M |',
        foreground=colorsc[0]
        ),
    widget.CPU( # [15] --> CPU usage
        background=colorsc[15],
        foreground=colorsc[0],
        format=' {freq_current}GHz {load_percent}%'
        ),
    widget.DF( # [16] --> Free space
        format='HOME: {f}G',
        visible_on_warn=False,
        partition='/home',
        foreground=colorsc[4]
        ),
    widget.Systray( # [17] --> System tray
        background=colorsc[3],
        icon_size=10,
        ),
    widget.Sep( # [18] --> Seperator
        size_percent=50,
        foreground=colorsc[4]
        ),
    widget.Mpris2( # [19] --> Spotify player (I hope)
        background=colorsc[2],
        objname='org.mpris.MediaPlayer2.spotify',
        display_metadata=['xesam:title', 'xesam:artist'],
        foreground=colorsc[0],
        scroll_wait_intervals=10,
        ),
    widget.TextBox( # [20] --> Monitor setup
        text=' ',
        mouse_callbacks={
            'Button1': monitor_manager
            },
        background=colorsc[3],
        foreground=colorsc[0],
        ),
]

def text_before_wid(txt, bg=0, fg=4, fs=10, p=3):
    return widget.TextBox(
        background=colorsc[bg],
        font="Font Awesome 5 Free Bold",
        text=txt,
        foreground=colorsc[fg],
        fontsize=fs,
        padding=p,
    )

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widgets[0],  # Groups
                widgets[1],  # Prompt
                widgets[2],  # Window
                text_before_wid("", bg=0, fg=2, fs=20, p=0),
                text_before_wid(" ", bg=2, fg=0, fs=11, p=0),
                widgets[19], # Spotify indicator
                text_before_wid("", bg=2, fg=1, fs=20, p=0),
               # text_before_wid("", bg=0, fg=10, fs=20, p=0),
                widgets[5],  # LayoutIcon
                widgets[6],  # LayoutText 
                text_before_wid("", bg=1, fg=4, fs=20, p=0),
                text_before_wid("", bg=4, fg=0),
                widgets[7],  # Vol
                text_before_wid("", bg=4, fg=3, fs=20, p=0),
                widgets[8],  # Bri
                text_before_wid("", bg=3, fg=2, fs=20, p=0),
                widgets[9],  # Bat
                text_before_wid("", bg=2, fg=5, fs=20, p=0),
                widgets[11], # Time
                text_before_wid("", bg=5, fg=15, fs=20, p=0),
                text_before_wid("", bg=15, fs=11, fg=0, p=0),
                widgets[14], # Mem
                widgets[15], # CPU
                text_before_wid("", bg=15, fg=3, fs=20, p=0),
                widgets[17], # Systray
                widgets[20], # Monitor manager
                widgets[10], # CapsNumIndicator
            ],
            20,
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widgets[0],  # Groups
                widgets[1],  # Prompt
                widgets[2],  # Window
                text_before_wid("", bg=0, fg=2, fs=20, p=0),
                text_before_wid(" ", bg=2, fg=0, fs=11, p=0),
                widgets[19], # Spotify indicator
                text_before_wid("", bg=2, fg=1, fs=20, p=0),
               # text_before_wid("", bg=0, fg=10, fs=20, p=0),
                widgets[5],  # LayoutIcon
                widgets[6],  # LayoutText 
                text_before_wid("", bg=1, fg=4, fs=20, p=0),
                text_before_wid("", bg=4, fg=0),
                widgets[7],  # Vol
                text_before_wid("", bg=4, fg=3, fs=20, p=0),
                widgets[8],  # Bri
                text_before_wid("", bg=3, fg=2, fs=20, p=0),
                widgets[9],  # Bat
                text_before_wid("", bg=2, fg=5, fs=20, p=0),
                widgets[11], # Time
                text_before_wid("", bg=5, fg=15, fs=20, p=0),
                text_before_wid("", bg=15, fs=11, fg=0, p=0),
                widgets[14], # Mem
                widgets[15], # CPU
                text_before_wid("", bg=15, fg=3, fs=20, p=0),
                widgets[17], # Systray
                widgets[20], # Monitor manager
                widgets[10], # CapsNumIndicator
            ],
            20,
        ),
    ),
]

# ----- Mouse buttons for floating windows ----- #
# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# ----- And the other stuff that I don't give a shit about currently ----- #
dgroups_key_binder = None
dgroups_app_rules = []  # type: List

# ----- Default floating apps ----- #
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    # Theese one better float I guess:
    {'wmclass': 'Pavucontrol'},
    {'wmclass': 'Galculator'},
    {'wmclass': 'Gsimplecal'},
])

# ----- Builtin configuration variables ----- #
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
# There was a really long comment but I think it was a bit unnecessary.
wmname = "LG3D"

# ----- Autostart applications; adjust them with the shell script called autostart.sh of course ----- #
@hook.subscribe.startup_once
def autostart():
        home = os.path.expanduser('~/.scripts/autostart.sh')
        subprocess.call([home])
