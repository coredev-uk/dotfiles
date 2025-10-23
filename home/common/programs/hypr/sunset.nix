_: {
  services.hyprsunset = {
    enable = true;
    settings = {
      profile = [
        {
          time = "7:30";
          identity = true;
        }
        {
          time = "20:00";
          temperature = 4500;
        }
        {
          time = "21:00";
          temperature = 4000;
        }
      ];
    };
  };
}
