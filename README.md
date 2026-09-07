# homebrew-tap

Homebrew formulae and casks for my projects.

## Usage

```sh
brew tap ahmadarif-lab/tap
```

## Available casks

### Video Trimmer

A native macOS app for cutting unwanted stretches out of a video.
See [ahmadarif-lab/video-trimmer](https://github.com/ahmadarif-lab/video-trimmer).

```sh
brew install --cask ahmadarif-lab/tap/video-trimmer
```

The app is ad-hoc signed rather than notarized, so the cask clears the quarantine flag after
installing. Without that, Gatekeeper would refuse the first launch.
