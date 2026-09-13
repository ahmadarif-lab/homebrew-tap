cask "transcriber" do
  version "1.0.0"
  sha256 "e2deaf6e50200e17a54b4e4f0632b3d61445e8cd4a8ef5b2d1e3e7316525d674"

  url "https://github.com/ahmadarif-lab/transcriber/releases/download/v#{version}/Transcriber.dmg"
  name "Transcriber"
  desc "Turn video or audio into text, subtitles and burned-in captions"
  homepage "https://github.com/ahmadarif-lab/transcriber"

  depends_on arch: :arm64
  depends_on formula: "ffmpeg"
  depends_on formula: "whisper-cpp"
  depends_on macos: :sonoma

  app "Transcriber.app"

  # The app is ad-hoc signed rather than notarized, so Gatekeeper refuses to launch it while
  # the download still carries a quarantine flag. Clearing it here is what makes
  # `brew install` a one-step install instead of sending people to Terminal.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/Transcriber.app"],
        writable_paths: ["Transcriber.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  zap trash: [
    "~/Library/Application Support/Transcriber",
    "~/Library/Caches/com.ahmadarif.transcriber",
    "~/Library/Preferences/com.ahmadarif.transcriber.plist",
    "~/Library/Saved Application State/com.ahmadarif.transcriber.savedState",
  ]

  caveats <<~EOS
    Speech models are downloaded from inside the app: open the gear menu and pick one, or
    just press Transcribe and the recommended model is fetched first. They live in
    ~/Library/Application Support/Transcriber/Models and `brew uninstall --zap` removes them.
  EOS
end
