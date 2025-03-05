_: {

  window_v1 = [
    # Floating Windows
    "float, file_progress"
    "float, confirm"
    "float, dialog"
    "float, download"
    "float, notification"
    "float, error"
    "float, splash"
    "float, nm-connection-editor"
    "float, viewnior"
    "float, confirmreset"
    "float, title:Open File"
    "float, title:^(Media viewer)$"
    "float, title:^(Volume Control)$"
    "float, title:^(Picture-in-Picture)$"
    "size 800 600, title:^(Volume Control)$"
  ];

  window_v2 = [
    # Floating Windows
    "float,class:^$,title:^$"
    "noinitialfocus,class:^$,title:^$"

    # Miscellaneous
    "center, class:^(polkit-gnome-authentication-agent-1)$"
    "center, title:^(.*notificationtoasts*.)$"

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
