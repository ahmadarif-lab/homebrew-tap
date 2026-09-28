cask "statbar" do
  version "0.1.0"
  sha256 "23c7a0a16459a60e0fcb4d21e3e28d128fc596fd97fe4056141698b331672c5f"

  url "https://github.com/ahmadarif-lab/statbar/releases/download/v#{version}/StatBar.dmg"
  name "StatBar"
  desc "Menu bar system monitor for CPU, GPU, memory, network, disks and battery"
  homepage "https://github.com/ahmadarif-lab/statbar"

  depends_on macos: :sonoma

  app "StatBar.app"

  # The app is ad-hoc signed rather than notarized, so Gatekeeper refuses to launch
  # it while the download still carries a quarantine flag. Clearing it here is what
  # makes `brew install` a one-step install instead of sending people to Terminal.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/StatBar.app"],
        writable_paths: ["StatBar.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  uninstall quit: "dev.ahmadarif.statbar"

  zap trash: [
    "~/Library/Preferences/dev.ahmadarif.statbar.plist",
    "~/Library/Saved Application State/dev.ahmadarif.statbar.savedState",
  ]

  caveats <<~EOS
    Open StatBar from Applications to start it. It starts at login from that
    first launch; turn that off under Settings > General > Start at login, or
    System Settings > General > Login Items.
  EOS
end
