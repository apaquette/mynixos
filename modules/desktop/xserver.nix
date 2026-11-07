{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "colemak";
      options = "caps:backspace";
    };
  };
}
