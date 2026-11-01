cask "cswapbar" do
  version "2.8.1"
  sha256 "ec81bfb86218211862d985cb6f8f85063b9c855e656a409468941973a601dadc"

  url "https://github.com/ahmadarif-lab/cswapbar/releases/download/v#{version}/CSwapBar.dmg"
  name "CSwapBar"
  desc "Menu bar quota tracker for Claude Code, Antigravity, z.ai, DeepSeek, OpenCode Go, Kiro and Codex"
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
