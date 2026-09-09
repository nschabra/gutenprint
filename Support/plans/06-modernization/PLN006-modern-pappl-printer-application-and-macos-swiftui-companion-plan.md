# Plan — Modern PAPPL Printer Application and macOS SwiftUI Companion (`PAPPL`)

> **Owns:** Delivery of modern driverless PAPPL printer application daemon (`gutenprint-app`), modular CMake build toolchain, and macOS native SwiftUI menu-bar companion app with visual ink tank telemetry.
>
> **Does not own:** Legacy CUPS 5.3 raster filter maintenance or PPD PostScript text parsers.

## Position

Parent: [`../plans-master.md`](../plans-master.md) · Siblings: [`PLN001`](../01-core/PLN001-canon-g1010-support-and-airprint-integration-plan.md), [`PLN004`](../04-ui-ux/PLN004-macos-native-print-dialog-controls-presets-and-status-plan.md), [`PLN005`](../05-distribution/PLN005-homebrew-console-distribution-and-standalone-release-pkg-pipeline-plan.md)

## Header Block

- **Plan code:** `PAPPL`
- **Status:** STRUCTURE READY
- **Owner:** Agent
- **Opened:** 2026-09-09

## Sources and Traceability

| S.No. | Code | Source record | Plan role | Status |
| ---: | --- | --- | --- | --- |
| 1 | `RUL` | [`../../rules.md`](../../rules.md) | Binding constraints and governance | Current |
| 2 | `CON` | [`../../concept-design/CON004_Modern_Printer_Application_Stack_Uplift_And_Pappl_Architecture_Concept.md`](../../concept-design/CON004_Modern_Printer_Application_Stack_Uplift_And_Pappl_Architecture_Concept.md) | Uplift concept and ideas backlog | Proposed |
| 3 | `DEC` | [`../../decisions/DEC_20260909_A_adopt_pappl_driverless_architecture_and_swiftui.md`](../../decisions/DEC_20260909_A_adopt_pappl_driverless_architecture_and_swiftui.md) | Decision to adopt PAPPL, CMake, and SwiftUI companion | Accepted |
| 4 | `ARC` | [`../../architecture/ARC_20260909_B_modern_pappl_printer_application_and_swiftui_companion.md`](../../architecture/ARC_20260909_B_modern_pappl_printer_application_and_swiftui_companion.md) | Target system topology and component boundaries | Active |

## Statistics

`TL = PD + IP + CD`. From task markers below.

| S.No. | Plan Scope | TL | PD | IP | CD |
| ---: | --- | ---: | ---: | ---: | ---: |
| 1 | `PAPPL` direct tasks | 15 | 15 | 0 | 0 |
| 2 | Total | **15** | **15** | **0** | **0** |

## Context

CUPS PPD drivers and filters are deprecated across macOS and Linux. Future OS versions run purely driverless printing via IPP Everywhere / AirPrint. This plan delivers the next-generation architecture:
1. Migrates Gutenprint build infrastructure to modern CMake 3.25+.
2. Builds standalone PAPPL Printer Application daemon (`gutenprint-app`) embedding an IPP 2.0 / AirPrint server on port 8631.
3. Implements a modern native macOS SwiftUI menu-bar companion (`CanonG1010Companion.app`) showing live MegaTank ink levels and maintenance controls.
4. Introduces multi-arch universal compilation (`arm64` + `x86_64`) with automated GitHub Actions CI/CD.

## 01. CMake build toolchain migration tasks

Autotools (`configure.ac`, `Makefile.am`) creates high friction for macOS multi-arch compilation. These tasks deliver a modern, sub-second CMake build system.

- [ ] `PAPPL-01.01` **[P1]** Author root `CMakeLists.txt` supporting modular build targets and `CMAKE_OSX_ARCHITECTURES` universal builds
- [ ] `PAPPL-01.02` **[P1]** Create `src/lib/CMakeLists.txt` compiling `libgutenprint-core` as a clean shared library
- [ ] `PAPPL-01.03` **[P2]** Implement CMake package configuration exports (`GutenprintConfig.cmake`) for external linking

## 02. PAPPL driverless printer daemon tasks

Replace fragile PPD files and CUPS filters with an OpenPrinting PAPPL printer application broadcasting natively over mDNS.

