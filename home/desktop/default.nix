{config, lib, ...}: {
  
  imports = [
    ./dunst.nix
    ./hypr/default.nix
    ./wlogout/wlogout.nix
  ];

}
