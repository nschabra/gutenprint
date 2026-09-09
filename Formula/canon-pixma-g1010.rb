class CanonPixmaG1010 < Formula
  desc "macOS driver and AirPrint / IPP Everywhere companion for Canon PIXMA G1010"
  homepage "https://gutenprint.sourceforge.net/"
  url "file://#{File.expand_path("..", __dir__)}"
  version "5.3.5"
  license "GPL-2.0-or-later"

  def install
    # Install CLI companion
    bin.install "bin/canon-g1010"

    # Install calibrated PPD
    pkgshare.install "src/cups/Canon_PIXMA_G1010.ppd" if File.exist?("src/cups/Canon_PIXMA_G1010.ppd")
    (share/"cups/model").install "src/cups/Canon_PIXMA_G1010.ppd" if File.exist?("src/cups/Canon_PIXMA_G1010.ppd")

    # Install LaunchAgent template
    pkgshare.install "packaging/macos/com.local.ippeveprinter.plist" if File.exist?("packaging/macos/com.local.ippeveprinter.plist")
  end

  def post_install
    (var/"spool/ipp-spool").mkpath
  end

  service do
    run [
      "/usr/bin/ippeveprinter",
      "-v",
      "-p", "8631",
      "-f", "application/pdf,image/pwg-raster,image/urf",
      "-d", "/tmp/ipp-spool",
      "-m", "everywhere",
      "-a", "Canon PIXMA G1010",
      "Canon_G1010_AirPrint",
    ]
    keep_alive true
    run_type :immediate
    log_path var/"log/canon-pixma-g1010.log"
    error_log_path var/"log/canon-pixma-g1010.error.log"
  end

  def caveats
    <<~EOS
      ==> Canon PIXMA G1010 Setup Instructions:

      1. Start the AirPrint / IPP Everywhere service:
         brew services start #{name}

      2. Configure your macOS print queues and Apple UI presets:
         #{opt_bin}/canon-g1010 setup

      3. Check printer connectivity and supply status:
         #{opt_bin}/canon-g1010 status

      Your printer will appear in Preview and all macOS print dialogs with
      native Two-Sided duplex and Color/B&W checkboxes automatically!
    EOS
  end

  test do
    assert_match "version 5.3.5", shell_output("#{bin}/canon-g1010 version")
  end
end
