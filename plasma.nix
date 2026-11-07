{ userSettings, ... }:
let
defaultFont = { family = "Noto Sans"; pointSize = 10; };
in
{
  # Konsole configuration
  programs.konsole = {
    enable = true;
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
      lookAndFeel = "org.kde.breezedark.desktop";
      theme = "breeze-dark";
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
