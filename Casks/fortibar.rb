cask "fortibar" do
  version "0.3.0"
  sha256 "08ccf38cc2ea483e5feef84324908b3c93df289c8cca503fbe35d2cd0761a30d"

  url "https://github.com/ahmadarif-lab/fortibar/releases/download/v#{version}/FortiBar.dmg"
  name "FortiBar"
  desc "Menu bar FortiGate IPsec VPN client that needs no FortiClient"
  homepage "https://github.com/ahmadarif-lab/fortibar"

  depends_on formula: "strongswan"
  depends_on macos: :sonoma

  app "FortiBar.app"

  # The app is ad-hoc signed rather than notarized, so Gatekeeper refuses to launch
  # it while the download still carries a quarantine flag. Clearing it here is what
  # makes `brew install` a one-step install instead of sending people to Terminal.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/FortiBar.app"],
        writable_paths: ["FortiBar.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  uninstall quit: "id.my.bontot.fortibar"

  zap trash: [
    "~/Library/Application Support/FortiBar",
    "~/Library/Preferences/id.my.bontot.fortibar.plist",
  ]

  caveats <<~EOS
    Open FortiBar, then Settings -> System -> Install helper. That one-time
    step (approve with Touch ID) installs the background helper that runs the
    VPN engine; after it, connecting needs only your FortiToken code.

    Remove the helper before uninstalling the app (Settings -> System ->
    Remove helper), or run:
      sudo /Applications/FortiBar.app/Contents/Resources/install-helper.sh uninstall
  EOS
end
