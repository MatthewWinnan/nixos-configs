## Description

The following development setup is partly based off of the one from https://github.com/moergo-sc/zmk/tree/main/nix

Further help was the blog from https://www.ericjjohnson.dev/blog/nix-with-zephyr-rtos/

The attempt at zephyr.nix and zephyr-sdk was me trying to get the zephyr-sdk into the nix store similar to Eric and
then use it from there.

From meorgo I ended up getting it to work with a generic arm-gnu compiler, however I wanted to actual arm-zephyr-eabi compiler
as used within the github actions.

One option would be to patch the ELF files so it does not look for libraries in standard path, however I found a solution in
https://github.com/adisbladis/zephyr-nix that does most for me.

This final implementation if found within default.nix

Here my own zmk-facehugger fork is fetched and I can build and work on that repository.

For a more minimal one to just build any ZMK project, be it mine or another please refer to zmk.nix

Specific build environments for differing boards will be denoted as zmk_\[board\].nix
