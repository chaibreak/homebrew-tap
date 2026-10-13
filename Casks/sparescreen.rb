# Homebrew cask for SpareScreen. build.sh release fills in the @...@ values and writes dist/sparescreen.rb.
cask "sparescreen" do
  version "1.0.2"
  sha256 "04fbf2405395652cf51ddfe399319468a0be885efdb1895b43a91a17e5114497"

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
