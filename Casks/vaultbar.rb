cask "vaultbar" do
  version "0.1.0"
  sha256 "006ef8ca0e93e5253f4912c1dae88e7225265e4d7cb50a2ddf520256c652c4a5"

  url "https://github.com/ahmadarif-lab/vaultbar/releases/download/v#{version}/VaultBar.dmg"
  name "VaultBar"
  desc "Menu bar client for Bitwarden-compatible vaults with live 2FA codes and auto-type"
  homepage "https://github.com/ahmadarif-lab/vaultbar"

  depends_on macos: :sonoma

  app "VaultBar.app"

  # The app is ad-hoc signed rather than notarized, so Gatekeeper refuses to launch
  # it while the download still carries a quarantine flag. Clearing it here is what
  # makes `brew install` a one-step install instead of sending people to Terminal.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/VaultBar.app"],
        writable_paths: ["VaultBar.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  uninstall quit: "dev.ahmadarif.vaultbar"

  zap trash: [
    "~/Library/Application Support/VaultBar",
    "~/Library/Preferences/dev.ahmadarif.vaultbar.plist",
  ]

  caveats <<~EOS
    Open VaultBar from Applications, then log in with your e-mail and master
    password (bitwarden.com, bitwarden.eu or your own server). Auto-type asks
    for the Accessibility permission the first time you use it.
  EOS
end
