{
  self,
  inputs,
  outputs,
  stateVersion,
  username,
  flakePath,
  ...
}:
let
  helpers = import ./helpers.nix {
    inherit
      self
      inputs
      outputs
      stateVersion
      username
      flakePath
      ;
  };
in
{
  inherit (helpers) mkHome mkHost forAllSystems;
}
