_: {
  commands = [
    # Floating window config
    {
      command = "floating enable";
      criteria = {
        window_role = "pop up|bubble|task_dialog|Preferences|page-info|Saves As|dialog|menu";
      };
    }
    {
      command = "floating enable";
      criteria = {
        instance = "org.gnome.*|nm-connection-editor|pavucontrol|com.saivert.pwvucontrol|pinentry-qt|^code$";
      };
    }
    {
      command = "floating enable";
      criteria = {
        title = "Picture-in-picture|1Password";
      };
    }
    {
      command = "floating enable";
      criteria = {
        class = "1Password";
      };
    }
    {
      command = "floating enable";
      criteria = {
        title = "^Steam Settings$";
      };
    }
    {
      # Star Citizen Launcher
      command = "floating enable";
      criteria = {
        class = "rsi launcher.exe";
      };
    }
    # Floating & Sticky windows
    {
      command = "floating enable sticky";
      criteria = {
        window_role = "Open Files|Open Folder|File Operation Progress";
      };
    }
    # Sticky windows
    {
      command = "sticky enable";
      criteria = {
        instance = "^code$";
      };
    }
    {
      command = "sticky enable";
      criteria = {
        instance = "file_progress";
      };
    }
    {
      command = "sticky enable";
      criteria = {
        class = "info|Mate-color-select|gcolor2|timesup|QtPass|GtkFileChooserDialog";
      };
    }
    # Inhibit idle when there is a fullscreen app
    {
      command = "inhibit_idle fullscreen";
      criteria = {
        class = ".*";
      };
    }
  ];
}
