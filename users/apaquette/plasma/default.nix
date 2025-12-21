{ 
  userSettings,
  ... 
}:
let
defaultFont = { family = "Noto Sans"; pointSize = 10; };
in
{
  # Konsole configuration
  programs.konsole = {
    enable = true;
    # profiles = {

    # };
    # defaultProfile = ""
  };

  # Plasma Desktop
  programs.plasma = {
    enable = true;

    # Input & Output
    # Keyboard
    input.keyboard.numlockOnStartup = "on";


    # Appearance and Style
    # Wallpapaer

    #Animations
    kwin.effects = {
      desktopSwitching.animation = "slide";
      desktopSwitching.navigationWrapping = true;
      shakeCursor.enable = false;
      windowOpenClose.animation = "scale";
    };

    # Text & Fonts
    fonts = {
      general = defaultFont;
      fixedWidth = {
        family = "Hack";
        pointSize = defaultFont.pointSize;
      };
      small = {
        family = defaultFont.family;
        pointSize = 8;
      };
      toolbar = defaultFont;
      menu = defaultFont;
      windowTitle = defaultFont;
    };

    # Apps & Windows

    # Window Management
    kwin.virtualDesktops.names = [
      "Home"
      "Nix Configs"
      "Job Search"
      "Dev"
    ];
    kwin.virtualDesktops.number = 4;

    # Need to figure out how to create an apply Window Rules
    # window-rules = [
    #   {

    #     apply = true;
    #   }
    # ];

    panels = [
      {
        location = "top";
        height = 20;
        alignment = "center";
        hiding = "none";
        lengthMode = "fill";
        opacity = "adaptive";
        widgets = [
          "org.kde.plasma.globalmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "luisbocanegra.panel.colorizer"
        ];
      }
      {
        location = "right";
        height = 60;
        alignment = "center";
        hiding = "autohide";
        lengthMode = "fit";
        opacity = "adaptive";
        widgets = [
          "org.kde.plasma.icontasks"
        ];
      }
    ];

    # Security & Privacy
    # Screen Locker
    kscreenlocker = {
      appearance = {
        showMediaControls = true;
        alwaysShowClock = true;
        # setting the wallpaper for the lock screen isn't working :(
        wallpaper = "/home/${userSettings.username}/.dotfiles/users/${userSettings.username}/plasma/Wallpaper.png;";
      };
    };


    workspace = {
      cursor = {
        animationTime = 5;
        cursorFeedback = "Bouncing";
        size = 18;
        taskManagerFeedback = true;
        theme = "Breeze_Light";
      };
      #how to use a custom icon set?
      # icons = "";
      lookAndFeel = "org.kde.breezedark.desktop";
      theme = "breeze-dark";
      wallpaper = "/home/${userSettings.username}/.dotfiles/users/${userSettings.username}/plasma/Wallpaper.png";
    };
  
    # KRunner
    krunner = {
      activateWhenTypingOnDesktop = true;
      position = "center";
      historyBehavior = "enableSuggestions";
      shortcuts.launch = "Meta";
    };
    };
}