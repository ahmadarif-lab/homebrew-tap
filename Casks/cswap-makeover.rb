cask "cswap-makeover" do
  version "1.0.1"
  sha256 "a1f983aed99e89817c17be375a62e2fcf80c998770c0429186d7f7b0290b8a08"

  url "https://github.com/ahmadarif-lab/cswap-makeover/releases/download/v#{version}/CSwapBar.dmg"
  name "CSwapBar"
  desc "Menu bar app for claude-swap: per-account usage bars and one-click switching"
  homepage "https://github.com/ahmadarif-lab/cswap-makeover"

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

  uninstall launchctl: "dev.ahmadarif.cswap-makeover"

  zap trash: [
    "~/Library/Logs/dev.ahmadarif.cswap-makeover.err",
    "~/Library/Logs/dev.ahmadarif.cswap-makeover.log",
    "~/Library/Saved Application State/dev.ahmadarif.cswap-makeover.savedState",
  ]

  caveats <<~EOS
    CSwapBar drives the `cswap` CLI, which is not a Homebrew package. Install it with:
      uv tool install claude-swap    # or: pipx install claude-swap

    To start CSwapBar at login:
      /Applications/CSwapBar.app/Contents/Resources/install_service.sh
  EOS
end
