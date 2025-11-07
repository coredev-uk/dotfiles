{ config, ... }:
{
  programs.zen-browser = {
    enable = true;

    languagePacks = [
      "en-GB"
    ];

    policies =
      let
        mkExtensionSettings = builtins.mapAttrs (
          _: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
          }
        );
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );
      in
      {
        # Standard Policies
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        TranslateEnabled = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        # Preferences
        Preferences = mkLockedAttrs {
          "browser.tabs.warnOnClose" = false;
          # and so on...
        };

        # Extensions
        ExtensionSettings = mkExtensionSettings {
          # Dark Reader
          "addon@darkreader.org" = "darkreader";
          # YouTube
          "sponsorBlocker@ajay.app" = "sponsorblock";
          # Cookies
          "jid1-KKzOGWgsW3Ao4Q@jetpack" = "i-dont-care-about-cookies";
          # Proton
          "78272b6fa58f4a1abaac99321d503a20@proton.me" = "proton-pass";
          "vpn@proton.ch" = "proton-vpn";
          # Refined GitHub
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = "refined-github";
          # Wappalyzer
          "wappalyzer@crunchlabz.com" = "wappalyzer";
          # AdBlocker
          "uBlock0@raymondhill.net" = "ublock-origin";
        };
      };

    profiles."default" = {
      name = "Default";
      isDefault = true;

      # User Containers (With Facebook Containers enabled)
      containersForce = true;
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
      spacesForce = true;
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
            theme = {
              type = "gradient";
              opacity = 0.5;
              rotation = null;
              texture = 0.0;
              colors = [
                {
                  red = 127;
                  green = 72;
                  blue = 26;
                  custom = false;
                  algorithm = "analogous";
                  lightness = 30;
                  position = {
                    x = 237;
                    y = 210;
                  };
                }
                {
                  red = 77;
                  green = 125;
                  blue = 28;
                  custom = false;
                  algorithm = "analogous";
                  lightness = 30;
                  position = {
                    x = 181;
                    y = 247;
                  };
                }
                {
                  red = 122;
                  green = 31;
                  blue = 78;
                  custom = false;
                  algorithm = "analogous";
                  lightness = 30;
                  position = {
                    x = 244;
                    y = 143;
                  };
                }
              ];
            };
          };
          Programming = {
            id = "cdbae728-7886-4c52-9b38-4d93424a1eaf";
            icon = "💻";
            container = containers.Personal.id;
            position = 2000;
            theme = {
              type = "gradient";
              opacity = 0.578;
              rotation = null;
              texture = 0.0;
              colors = [
                {
                  red = 11;
                  green = 68;
                  blue = 162;
                  custom = false;
                  algorithm = "complementary";
                  lightness = 16;
                  position = {
                    x = 131;
                    y = 143;
                  };
                }
                {
                  red = 75;
                  green = 40;
                  blue = 7;
                  custom = false;
                  algorithm = "complementary";
                  lightness = 16;
                  position = {
                    x = 207;
                    y = 195;
                  };
                }
              ];
            };
          };
          Work = {
            id = "727c9903-928e-4667-9757-6a54c0b445cd";
            icon = "💼";
            container = containers.Work.id;
            position = 3000;
            theme = {
              type = "gradient";
              opacity = 0.635;
              rotation = null;
              texture = 0.5;
              colors = [
                {
                  red = 131;
                  green = 73;
                  blue = 122;
                  custom = false;
                  algorithm = "analogous";
                  lightness = 40;
                  position = {
                    x = 265;
                    y = 79;
                  };
                }
                {
                  red = 138;
                  green = 68;
                  blue = 66;
                  custom = false;
                  algorithm = "analogous";
                  lightness = 40;
                  position = {
                    x = 300;
                    y = 185;
                  };
                }
                {
                  red = 96;
                  green = 80;
                  blue = 124;
                  custom = false;
                  algorithm = "analogous";
                  lightness = 40;
                  position = {
                    x = 162;
                    y = 38;
                  };
                }
              ];
            };
          };
        };
    };
  };
}
