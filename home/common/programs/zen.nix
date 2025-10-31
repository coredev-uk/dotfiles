{ config, ... }:
{
  programs.zen-browser = {
    enable = true;
    profiles."default" = {

      # User Containers (With Facebook Containers enabled)
      containersForce = false;
      containers = {
        Personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
        };
        Work = {
          color = "orange";
          icon = "briefcase";
          id = 2;
        };
        Banking = {
          color = "green";
          icon = "dollar";
          id = 3;
        };
        Shopping = {
          color = "pink";
          icon = "cart";
          id = 4;
        };
        Facebook = {
          color = "toolbar";
          icon = "fence";
          id = 6;
        };
        TikTok = {
          color = "toolbar";
          icon = "fence";
          id = 7;
        };
      };

      # User Spaces
      spacesForce = false;
      spaces =
        let
          inherit (config.programs.zen-browser.profiles."default") containers;
        in
        {
          Universal = {
            id = "01ec42f0-1bae-4c03-9ba4-9494b5ccd9f8";
            icon = "🌐";
            container = containers.Personal.id;
            position = 1000;
          };
          Programming = {
            id = "cdbae728-7886-4c52-9b38-4d93424a1eaf";
            icon = "💻";
            container = containers.Personal.id;
            position = 2000;
          };
          Work = {
            id = "727c9903-928e-4667-9757-6a54c0b445cd";
            icon = "💼";
            container = containers.Work.id;
            position = 3000;
          };
        };
    };
  };
}
