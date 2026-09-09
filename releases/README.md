# Canon PIXMA G1010 macOS Driver Releases

Official distribution repository for Canon PIXMA G1010 high-performance driver and AirPrint / IPP Everywhere companion packages on macOS (Sonoma, Sequoia, and future releases).

---

## Available Releases

| S.No. | Release Package | Version | Date | Target macOS | SHA256 Checksum |
| ---: | --- | --- | --- | --- | --- |
| 1 | [`Canon-PIXMA-G1010-v5.3.5.pkg`](./Canon-PIXMA-G1010-v5.3.5.pkg) | `5.3.5` | 2026-09-09 | macOS 12+ (Apple Silicon & Intel) | `cf919db751f3ed1c7908a2fc8b42153d9f97502992b4fe9fc697a3b61a31bdf6` |

---

## Installation Channels

### Channel 1: Standalone Package Installer (Recommended for End Users)

1. Double-click [`Canon-PIXMA-G1010-v5.3.5.pkg`](./Canon-PIXMA-G1010-v5.3.5.pkg) or install via terminal:
   ```bash
   sudo installer -pkg releases/Canon-PIXMA-G1010-v5.3.5.pkg -target /
   ```
2. The installer automatically:
   - Deploys calibrated PPD to `/Library/Printers/PPDs/Contents/Resources/Canon_PIXMA_G1010.ppd`.
   - Installs CLI companion tool to `/usr/local/bin/canon-g1010`.
   - Loads the AirPrint LaunchAgent daemon on port `8631`.
   - Configures the system default queue `Canon_G1010_2` with top-level Two-Sided and Color controls.

---

### Channel 2: Homebrew Console Installation (For Developers & Power Users)

For headless or CLI-driven setups:
```bash
# 1. Install via Homebrew Formula
brew install ./Formula/canon-pixma-g1010.rb

# 2. Start the AirPrint IPP Everywhere background service
brew services start canon-pixma-g1010

# 3. Configure the queue and presets
canon-g1010 setup
```

---

## Verifying Installation & Hardware Telemetry

Run the companion CLI from your terminal:
```bash
canon-g1010 status
```

Output details hardware connectivity, IPP port 8631 status, active CUPS queues, and MegaTank ink supplies.

To dispatch a color calibration and duplex alignment test page:
```bash
canon-g1010 test-page
```

---

## Building from Source

To build a fresh `.pkg` package from repository source:
```bash
./packaging/macos/build-release-pkg.sh
```
