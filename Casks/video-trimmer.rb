cask "video-trimmer" do
  version "1.2.0"
  sha256 "9cdc4998c1c1347034f874056e7edfee6d2c3ed261535cb8eb7f0d5302254801"

  url "https://github.com/ahmadarif-lab/video-trimmer/releases/download/v#{version}/VideoTrimmer.dmg"
  name "Video Trimmer"
  desc "Cut unwanted stretches out of a video and export what is left"
  homepage "https://github.com/ahmadarif-lab/video-trimmer"

  depends_on macos: :sonoma
  depends_on arch: :arm64
  depends_on formula: "ffmpeg"

  app "Video Trimmer.app"

  # The app is ad-hoc signed rather than notarized, so Gatekeeper refuses to launch
  # it while the download still carries a quarantine flag. Clearing it here is what
  # makes `brew install` a one-step install instead of sending people to Terminal.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/Video Trimmer.app"],
        writable_paths: ["Video Trimmer.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  zap trash: [
    "~/Library/Preferences/com.ahmadarif.videotrimmer.plist",
    "~/Library/Saved Application State/com.ahmadarif.videotrimmer.savedState",
  ]
end
