cask "duebar" do
  version "0.1.1"
  sha256 "02971eeaa751f846d21aeec21d5598dc0b48dc3f8eae75effcefca6f47811996"

  url "https://github.com/ahmadarif-lab/duebar/releases/download/v#{version}/DueBar.dmg"
  name "DueBar"
  desc "Menu bar payment reminder with optional Google sync"
  homepage "https://github.com/ahmadarif-lab/duebar"

  depends_on macos: :sonoma

  app "DueBar.app"

  # Ad-hoc signed, not notarized: clearing the quarantine flag makes `brew install` a one-step install.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/DueBar.app"],
        writable_paths: ["DueBar.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  uninstall quit: "dev.ahmadarif.duebar"

  zap trash: [
    "~/Library/Application Support/DueBar",
    "~/Library/Preferences/dev.ahmadarif.duebar.plist",
    "~/Library/Saved Application State/dev.ahmadarif.duebar.savedState",
  ]

  caveats <<~EOS
    Open DueBar from Applications to start it. It starts at login from that
    first launch; turn that off under Settings > General > Start at login.
  EOS
end
