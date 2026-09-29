cask "cswapbar" do
  version "2.1.2"
  sha256 "62245cf5ac7e6dc89d73f813a9820ac3f466aaa34feb436a3d6919207f2e17bc"

  url "https://github.com/ahmadarif-lab/cswapbar/releases/download/v#{version}/CSwapBar.dmg"
  name "CSwapBar"
  desc "Menu bar app for Claude, Antigravity and z.ai quota: usage bars and one-click account switching"
  homepage "https://github.com/ahmadarif-lab/cswapbar"

  depends_on macos: :sonoma

  app "CSwapBar.app"

  # The app is ad-hoc signed rather than notarized, so Gatekeeper refuses to launch
  # it while the download still carries a quarantine flag. Clearing it here is what
  # makes `brew install` a one-step install instead of sending people to Terminal.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/CSwapBar.app"],
        writable_paths: ["CSwapBar.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  uninstall quit: "dev.ahmadarif.cswapbar"

  zap trash: [
    "~/Library/Preferences/dev.ahmadarif.cswapbar.plist",
    "~/Library/Saved Application State/dev.ahmadarif.cswapbar.savedState",
  ]

  caveats <<~EOS
    Open CSwapBar from Applications to start it. It starts at login from that
    first launch; turn that off from "Start at login" in the menu, or System
    Settings > General > Login Items.
  EOS
end
