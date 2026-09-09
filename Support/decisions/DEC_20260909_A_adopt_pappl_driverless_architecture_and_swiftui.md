<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/decisions-dark.svg">
  <img alt="Decisions Master" src="./assets/decisions-light.svg" width="100%">
</picture>

# Decision — Adopt PAPPL Driverless Architecture and Native macOS SwiftUI Companion (`DEC_20260909_A`)

> **Parent:** [`decisions-master.md`](./decisions-master.md) · **Status:** `Accepted` · **Date:** 2026-09-09
> **Concept:** [`CON004`](../concept-design/CON004_Modern_Printer_Application_Stack_Uplift_And_Pappl_Architecture_Concept.md) · **Architecture:** [`ARC_20260909_B`](../architecture/ARC_20260909_B_modern_pappl_printer_application_and_swiftui_companion.md)
> **Plan:** [`PLN006`](../plans/06-modernization/PLN006-modern-pappl-printer-application-and-macos-swiftui-companion-plan.md)

---

## 1. Context

Apple and the OpenPrinting project have officially deprecated traditional PPD files and CUPS raster filters (`/usr/libexec/cups/filter/`). Future releases of macOS and Linux will run CUPS in purely driverless mode (IPP Everywhere / AirPrint). Gutenprint's two-decade-old Autotools build system and complex PPD generators create significant friction for macOS universal builds and modern user experience expectations.

Users require:
1. Native AirPrint discovery without manual PPD selection.
2. Top-level two-sided (duplex) and color controls directly inside macOS print sheets.
3. Modern graphical status item in the macOS menu bar showing live ink levels and head cleaning utilities.
4. Fast, maintainable CMake build toolchain producing Apple Silicon (`arm64`) and Intel (`x86_64`) universal binaries.

---

## 2. Decision

1. **Adopt PAPPL Framework**: Migrate the Canon PIXMA G1000/G1010 driver pipeline to a driverless **PAPPL Printer Application** (`gutenprint-app`), embedding an IPP 2.0 / AirPrint server on port 8631.
2. **Transition Build Toolchain to CMake**: Introduce modular CMake 3.25+ build configuration alongside legacy Autotools to build `libgutenprint-core`, `libgutenprint-canon`, and the `gutenprint-app` daemon.
3. **Build Native macOS SwiftUI Companion**: Develop a lightweight, user-space Menu Bar companion agent using SwiftUI that communicates with the PAPPL daemon and USB hardware to present visual ink gauges and maintenance buttons.
4. **Enforce Zero Duplicate Daemons**: Maintain port 8631 as the sole service endpoint, retiring ad-hoc wrappers once the native PAPPL daemon is deployed.

---

## 3. Consequences

### Positive
- Permanently eliminates CUPS driver deprecation warnings on macOS Sonoma, Sequoia, and future releases.
- Native mDNS broadcasting enables driverless printing from macOS, iOS, iPadOS, Android, and Linux.
- Drastically improves compilation speeds and developer ergonomics with CMake.
- Delivers a comfortable, modern Apple user experience with SwiftUI status gauges and presets.

### Negative / Trade-offs
- Requires introducing the OpenPrinting PAPPL C library and its dependencies (`libjpeg`, `libpng`, `libusb`).
- Requires maintaining dual build paths (CMake and legacy Autotools) during the transition phase.

---

## 4. Compliance & Verification

- The standalone PAPPL service must respond to standard IPP 2.0 queries on `http://localhost:8631/ipp/print`.
- CMake builds must produce verified universal binaries on macOS (`lipo -archs`).
- The SwiftUI companion must render live ink tank states without requiring elevated root permissions.

## Footer Navigation

Parent: [`decisions-master.md`](./decisions-master.md) · Architecture: [`../architecture/architecture-master.md`](../architecture/architecture-master.md)
