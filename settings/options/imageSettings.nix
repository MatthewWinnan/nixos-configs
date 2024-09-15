{ lib, ... }:

let
  inherit (lib.types) path attrsOf;
in {
  options = {
    images = lib.mkOption {
      type = attrsOf path;
      description = "A set of image files used for theming.";
    };
  };
}
