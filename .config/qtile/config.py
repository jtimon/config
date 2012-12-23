from libqtile.manager import Key, Screen, Group
from libqtile.command import lazy
from libqtile import layout, bar, widget

shift_key = "shift"
control_key = "control"
alt_key = "mod1"
super_key = "mod4"

keys = [
    # Switch between windows in current stack pane
    # Key(
    #     [super_key], "k",
    #     lazy.layout.down()
    # ),
    # Key(
    #     [super_key], "j",
    #     lazy.layout.up()
    # ),

    # Move windows up or down in current stack
    Key(
        [alt_key, control_key], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [alt_key, control_key], "j",
        lazy.layout.shuffle_up()
    ),

# MOVEMENT KEYS
    # windows style alt-tab/alt-shift-tab
    Key([alt_key], "Tab", lazy.layout.down()),
    Key([alt_key, shift_key], "Tab", lazy.layout.up()),

    # # Move windows up or down in current stack
    # Key(
    #     [alt_key, "Tab"], 
    #     lazy.layout.shuffle_down()
    # ),
    # Key(
    #     [alt_key, shift_key, "Tab"], 
    #     # [super_key, control_key], "j",
    #     lazy.layout.shuffle_up()
    # ),

    # Switch window focus to other pane(s) of stack
    Key(
        [super_key], "space",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [super_key, shift_key], "space",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with multiple stack panes
    Key(
        [super_key, shift_key], "Return",
        lazy.layout.toggle_split()
    ),
    Key([super_key], "h",      lazy.to_screen(1)),
    Key([super_key], "l",      lazy.to_screen(0)),
    Key([super_key], "Return", lazy.spawn("xterm")),

    # Toggle between different layouts as defined below
    Key([super_key], "Tab",    lazy.nextlayout()),
    Key([super_key, shift_key], "q", lazy.window.kill()),

    Key([super_key, control_key], "r", lazy.restart()),
]

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    # Group("6"),
    # Group("7"),
    # Group("8"),
    # Group("9"),
    # Group("0"),
]
for i in groups:
    # mod4 + letter of group = switch to group
    keys.append(
        Key([super_key], i.name, lazy.group[i.name].toscreen())
    )

    # mod4 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([super_key, shift_key], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.Max(),
    layout.Stack(stacks=5)
]

screens = [
    Screen(
        top = bar.Bar(
                    [
                        widget.GroupBox(),
                        widget.WindowName(),
                        # widget.TextBox("default", "default config"),
                        widget.Systray(),
                        widget.Clock('%Y-%m-%d %a %I:%M %p'),
                    ],
                    30,
                ),
    ),
]

main = None
follow_mouse_focus = True
cursor_warp = False
floating_layout = layout.Floating()
mouse = ()

