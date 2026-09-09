<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/concept-design-dark.svg">
  <img alt="Concept Design" src="./assets/concept-design-light.svg" width="100%">
</picture>

# Concept — Modern Printer Application Stack Uplift & PAPPL Architecture (`CON004`)

> **Parent:** [`concept-design-master.md`](./concept-design-master.md) · **Status:** `Proposed` · **Date:** 2026-09-09
> **Cross-cut:** none · **Architecture:** [`ARC_20260909_A`](../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md)

---

## 1. Problem Statement

The current Gutenprint stack rests on foundational technologies designed over two decades ago:
1. **CUPS Driver Deprecation**: Apple and OpenPrinting have deprecated traditional PPD-based printer drivers (`lpadmin: Printer drivers are deprecated and will stop working in a future version of CUPS`). Future macOS and Linux releases will completely disable raster filter execution in `/usr/libexec/cups/filter/`.
2. **Fragile PPD Complexity**: Thousands of lines of complex PostScript PPD directives (`genppd.c`) are parsed by modern Cocoa/SwiftUI print sheets, leading to UI freezes, option collisions, and syntax warnings across macOS Ventura, Sonoma, and Sequoia.
3. **Legacy Autotools Toolchain**: `configure.ac`, `Makefile.am`, and `libtool` create high friction for macOS universal binary compilation (`arm64` + `x86_64`), developer onboarding, and CI/CD automation.
4. **Lack of Modern User Experience**: End users on macOS expect native menu-bar status widgets, live visual ink tank gauges, and 1-click head cleaning, rather than terminal scripts or legacy CUPS web forms.

> **One-line Statement**: Uplift Gutenprint from legacy PPD/filter architecture into a modern, maintainable, driverless **PAPPL Printer Application** accompanied by modern build systems, SwiftUI companion tools, and automated CI/CD.

---

## 2. Target Architecture: The Modern Printing Stack

```text
 ┌─────────────────────────────────────────────────────────────────────────────┐
 │                         macOS User Layer (SwiftUI)                          │
 │  ┌───────────────────────────────┐     ┌─────────────────────────────────┐  │
 │  │ Native macOS Print Dialog     │     │ Menu Bar Status Companion       │  │
 │  │ • Standard 2-Sided & B&W      │     │ • Live Ink Tank Gauge Gauges    │  │
 │  │ • Media & Quality Dropdowns   │     │ • Nozzle Check & Head Cleaning  │  │
 │  └──────────────┬────────────────┘     └────────────────┬────────────────┘  │
 └─────────────────┼───────────────────────────────────────┼───────────────────┘
                   │ IPP 2.0 / AirPrint (localhost:8631)   │ IPC / REST API
 ┌─────────────────▼───────────────────────────────────────▼───────────────────┐
 │               Gutenprint Modern Printer Application (PAPPL)                 │
 │  ┌───────────────────────────────────────────────────────────────────────┐  │
 │  │ Embedded IPP Server (IPP Everywhere / AirPrint / PWG Raster)          │  │
 │  ├───────────────────────────────────────────────────────────────────────┤  │
 │  │ Core Print Pipeline (Modular C99 / Rust FFI Engine)                   │  │
 │  │ • High-Precision Dithering (EvenTone, Hybrid Floyd-Steinberg)         │  │
 │  │ • Canon BJNP / USB Command Generator (G1000 / G1010 Family)           │  │
 │  │ • Bidirectional Hardware Telemetry (Ink Levels, Paper State, Errors)  │  │
 │  └───────────────────────────────────┬───────────────────────────────────┘  │
 └──────────────────────────────────────┼──────────────────────────────────────┘
                                        │ libusb-1.0 / IOKit Direct USB
                                        ▼
                         Canon PIXMA G1010 Hardware
```

---

## 3. Core Modernization Pillars

### Pillar 1: PAPPL-Based Driverless Printer Application
- **Zero-PPD Architecture**: Replace legacy PostScript PPD files and CUPS filters with a self-contained PAPPL daemon (`gutenprint-app`).
- **Native AirPrint / IPP Everywhere**: Automatically broadcasts via mDNS; macOS, iOS, Android, and Linux discover the printer driverlessly with native 2-sided, color mode, and media controls.
- **Embedded Web Administration**: Clean web dashboard (`http://localhost:8631`) providing printer status, supply levels, network configuration, and print job history without external dependencies.

### Pillar 2: Modern Build System & Multi-Arch Packaging (CMake / Meson)
- **Replace Autotools**: Migrate build configuration to modern CMake (3.25+) or Meson for sub-second configuration and multi-threaded compilation.
- **Universal Binaries**: Native cross-compilation for Apple Silicon (`arm64`) and Intel (`x86_64`).
- **Clean Library Separation**:
  - `libgutenprint-core`: Pure rendering, dithering, and color-management algorithms.
  - `libgutenprint-canon`: Canon raster command translator and USB packet framing.
  - `gutenprint-app`: The standalone PAPPL service executable.

### Pillar 3: Native macOS SwiftUI Companion App
- **Status Item Agent**: Lightweight menu-bar utility running in user space.
- **Real-Time Supplies Visualization**: Graphical ink levels for Cyan, Magenta, Yellow, and Black with low-ink warnings.
- **Maintenance Actions**: One-click buttons to execute Nozzle Check, Print Head Cleaning, and Deep Cleaning via `libusb` / IPP command packets.

### Pillar 4: Robust Code Quality, Safety & CI/CD
- **Automated GitHub Actions**: Multi-platform matrix builds (macOS Sonoma, Sequoia, Ubuntu LTS) on every commit.
- **Sanitizers & Fuzzing**: AddressSanitizer (ASan) and UndefinedBehaviorSanitizer (UBSan) running against raster decoders to eliminate buffer overflow risks.
- **ProjectOps v2 Governance**: Strict traceability connecting every architectural decision (`DEC`), concept (`CON`), and delivery plan (`PLN`).

---

## 4. Ideas Backlog

| # | Idea | Target Scope | Impact |
| ---: | --- | --- | --- |
| 1 | PAPPL Core Daemon | Phase 1: Prototype | Eliminates CUPS filter deprecation warnings permanently. |
| 2 | CMake Build System Transition | Phase 1: Tooling | Speeds up developer iteration and simplifies universal macOS builds. |
| 3 | SwiftUI Menu Bar Ink Monitor | Phase 2: UX | Delivers visual ink gauges and maintenance buttons natively. |
| 4 | Rust FFI Dithering Micro-Crate | Phase 3: Reliability | Memory-safe dither kernel with zero-copy buffer passing. |
| 5 | Signed & Notarized macOS `.pkg` | Phase 2: Release | Seamless drag-and-drop installer complying with Apple Gatekeeper. |

---

## 5. Scope & Boundary

- **In-Scope**:
  - Architectural blueprint for PAPPL migration.
  - Prototype CMake build definitions alongside legacy Autotools for smooth transition.
  - Design specifications for SwiftUI companion status agent.
- **Out-of-Scope (for immediate execution)**:
  - Discarding existing working CUPS queues immediately (the current setup remains active while the modern stack is developed).

---

## 6. Promotion Path

`CON004` -> Decision (`DEC`) -> Architecture (`ARC`) -> Plan (`PLN`) -> Execution Worklog.

## Footer

Parent: [`concept-design-master.md`](./concept-design-master.md) ·
Decisions: [`../decisions/decisions-master.md`](../decisions/decisions-master.md) ·
Plans: [`../plans/plans-master.md`](../plans/plans-master.md)

