# homebrew-tap

Homebrew formulae and casks for my projects.

## Usage

```sh
brew tap ahmadarif-lab/tap
```

## Available casks

### Transcriber

A native macOS app that turns video or audio into text, subtitles and burned-in captions.
See [ahmadarif-lab/transcriber](https://github.com/ahmadarif-lab/transcriber).

```sh
brew install --cask ahmadarif-lab/tap/transcriber
```

The cask pulls in `ffmpeg` and `whisper-cpp`, which the app drives. Speech models are downloaded
from inside the app on first use.

### Video Trimmer

A native macOS app for cutting unwanted stretches out of a video.
See [ahmadarif-lab/video-trimmer](https://github.com/ahmadarif-lab/video-trimmer).

```sh
brew install --cask ahmadarif-lab/tap/video-trimmer
```

The app is ad-hoc signed rather than notarized, so the cask clears the quarantine flag after
installing. Without that, Gatekeeper would refuse the first launch.
