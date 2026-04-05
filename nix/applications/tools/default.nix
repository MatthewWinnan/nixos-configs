{ inputs, ... }:
{
  imports = [
    ./nh.nix
    ./wireshark.nix
    ./bandwhich.nix
    ./localsend.nix
  ];
}
