from libqtile.manager import Key, Screen, Group
from libqtile.command import lazy
from libqtile import layout, bar, widget

keys = [
    # Switch between windows in current stack pane
    Key(
        ["mod4"], "k",
        lazy.layout.down()
    ),
    Key(
        ["mod4"], "j",
        lazy.layout.up()
    ),


# MOVEMENT KEYS
    # windows style alt-tab/alt-shift-tab
    Key([alt], "Tab", lazy.layout.next()),
    Key([alt, "shift"], "Tab", lazy.layout.previous()),

    # # Move windows up or down in current stack
    # Key(
    #     ["mod1", "Tab"], 
    #     lazy.layout.shuffle_down()
    # ),
    # Key(
    #     ["mod1", "shift", "Tab"], 
    #     # ["mod4", "control"], "j",
    #     lazy.layout.shuffle_up()
    # ),

    # Switch window focus to other pane(s) of stack
    Key(
        ["mod4"], "space",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        ["mod4", "shift"], "space",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with multiple stack panes
    Key(
        ["mod4", "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key(["mod4"], "h",      lazy.to_screen(1)),
    Key(["mod4"], "l",      lazy.to_screen(0)),
    Key(["mod4"], "Return", lazy.spawn("xterm")),

    # Toggle between different layouts as defined below
    Key(["mod4"], "Tab",    lazy.nextlayout()),
    Key(["mod4"], "w",      lazy.window.kill()),

    Key(["mod4", "control"], "r", lazy.restart()),
]

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8"),
    Group("9"),
    Group("0"),
]
for i in groups:
    # mod4 + letter of group = switch to group
    keys.append(
        Key(["mod4"], i.name, lazy.group[i.name].toscreen())
    )

    # mod4 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key(["mod4", "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.Max(),
    layout.Stack(stacks=2)
]

screens = [
    Screen(
        bottom = bar.Bar(
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

