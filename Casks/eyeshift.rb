# Homebrew cask for Eyeshift in chaibreak/homebrew-tap. scripts/release.sh fills in the @...@ values.
cask "eyeshift" do
  version "0.1.0"
  sha256 "50659b12e26c3be5f2dc4bc0cb0d27ad8ddaf59d32b51bfed9b9a6d8c4b397bb"

  url "https://github.com/itssarthak/eyeshift/releases/download/v#{version}/Eyeshift-#{version}.zip"
  name "Eyeshift"
  desc "Move keyboard focus to the screen, window or split pane you look at"
  homepage "https://sarthakchhabra.com/eyeshift/"

  depends_on macos: :sonoma

  app "Eyeshift.app"

  # Not notarized (no paid Apple Developer ID yet): clear the download quarantine so it opens without the Gatekeeper
  # "Not Opened" block. Same approach as SpareScreen and Castbar.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Eyeshift.app"]
  end

  uninstall quit: "io.github.itssarthak.eyeshift"

  zap trash: "~/Library/Application Support/Eyeshift"

  caveats "Start Eyeshift from Applications, or with: open -a Eyeshift"
end
