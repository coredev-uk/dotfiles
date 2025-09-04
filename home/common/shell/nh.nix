{
  meta,
  ...
}:
{
  programs.nh = {
    enable = true;
    flake = "${meta.flakePath}";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 2";
    };
  };
}
