cask "omnimon" do
  version "6.6.6"
  sha256 "8293a3f22f507b1144cb4492197176c0db4c537aeacf314c7521984fd0a289f2"

  url "https://github.com/chochy2001/omnimon/releases/download/v#{version}/OmniMon-#{version}-macOS-Universal.dmg"
  name "OmniMon"
  desc "Cross-platform system monitor, process manager, and AI assistant"
  homepage "https://github.com/chochy2001/omnimon"

  depends_on macos: :ventura

  app "OmniMon.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-rd", "com.apple.quarantine", "/Applications/OmniMon.app"],
        must_succeed:   false,
        writable_paths: ["OmniMon.app"],
        writable_base:  :appdir
  end

  uninstall quit: "com.omnimon.desktop"

  zap trash: [
    "~/.config/macmon",
    "~/.local/share/macmon",
    "~/Library/Application Support/com.omnimon.desktop",
    "~/Library/Caches/com.omnimon.desktop",
    "~/Library/Preferences/com.omnimon.desktop.plist",
  ]

  caveats <<~EOS
    OmniMon is now in your Applications folder.

    To open:  Cmd + Space → type "OmniMon"
    Or run:   open /Applications/OmniMon.app

    OmniMon also runs in your menu bar tray.

    If macOS blocks the app, run:
      sudo xattr -rd com.apple.quarantine /Applications/OmniMon.app
  EOS
end
