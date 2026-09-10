cask "cswapbar" do
  version "1.2.1"
  sha256 "5f4867f8341125bc01d710582120be8ed28b36810109ca62df202ec8112c8f02"

  url "https://github.com/ahmadarif-lab/cswapbar/releases/download/v#{version}/CSwapBar.dmg"
  name "CSwapBar"
  desc "Menu bar app for claude-swap: per-account usage bars and one-click switching"
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

    # Launch it so the menu bar icon appears immediately; on its first run
    # the app registers itself as a login item via SMAppService. Registering
    # a LaunchAgent from here instead does not work -- postflight is
    # sandboxed and launchctl fails with "Load failed: 5: I/O error".
    run "/usr/bin/open",
        args:         ["-a", "/Applications/CSwapBar.app"],
        must_succeed: false
  end

  uninstall quit: "dev.ahmadarif.cswapbar"

  zap trash: [
    "~/Library/Preferences/dev.ahmadarif.cswapbar.plist",
    "~/Library/Saved Application State/dev.ahmadarif.cswapbar.savedState",
  ]

  caveats <<~EOS
    CSwapBar drives the `cswap` CLI, which is not a Homebrew package. Install it with:
      uv tool install claude-swap    # or: pipx install claude-swap

    It starts at login from its first launch. Turn that off from "Start at login"
    in the menu, or System Settings > General > Login Items.
  EOS
end
