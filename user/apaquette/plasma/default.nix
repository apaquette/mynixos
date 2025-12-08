{ ... }:
{
  programs.plasma = {
    enable = true;

    # NumLock by default
    input.keyboard.numlockOnStartup = "on";

    krunner.position = "center";

    configFile = {
      kscreenlockerrc.Daemon.Autolock = false;
      kscreenlockerrc.Daemon.Timeout = 0;

      kscreenlockerrc."Greeter/Wallpaper/org.kde.image/General".Image = "Illium.jpg";
      kscreenlockerrc."Greeter/Wallpaper/org.kde.image/General".PreviewImage = "Illium.jpg";

      kcminputrc.Mouse.cursorSize = 18;
      kcminputrc.Mouse.cursorTheme = "Breeze_Light";

      kdeglobals.Icons.Theme = "YAMIS";
      kdeglobals.KDE.widgetStyle = "Breeze";


    #   # KDE Wallet
    #   kwalletrc.Wallet."Close When Idle" = false;
    #   kwalletrc.Wallet."Close on Screensaver" = false;
    #   kwalletrc.Wallet.Enabled = true;
    #   kwalletrc.Wallet."First Use" = false;
    #   kwalletrc.Wallet."Idle Timeout" = 10;
    #   kwalletrc.Wallet."Launch Manager" = false;
    #   kwalletrc.Wallet."Leave Manager Open" = false;
    #   kwalletrc.Wallet."Leave Open" = true;
    #   kwalletrc.Wallet."Prompt on Open" = false;
    #   kwalletrc.Wallet."Use One Wallet" = true;
    #   kwalletrc."org.freedesktop.secrets".apiEnabled = true;
      
      # KWINRC
      kwinrc.Effect-overview.BorderActivate = 3;
      kwinrc.Plugins.desktopchangeosdEnabled = false;
      kwinrc.Plugins.krohnkiteEnabled = false;
      kwinrc.Tiling.padding = 4;
      kwinrc."Tiling/0c949489-e31b-56a4-ba24-9cff9e6cd932".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      kwinrc.Windows.RollOverDesktops = true;
      kwinrc.Xwayland.Scale = 1.3;
      kwinrc."org.kde.kdecoration2".BorderSize = "None";
      kwinrc."org.kde.kdecoration2".BorderSizeAuto = false;
      kwinrc."org.kde.kdecoration2".theme = "Breeze";

      plasma-localerc.Formats.LANG = "en_CA.UTF-8";

       plasmarc.Theme.name = "JuxPlasma";
       plasmarc.Wallpapers.usersWallpapers = "Wallpaper.png";
     };
    };
  }