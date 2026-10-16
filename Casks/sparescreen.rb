# Homebrew cask for SpareScreen. build.sh release fills in the @...@ values and writes dist/sparescreen.rb.
cask "sparescreen" do
  version "1.0.4"
  sha256 "7a591b12c1752ac9e86a0c71bde4c62edc599776ce61efa9a2df6efc48abb0c6"

  url "https://github.com/chaibreak/sparescreen/releases/download/v#{version}/SpareScreen-#{version}.zip"
  name "SpareScreen"
  desc "Use a tablet as a wireless second screen for your Mac"
  homepage "https://getsparescreen.com"

  depends_on macos: :ventura

  app "SpareScreen.app"

  # Not notarized (no paid Apple Developer ID yet): clear the download quarantine so it opens without the Gatekeeper
  # "Not Opened" block. Same approach as Castbar's tap.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/SpareScreen.app"]
    run "/usr/bin/open", args: ["{{appdir}}/SpareScreen.app"]
  end

  uninstall quit: "io.github.sparescreen.mac"

  zap trash: "~/Library/Preferences/io.github.sparescreen.mac.plist"

  caveats "SpareScreen opens in the menu bar. Next time, start it from Applications or with: open -a SpareScreen"
end
