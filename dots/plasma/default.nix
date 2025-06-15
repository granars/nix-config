{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  home.packages = with pkgs; [ 
    (catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["lavender"];
    })
    kara
    kde-rounded-corners
    kdePackages.krohnkite
    kdotool
    tela-circle-icon-theme
    ];

   programs.plasma = {
    enable = true;

    fonts = {
      fixedWidth = {
        family = "JetBrainsMono Nerd Font Mono";
        pointSize = 11;
      };
      general = {
        family = "Roboto";
        pointSize = 11;
      };
      menu = {
        family = "Roboto";
        pointSize = 11;
      };
      small = {
        family = "Roboto";
        pointSize = 8;
      };
      toolbar = {
        family = "Roboto";
        pointSize = 11;
      };
      windowTitle = {
        family = "Roboto";
        pointSize = 11;
      };
    };

    krunner.activateWhenTypingOnDesktop = false;

    kwin = {
      effects = {
        blur.enable = false;
        cube.enable = false;
        desktopSwitching.animation = "off";
        dimAdminMode.enable = false;
        dimInactive.enable = false;
        fallApart.enable = false;
        fps.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        slideBack.enable = false;
        snapHelper.enable = false;
        translucency.enable = false;
        windowOpenClose.animation = "off";
        wobblyWindows.enable = false;
      };

      nightLight = {
        enable = true;
        location.latitude = "51";
        location.longitude = "0";
        mode = "location";
        temperature.night = 4000;
      };

      virtualDesktops = {
        number = 5;
        rows = 1;
      };
    };

    panels = [
      {
        floating = true;
        height = 34;
        lengthMode = "fill";
        location = "top";
        screen = "all";
        opacity = "translucent";
        widgets = [
          {
            name = "org.dhruv8sh.kara";
            config = {
              general = {
                animationDuration = 0;
                spacing = 3;
                type = 1;
              };
              type1 = {
                fixedLen = 3;
                labelSource = 0;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                dateDisplayFormat = "BesideTime";
                dateFormat = "custom";
                use24hFormat = 2;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            systemTray = {
              items = {
                showAll = false;
                shown = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.brightness"
                ];
                hidden = [
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.devicenotifier"
                  "plasmashell_microphone"
                ];
                configs = {
                  "org.kde.plasma.notifications".config = {
                    Shortcuts = {
                      global = "Meta+V";
                    };
                  };
                };
              };
            };
          }
        ];
      }
    ];

    powerdevil = { 
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = false;
        powerButtonAction = "shutDown";
        turnOffDisplay.idleTimeout = 600;
      };
      battery = {
        autoSuspend.action = "sleep";
        dimDisplay.enable = true;
        powerButtonAction = "shutDown";
        turnOffDisplay.idleTimeout = 300;
      };
    };

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    shortcuts = {

      kwin = {
        "Overview" = "Meta+A";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Window Move Center" = "Ctrl+Alt+C";
        "Window Close" = "Meta+Q";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
      };

      plasmashell = {
        "show-on-mouse-pos" = "Alt+Shift+V";
      };

      "services/org.kde.dolphin.desktop"."_launch" = "Meta+Shift+F";
    };

    spectacle = {
      shortcuts = {
        captureEntireDesktop = "Meta+Ctrl+S";
        captureRectangularRegion = "Meta+Shift+S";
        recordRegion = "Meta+Shift+R";
      };
    };

    window-rules = [
      {
        apply = {
          noborder = {
            value = true;
            apply = "initially";
          };
        };
        description = "Hide titlebar by default";
        match = {
          window-class = {
            value = ".*";
            type = "regex";
          };
          window-types = ["normal"];
        };
      }
    ];

    workspace = {
      enableMiddleClickPaste = false;
      clickItemTo = "select";
      colorScheme = "CatppuccinMoccaLavender";
      cursor.theme = "Breeze";
      splashScreen.engine = "none";
      splashScreen.theme = "none";
      tooltipDelay = 1;
      wallpaper = ../../fluff/wallpapers/wallpaper.png;
    };

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      kdeglobals = {
        Icons = {
          Theme = "Tela-circle-dark";
        };
        KDE = {
          AnimationDurationFactor = 0;
        };
      };
      klipperrc.General.MaxClipItems = 1000;
      kiorc.Confirmations.ConfirmDelete = false;
      kwinrc = {
        Effect-overview.BorderActivate = 9;
        Plugins = {
          krohnkiteEnabled = true;
        };
        "Round-Corners" = {
          ActiveOutlineAlpha = 255;
          ActiveOutlineUseCustom = false;
          ActiveOutlineUsePalette = true;
          ActiveSecondOutlineUseCustom = false;
          ActiveSecondOutlineUsePalette = true;
          DisableOutlineTile = false;
          DisableRoundTile = false;
          InactiveCornerRadius = 8;
          InactiveOutlineAlpha = 0;
          InactiveOutlineUseCustom = false;
          InactiveOutlineUsePalette = true;
          InactiveSecondOutlineAlpha = 0;
          InactiveSecondOutlineThickness = 0;
          OutlineThickness = 1;
          SecondOutlineThickness = 0;
          Size = 8;
        };
        "Script-krohnkite" = {
          floatingClass = "ulauncher,brave-nngceckbapebfimnlniiiahkandclblb-Default";
          screenGapBetween = 3;
          screenGapBottom = 3;
          screenGapLeft = 3;
          screenGapRight = 3;
          screenGapTop = 3;
        };
        Windows = {
          DelayFocusInterval = 0;
          FocusPolicy = "FocusFollowsMouse";
        };
      };
      spectaclerc = {
        Annotations.annotationToolType = 8;
        General = {
          launchAction = "DoNotTakeScreenshot";
          showCaptureInstructions = false;
          showMagnifier = "ShowMagnifierAlways";
        };
        ImageSave.imageCompressionQuality = 100;
      };
    };
    dataFile = {
      "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
      "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
    };
  };
}