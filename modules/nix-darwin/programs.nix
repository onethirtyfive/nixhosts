{ config, ... }:
let
  hmCfg = config.home-manager;
in
{
  programs.zsh.enable = true;
  programs.nix-index.enable = false;

  environment.shells = [
    hmCfg.users.${config.system.primaryUser}.programs.zsh.package
  ];
}
