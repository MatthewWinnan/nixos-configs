{pkgs, inputs, lib, config, ...}:{
  
  imports = [
    ./nixvim/nixvim.nix
    ./hyprland.nix 
    ./pulseaudio.nix 
    ./greetd.nix
  ];
}