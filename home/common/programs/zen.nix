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
      in
      {
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
