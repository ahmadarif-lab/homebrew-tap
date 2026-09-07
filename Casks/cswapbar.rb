cask "cswapbar" do
  version "1.0.2"
  sha256 "7d461fe794f37e1ea7c26ead188c3ded7f465b67f16e851e2db188d7782f793b"

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

    # Register the LaunchAgent so the menu bar icon is there right after
    # install, without a follow-up command.
    run "/Applications/CSwapBar.app/Contents/Resources/install_service.sh",
        must_succeed: false
  end

  uninstall launchctl: "dev.ahmadarif.cswapbar"

  # install_service.sh writes this LaunchAgent itself, outside Homebrew's
  # bookkeeping, so zap has to name it explicitly.
  zap trash: [
    "~/Library/LaunchAgents/dev.ahmadarif.cswapbar.plist",
    "~/Library/Logs/dev.ahmadarif.cswapbar.err",
    "~/Library/Logs/dev.ahmadarif.cswapbar.log",
    "~/Library/Saved Application State/dev.ahmadarif.cswapbar.savedState",
  ]

  caveats <<~EOS
    CSwapBar drives the `cswap` CLI, which is not a Homebrew package. Install it with:
      uv tool install claude-swap    # or: pipx install claude-swap

    To start CSwapBar at login:
      /Applications/CSwapBar.app/Contents/Resources/install_service.sh
  EOS
end
