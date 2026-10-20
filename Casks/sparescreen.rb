# Homebrew cask for SpareScreen. build.sh release fills in the @...@ values and writes dist/sparescreen.rb.
cask "sparescreen" do
  version "1.0.8"
  sha256 "e45173a419fbb15484e1c3fead48d8e1bfee12b235fffead372ba339f2c2e76b"

  url "https://github.com/chaibreak/sparescreen/releases/download/v#{version}/SpareScreen-#{version}.zip"
  name "SpareScreen"
  desc "Use a tablet as a wireless second screen for your Mac"
  homepage "https://getsparescreen.com"

  depends_on macos: :ventura

  app "SpareScreen.app"

  # Not notarized (no paid Apple Developer ID yet): clear the download quarantine so it opens without the Gatekeeper
  # "Not Opened" block. Same approach as Castbar's tap. (Opening the app can't happen here: Homebrew 7 runs these
  # steps in a sandbox where `open` fails, so the website's install command ends with `&& open -a SpareScreen`.)
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/SpareScreen.app"]
  end

  uninstall quit: "io.github.sparescreen.mac"

  zap trash: "~/Library/Preferences/io.github.sparescreen.mac.plist"

  caveats "Start SpareScreen from Applications, or with: open -a SpareScreen"
end
