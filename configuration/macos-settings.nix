{ ... }:
{
  # keyboard function
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;

  # mouse function
  system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls = false;
  system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = false;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  system.defaults.NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
  system.defaults.NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = null;

  # user interface
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.AppleFontSmoothing = 1;
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "Always";
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  # reorg dock prefs; others to follow
  system.defaults = {
    dock = {
      orientation = "left";
      autohide = true;
      autohide-delay = 1000.0;
      autohide-time-modifier = 0.5;

      appswitcher-all-displays = true;
      mru-spaces = false; # do not auto-arrange spaces, thanks.
    };
  };

  system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Basso.aiff";

  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
  system.defaults.NSGlobalDomain.NSScrollAnimationEnabled = true;
  system.defaults.NSGlobalDomain.NSWindowResizeTime = 0.01;
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
  system.defaults.NSGlobalDomain.NSTextShowsControlCharacters = true;
  system.defaults.NSGlobalDomain.NSUseAnimatedFocusRing = false;
  system.defaults.NSGlobalDomain."com.apple.springing.enabled" = false;
  system.defaults.NSGlobalDomain."com.apple.springing.delay" = 0.5;

  # autocorrect
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # applications
  system.defaults.NSGlobalDomain.NSDisableAutomaticTermination = true;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
  system.defaults.screencapture.location = "/tmp";

  # activity monitor defaults
  system.defaults.ActivityMonitor.ShowCategory = 103;
  system.defaults.ActivityMonitor.IconType = 3;
  system.defaults.ActivityMonitor.SortColumn = "CPUUsage";
  system.defaults.ActivityMonitor.SortDirection = 0;
  system.defaults.ActivityMonitor.OpenMainWindow = true;

  system.defaults.CustomUserPreferences = {
    "NSGlobalDomain" = {
      "TISRomanSwitchState" = 1;
      "MiniaturizedOnDoubleClick" = 1;
      "com.apple.trackpad.forceClick" = false;
    };

    # troubleshoot these settings...
    # in the meantime, set them manually.

    # 1. disable "automatically rearrange spaces!"
    # 2. enable "when switching, switch to a space with open..."
    # 3. displays do not have separate spaces
    # 4. "Keybaord Shortcuts" -> "Modifier Keys"; make "Caps Lock" "esc"
    # 5. reduce motion in accessibility
    # 6. green tint "color tint"; "spring", "33%" intensity
    # 7. accessibility > disable cursor shake

    # "com.apple.universalaccess" = {
    #   "reduceMotion" = true;
    # };

    # "com.apple.Accessibility" = {
    #   "com.apple.Accessibility.ReduceMotionEnabled" = true;
    # };

    # "Accessibility" = {
    #   "Accessibility.MADisplayFilterSingleColorHue" = "0.3333333333333333";
    #   "Accessibility.MADisplayFilterSingleColorIntensity" = "0.5";
    #   "Accessibility.__Color__-MADisplayFilterCategoryEnabled" = true;
    #   "Accessibility.__Color__-MADisplayFilterType" = 16;
    #   "Accessibility.CGDisableCursorLocationMagnification" = true;
    # };

    # "com.apple.mediaaccessibility" = {
    #   "com.apple.mediaaccessibility.MADisplayFilterSingleColorIntensity" = "0.5";
    #   "com.apple.mediaaccessibility.__Color__-MADisplayFilterCategoryEnabled" = true;
    #   "com.apple.mediaaccessibility.__Color__-MADisplayFilterType" = 16;
    #   "com.apple.mediaaccessibility.CGDisableCursorLocationMagnification" = true;
    # };
  };
}

