# Homebrew cask for SpareScreen. build.sh release fills in the @...@ values and writes dist/sparescreen.rb.
cask "sparescreen" do
  version "1.0.0"
  sha256 "679633fd9cf6a216d9027222df3017f2e4756cbfe29208357c09ef67d74b1320"

  url "https://github.com/itssarthak/sparescreen/releases/download/v#{version}/SpareScreen-#{version}.zip"
  name "SpareScreen"
  desc "Use a tablet as a wireless second screen for your Mac"
  homepage "https://getsparescreen.com"

  depends_on macos: :ventura

  app "SpareScreen.app"

  # Not notarized (no paid Apple Developer ID yet): clear the download quarantine so it opens without the Gatekeeper
  # "Not Opened" block. Same approach as Castbar's tap.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/SpareScreen.app"]
  end

  uninstall quit: "io.github.sparescreen.mac"

  zap trash: "~/Library/Preferences/io.github.sparescreen.mac.plist"

  caveats "Start SpareScreen with: open -a SpareScreen"
end
