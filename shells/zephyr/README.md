## Description

This just exposes two devShells using the tool https://github.com/adisbladis/zephyr-nix.

Here my own zmk-facehugger fork is fetched and I can build and work on that repository.

For a more minimal one to just build any ZMK project, be it mine or another please refer to zmk.nix

zmk_kyria is meant to only build the [Kyria_v3](https://splitkb.com/products/kyria-rev3?srsltid=AfmBOopyPKodi5GlNRihgL_XJzkbbYXzAg3i0CLP-sA6dktRUKm5kRXN).

However I have mainly moved my development to using my mono-repo [zmk-config-facehugger](https://github.com/MatthewWinnan/zmk-config-facehugger).

### Archive

The archived development setup is partly based off of the one from https://github.com/moergo-sc/zmk/tree/main/nix

Further help was the blog from https://www.ericjjohnson.dev/blog/nix-with-zephyr-rtos/

The attempt at zephyr.nix and zephyr-sdk was me trying to get the zephyr-sdk into the nix store similar to Eric and
then use it from there.

From meorgo I ended up getting it to work with a generic arm-gnu compiler, however I wanted to actual arm-zephyr-eabi compiler
as used within the github actions.

One option would be to patch the ELF files so it does not look for libraries in standard path.
I ended up just using zephyr-nix.

`unused` is where I store my old solutions just so I can maybe refer to them in the future or if I want
to reinvent the wheel and try to package it myself again.