- [ ] `PAPPL-02.01` **[P1]** Scaffold `src/pappl/main.c` initializing PAPPL system context, embedded web server, and port 8631 binding
- [ ] `PAPPL-02.02` **[P1]** Register Canon PIXMA G1000/G1010 driver callbacks for PWG Raster, Apple Raster, and PDF decoding
- [ ] `PAPPL-02.03` **[P1]** Configure driverless IPP attributes (`color-supported`, `sides-supported`, `media-supported`) for native macOS UI controls
- [ ] `PAPPL-02.04` **[P2]** Implement embedded HTTP admin console (`http://localhost:8631`) for status, job history, and configuration

## 03. macOS SwiftUI status item companion tasks

Users on macOS expect a clean graphical menu-bar status tool rather than terminal scripts. These tasks construct the native SwiftUI menu-bar companion agent.

- [ ] `PAPPL-03.01` **[P1]** Create Xcode/SwiftPM project for `CanonG1010Companion` with `LSUIElement` background menu-bar status item
- [ ] `PAPPL-03.02` **[P1]** Design Tahoe Liquid Glass SwiftUI views displaying live graphical ink tanks (Cyan, Magenta, Yellow, Black)
- [ ] `PAPPL-03.03` **[P2]** Add 1-click maintenance action buttons for Nozzle Check, Head Cleaning, and Deep Cleaning in the SwiftUI popup sheet

## 04. Hardware telemetry and maintenance IPC tasks

Bridge user-space UI controls to direct hardware USB communication and PAPPL daemon queries.

- [ ] `PAPPL-04.01` **[P1]** Implement local JSON IPC endpoint (`/api/printer/status`) inside `gutenprint-app` exposing live ink levels and device state
- [ ] `PAPPL-04.02` **[P1]** Implement bidirectional Canon USB command handler querying ink telemetry via `libusb-1.0`
- [ ] `PAPPL-04.03` **[P2]** Wire SwiftUI companion app to poll `/api/printer/status` and trigger maintenance commands via REST/IPC

## 05. Multi-architecture packaging and CI/CD tasks

Automate delivery and quality assurance across Apple Silicon and Intel platforms.

- [ ] `PAPPL-05.01` **[P2]** Author GitHub Actions workflow matrix compiling CMake targets on macOS Sonoma and Sequoia runners
- [ ] `PAPPL-05.02` **[P2]** Package `gutenprint-app` and `CanonG1010Companion.app` into automated signed/notarized `.pkg` releases

## Milestones

| S.No. | Milestone | Expected observable outcome | Evidence |
| ---: | --- | --- | --- |
| 1 | `PAPPL-M0` | Architecture & Plan Accepted | Governance records and CMake skeleton committed |
| 2 | `PAPPL-M1` | CMake Build Functional | Sub-second compilation of `libgutenprint-core` on arm64 and x86_64 |
| 3 | `PAPPL-M2` | Standalone PAPPL Daemon Active | Native AirPrint discovery without PPDs on port 8631 |
| 4 | `PAPPL-M3` | SwiftUI Companion Operational | Menu-bar status item renders live MegaTank gauges |
| 5 | `PAPPL-M4` | Automated CI/CD Verified | GitHub Actions clean multi-platform build and release package generation |

## Dependencies versus Correlation

| S.No. | Relationship | Target Record | Meaning / Effect |
| ---: | --- | --- | --- |
| 1 | Dependency | [`DEC_20260909_A`](../../decisions/DEC_20260909_A_adopt_pappl_driverless_architecture_and_swiftui.md) | Authorizes technical architecture; blocks implementation |
| 2 | Dependency | [`ARC_20260909_B`](../../architecture/ARC_20260909_B_modern_pappl_printer_application_and_swiftui_companion.md) | Defines component topology; blocks daemon scaffolding |
| 3 | Correlation | [`PLN004`](../04-ui-ux/PLN004-macos-native-print-dialog-controls-presets-and-status-plan.md) | Current CUPS PPD queue remains active during PAPPL transition |
| 4 | Correlation | [`PLN005`](../05-distribution/PLN005-homebrew-console-distribution-and-standalone-release-pkg-pipeline-plan.md) | Homebrew and PKG distribution channels will package the new daemon |

## Footer Navigation

Parent: [`../plans-master.md`](../plans-master.md) · Plans Master: [`../plans-master.md`](../plans-master.md)
