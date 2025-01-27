{
  security.pam.enableSudoTouchIdAuth = true;
  environment.launchDaemons."limit.maxfiles.plist" = {
    enable = true;
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
      "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
      <key>Label</key>
      <string>limit.maxfiles</string>
      <key>ProgramArguments</key>
      <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>524288</string>
      <string>524288</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>ServiceIPC</key>
      <false/>
      </dict>
      </plist>
    '';
  };
  system = {
    defaults = {
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
      finder = {
        FXDefaultSearchScope = "SCcf";
        FXPreferredViewStyle = "clmv"
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        ShowStatusBar = true;
      };
      dock = {
        # Quick Note on the bottom right hot corner
        # wvous-br-corner = 14;
        # tilesize = 50;
        autohide = true;
      };
      NSGlobalDomain = {
        "com.apple.sound.beep.volume" = 0.0;
        InitialKeyRepeat = 13;
        KeyRepeat = 2;
      };
        loginwindow.GuestEnabled = false;
    };
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      launchctl stop com.apple.Dock.agent
      launchctl start com.apple.Dock.agent
    '';
  };
}
