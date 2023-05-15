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
  system.defaults.dock.appswitcher-all-displays = false;
  system.defaults.dock.autohide-delay = 0.24;
  system.defaults.dock.orientation = "right";
  system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/basso.aiff";
  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
  system.defaults.NSGlobalDomain.NSScrollAnimationEnabled = true;
  system.defaults.NSGlobalDomain.NSWindowResizeTime = 0.01;
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
  system.defaults.NSGlobalDomain.NSTextShowsControlCharacters = true;
  system.defaults.NSGlobalDomain.NSUseAnimatedFocusRing = false;
  system.defaults.NSGlobalDomain."com.apple.springing.enabled" = true;
  system.defaults.NSGlobalDomain."com.apple.springing.delay" = 0.0;
  # system.defaults.universalaccess.reduceTransparency = true;
  # system.defaults.universalaccess.closeViewZoomFollowsFocus = true;

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
      "MiniaturizedOnDoubleClick" = false;
      "com.apple.trackpad.forceClick" = false;
    };
  };
}

