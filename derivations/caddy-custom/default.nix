# Custom Caddy build with security plugins
# Uses xcaddy to build Caddy with additional modules
{
  pkgs,
  lib,
  ...
}: let
  # Build custom Caddy with plugins
  caddyWithPlugins = pkgs.caddy.withPlugins {
    plugins = [
      # Block/manipulate AI crawlers and scrapers
      # https://github.com/JasonLovesDoggo/caddy-defender
      "github.com/JasonLovesDoggo/caddy-defender"
    ];
    hash = lib.fakeHash; # Will need to be updated after first build
  };
in
  caddyWithPlugins
