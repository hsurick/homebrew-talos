# Installs the prebuilt Talos.app from the GitHub release. A formula, not a cask: Homebrew doesn't quarantine formula
# downloads, so the unsigned app opens without macOS's "Open Anyway" step.
class Talos < Formula
  desc "Control your Mac with hand gestures through the webcam"
  homepage "https://github.com/hsurick/talos"
  url "https://github.com/hsurick/talos/releases/download/v0.2.0/Talos.zip"
  version "0.2.0"
  sha256 "d898a130c8ed8c94f974384efde8a80802df7e54efcf2c568c2b03e484b4b61d"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  # The app's library IDs are already set to this keg's paths (talos/release.sh), so Homebrew's relocation changes
  # nothing and the app's signature stays valid.
  def install
    (prefix/"Talos.app").install Dir["*"]  # Homebrew unpacks the zip and steps into its only folder, Talos.app
  end

  def caveats
    <<~EOS
      Put Talos in Applications and open it:
        ln -sf #{opt_prefix}/Talos.app /Applications/Talos.app
        open /Applications/Talos.app
      Then allow Camera, and turn on Talos in System Settings > Privacy & Security > Accessibility.
    EOS
  end
end
