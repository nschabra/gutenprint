<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/concept-design-dark.svg">
  <img alt="Concept Design" src="./assets/concept-design-light.svg" width="100%">
</picture>

# Concept — macOS Installer UI, Print Presets & Background Listener Service (`CON002`)

> **Parent:** [`concept-design-master.md`](./concept-design-master.md) · **Status:** `Proposed` · **Date:** 2026-09-09
> **Cross-cut:** none · **Owner:** nschabra
> **Architecture:** [`ARC_20260909_A`](../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md)

---

## 1. Problem Statement

Today, installing and configuring the Canon PIXMA G1010 requires terminal commands (`./bin/g1010-ctl install`, `make install`, or `lpadmin`). End users expect a familiar, comfortable macOS installation wizard, direct visibility of **Color vs B&W and Photo Presets** in the native macOS Print Dialog (`Cmd+P`) and System Settings, and a self-healing background listener service for seamless AirPrint broadcasting.

---

## 2. Concept Architecture

```text
 ┌─────────────────────────────────────────────────────────────────────────────┐
 │                         macOS User Installation Experience                   │
 ├─────────────────────────────────────────────────────────────────────────────┤
 │                                                                             │
 │  1. Installer Package (.pkg / .dmg)                                         │
 │     └─ Native Apple Installer with Welcome, License & Driver Payload        │
 │                                                                             │
 │  2. Post-Install Setup Assistant (GUI & Web Dashboard)                      │
 │     ├─ Auto-detects Canon G1010 USB hardware                                │
 │     ├─ Generates and registers PPD queue with Apple Presets                  │
 │     ├─ Activates background AirPrint & Hotplug Listener                     │
 │     └─ Displays live ink levels and offers one-click "Print Test Page"      │
 │                                                                             │
 │  3. Native macOS Print Sheet Integration (Safari, Preview, Pages)           │
 │     └─ "Presets" Dropdown populated with Color, B&W, Photo & Duplex         │
 │                                                                             │
 │  4. Background Listener Service (LaunchAgent Daemon)                        │
 │     ├─ AirPrint mDNS broadcasting on port 8631                              │
 │     ├─ Options forwarding to CUPS (ColorModel, DuplexNoTumble)              │
 │     └─ Local Web Telemetry UI at http://127.0.0.1:8631                      │
 └─────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Core Pillars

### Pillar A: Comfortable Installation UI & Setup Assistant
1. **macOS Native `.pkg` Installer**:
   - Standard Apple installer bundle generated using `pkgbuild` and `productbuild`.
   - Distributes `rastertogutenprint.5.3`, `cups-genppd.5.3`, PPD templates, and the listener LaunchAgent into system directories (`/usr/local/libexec/cups/`, `/Library/LaunchAgents/`).
2. **Post-Install Setup Assistant (`g1010-setup`)**:
   - Modern visual wizard (native macOS Cocoa/AppleScript dialogs + embedded Web UI).
   - Step 1: Hardware check (verifies USB connection to `usb://Canon/G1010`).
   - Step 2: Queue configuration (sets up `Canon_G1010` and `Canon_G1010_2`).
   - Step 3: Ink tank check (displays GI-790 visual gauges).
   - Step 4: Verification test print.

### Pillar B: Seamless Print Dialog Presets
1. **Pre-Seeded Apple Custom Presets**:
   - Pre-populate `~/Library/Preferences/com.apple.print.custompresets.plist` during installation so users immediately see:
     - `🎨 Standard Color (CMYK)`
     - `📄 Monochrome Document (Black & White)`
     - `🖼️ High Quality Photo (Glossy Photo Paper)`
     - `📑 Two-Sided Document (Manual Long-Edge Duplex)`
2. **System Settings Exposure**:
   - Ensure CUPS PPD options (`ColorModel`, `Duplex`, `MediaType`, `Resolution`) appear in macOS System Settings under *Printers & Scanners → Options & Supplies*.

### Pillar C: Background Listener Service
1. **Self-Healing LaunchAgent (`com.gutenprint.g1010-listener.plist`)**:
   - Automatically starts at user login.
   - Monitors CUPS queues and USB hotplug state.
   - Advertises IPP Everywhere AirPrint (`_ipps._tcp`, `_print`, `_universal`, `_color`).
2. **Local Web Telemetry UI**:
   - Lightweight HTTP listener on `http://127.0.0.1:8631` serving live ink levels, queue pause/resume buttons, and printer health diagnostics.

---

## 4. Ideas Backlog

| # | Idea | Impact | Status |
| ---: | --- | --- | --- |
| 1 | Standard macOS `.pkg` installer bundle with distribution XML | High | Proposed |
| 2 | Post-install graphical Setup Assistant (`g1010-setup`) | High | Proposed |
| 3 | Auto-seed Apple Presets plist for Safari/Preview/Pages | High | Proposed |
| 4 | Background LaunchAgent listener daemon with auto-recovery | High | Proposed |
| 5 | Menu Bar status item (macOS tray app) showing live ink levels | Medium | Future |
| 6 | Native macOS notification when paper re-insertion is required for duplex | Medium | Proposed |

---

## 5. Scope for Delivery

- **In-Scope**:
  - Scripted `.pkg` installer builder under `packaging/macos/make-pkg`.
  - GUI setup wizard and test print trigger (`bin/g1010-setup` / Web UI).
  - Apple Presets registration script (`scripts/seed-apple-presets.sh`).
  - Production LaunchAgent daemon definition (`packaging/macos/com.gutenprint.g1010-listener.plist`).
- **Out-of-Scope**:
  - Third-party notarization with Apple Developer ID (requires paid Apple Developer certificate).

---

## 6. Open Questions

1. Should the post-install setup assistant launch automatically right after `.pkg` installation finishes, or be triggered by the user from Applications / Terminal? *(Recommended: Launch automatically via installer `postinstall` script).*
2. Should the web dashboard on `http://127.0.0.1:8631` be secured with basic authentication, or remain accessible locally on localhost? *(Recommended: Localhost only without password for instant ease of use).*

---

## 7. Promotion Path

`CON002` -> Architecture Record (`ARC_20260909_B`) -> Delivery Plan (`PLN004`) -> Execution.

---

## Footer Navigation

Parent: [`concept-design-master.md`](./concept-design-master.md) ·
Architecture: [`../architecture/architecture-master.md`](../architecture/architecture-master.md) ·
Plans: [`../plans/plans-master.md`](../plans/plans-master.md)
