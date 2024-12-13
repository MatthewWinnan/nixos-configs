## Introduction
Will be adding some more meat I just wanted to give the needed acknowledgements so far :)

## Special thanks to the following individuals

- [XNM1](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles)
    - I used the dot files here as an initial basis for my project and for general inspiration.
- [Sukhmancs](https://github.com/sukhmancs/nixos-configs)
    - Used the`rofi-wayland`config with my own`stylix`colors/overrides.
    - Used his`disko`config, specifically [luks-btrfs](https://github.com/sukhmancs/nixos-configs/tree/f7df37cd6f994be5e5cfbaa1bc9029b8a2399813/disko/luks-btrfs-subvolumes)
    - Taking inspiration for the nixvim config.
        - Currently using their LSP config.
    - Currently using their GIT config.
    - Using their Schizofox config for the most part.
- [Misterio77](https://github.com/Misterio77/nix-config/tree/5735a6e72064c57f6cb5370d99dae72098646671)
    - Took inspiration from his boiler plate nix-config.
    - My monitor definition comes directly from him.
- [Vimjoyer](https://github.com/vimjoyer)
    - His youtube videos are extremely good.
    - Used his LF setup video for mine ([Repo](https://github.com/vimjoyer/lf-nix-video), [Video](https://www.youtube.com/watch?v=z8y_qRUYEWU)).
    - A good video is his one on [Stylix](https://github.com/danth/stylix), I will be using this in conjunction with colors listed later on ([Video](https://www.youtube.com/watch?v=ljHkWgBaQWU)).
    - Yet another nix helper is also quite great, however I have moved my home manager to instead be used as a Nix module ([NH](https://github.com/viperML/nh), [Video](https://www.youtube.com/watch?v=DnA4xNTrrqY&t=298s)).
    - Gaming on NixOS helped me get a decent enough introduction on what was needed ([Video](https://www.youtube.com/watch?v=qlfm3MEbqYA))
- [Ampersand](https://www.youtube.com/@Ampersand-xc9jp)
    - Makes some good Nix content too.
    - His intro [video](https://www.youtube.com/watch?v=nLwbNhSxLd4&t=832s) helped a ton.
    - His [repo](https://github.com/Andrey0189/nixos-config) took most of my initial nixvim setup from here and used this as my main overall starting point.
- [Catppuccin](https://github.com/catppuccin/nix)
    - Currently using their Macchiato color pallet with Stylix.
    - Based my hyprlock off of their example and using logo images.
    - Based my wlogout from their examples, took the same logos.
    - Based my waybar off of it might change back to something else.
- [NixOS Hardware](https://github.com/NixOS/nixos-hardware)
    - For their sensible defaults and optimizations to get my Legion Y530-15ICH working.
- And in general to the wonderful Nix community, will be adding more acknowledgements and will try my best to at least add them to the
code snippets :D

## Imperative Operations

As of yet not everything within the setup process has been fully automated and or declared declaratively.
To this end this section will document what needs to be done by hand.

- During the Disko setup phase one needs to manually add the sector block numbers. For some reason the values 100\% for example
get valuated as the raw string and not relative to the partition I am defining.
- Obviously the password for the LUKS encryption needs to be done during installation.
- nixos-install does not create a user password or non-root user for me. As such you have to use the command `passwd -p username` to set the created user after installing
the specific machine's flakes as root.
    - One can add this to the config from which it installs.
    - I can check if there is a way during the initial installation to have nixos-install install from a specific flakes instead?
    - Have a dummy config just for this purposes?
- Chrome's plugins are still being imperatively managed by me. It is not my default browser but worth noting.
- Signing in to either of the browsers is still done imperatively, there is no plans or desire to change this.
- VSCode has declarative plugins that I use, however I had trouble with them not starting and version mismatching on unstable as such I enable imperative installation
of plugins/extensions and manage some of my broken plugins/extension like that.
    - The obvious solution to this would be to find out why it breaks or pin a working version, pinning has not worked as of yet.
- The monitor setup config at ./settings/[machine_name]/config.nix has to be done by hand after installation. This is due to needing to know
the specific monitor ID's for my environment which seems to change at times.
- The initial Git-Hub setup needs to be done imperatively.
    - I do want to automate this, will probably use SOPS for this, however sops relies on me having some key somewhere at anyrate.
- Nix gaming will be done mostly imperatively due to the rolling update nature of Steam.
