_: {
  services.gammastep = {
    enable = true;

    provider = "manual";

    tray = true;

    latitude = 51.50605057576348;
    longitude = -0.131601896747958;

    temperature = {
      day = 5700;
      night = 3500;
    };

    settings = {
      general = {
        # gamma = 0.8;
        adjusstment-method = "randr";
      };
    };
  };

}
