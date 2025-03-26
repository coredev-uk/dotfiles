_: {
  window_v2 = [
    # Floating Windows
    "float,class:^$,title:^$"
    "noinitialfocus,class:^$,title:^$"

    # Miscellaneous
    "center, class:^(polkit-gnome-authentication-agent-1)$"
    "center, title:^(.*notificationtoasts*.)$"

    # Picture-in-Picture
    "float, title:^(Picture-in-Picture|Firefox)$"
    "size 800 450, title:^(Picture-in-Picture|Firefox)$"
    "pin, title:^(Picture-in-Picture|Firefox)$"
    "move 100%-850 100%-500, title:^(Picture-in-Picture|Firefox)$"

    # Wine
    "move 0 0, title:^(Wine System Tray)$"
    "size 0 0, title:^(Wine System Tray)$"

    # Steam
    "noanim, class:^(steam)$"
    "center, title:[^\s],initialClass:^(steam)$"
    "stayfocused, title:^()$,class:^(steam)$"
    "minsize 1 1, title:^()$,class:^(steam)$"
    "float, title:^(Steam Settings)$,initialClass:^(steam)$"
    "float, title:^(Friends List)$,initialClass:^(steam)$"
    "size 325 550, title:^(Friends List)$,initialClass:^(steam)$"
    "pin, title:^(Steam Settings)$,initialClass:^(steam)$"
    "pin, title:^(.*Dialog*.)$,initialClass:^(steam)$"
    "pin, title:^(Shutdown)$,initialClass:^(steam)$"
    "pin, title:^(.*Sign in to Steam*.)$,initialClass:^(steam)$"

    # Games
    "immediate, class:^(cs2)$"

    # xwaylandvideobridge
    "opacity 0.0 override,class:^(xwaylandvideobridge)$"
    "noanim,class:^(xwaylandvideobridge)$"
    "noinitialfocus,class:^(xwaylandvideobridge)$"
    "maxsize 1 1,class:^(xwaylandvideobridge)$"
    "noblur,class:^(xwaylandvideobridge)$"
  ];
}
