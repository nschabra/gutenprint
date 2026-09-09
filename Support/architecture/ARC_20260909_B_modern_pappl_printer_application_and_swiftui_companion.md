<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/architecture-dark.svg">
  <img alt="Architecture Master" src="./assets/architecture-light.svg" width="100%">
</picture>

# Architecture — Modern PAPPL Printer Application & macOS SwiftUI Companion (`ARC_20260909_B`)

> **Parent:** [`architecture-master.md`](./architecture-master.md) · **Status:** `Active` · **Date:** 2026-09-09
> **Concept:** [`CON004`](../concept-design/CON004_Modern_Printer_Application_Stack_Uplift_And_Pappl_Architecture_Concept.md) · **Decision:** [`DEC_20260909_A`](../decisions/DEC_20260909_A_adopt_pappl_driverless_architecture_and_swiftui.md)
> **Plan:** [`PLN006`](../plans/06-modernization/PLN006-modern-pappl-printer-application-and-macos-swiftui-companion-plan.md)

---

## 1. System Boundary & Component Topology

```text
 ┌─────────────────────────────────────────────────────────────────────────────┐
 │                         macOS User Session (Aqua / SwiftUI)                 │
 │  ┌───────────────────────────────┐     ┌─────────────────────────────────┐  │
 │  │ Native macOS Print Dialog     │     │ Menu Bar Status Companion       │  │
 │  │ • Driverless AirPrint Sheets  │     │ • Live MegaTank Ink Gauges      │  │
 │  │ • Top-level 2-Sided & Color   │     │ • 1-Click Nozzle Cleaning       │  │
 │  └──────────────┬────────────────┘     └────────────────┬────────────────┘  │
 └─────────────────┼───────────────────────────────────────┼───────────────────┘
                   │ IPP 2.0 / AirPrint                    │ Local REST / IPC
                   │ http://localhost:8631/ipp/print       │ http://localhost:8631/api
 ┌─────────────────▼───────────────────────────────────────▼───────────────────┐
 │               Modern Gutenprint Printer Application (PAPPL)                 │
 │  ┌───────────────────────────────────────────────────────────────────────┐  │
 │  │ Embedded HTTP & IPP 2.0 Server (mDNS / DNS-SD Service Discovery)      │  │
 │  ├───────────────────────────────────────────────────────────────────────┤  │
 │  │ Raster Processing Pipeline (PWG Raster, Apple Raster, PDF Decoder)    │  │
 │  ├───────────────────────────────────────────────────────────────────────┤  │
 │  │ Gutenprint Driver Core (C99 / CMake Built Shared Framework)           │  │
 │  │ • High-Precision Dithering Matrix (EvenTone)                          │  │
 │  │ • Canon BJNP / USB Command Generator (G1000/G1010 Family)             │  │
 │  │ • Bidirectional Device Telemetry Provider                             │  │
 │  └───────────────────────────────────┬───────────────────────────────────┘  │
 └──────────────────────────────────────┼──────────────────────────────────────┘
                                        │ libusb-1.0 / IOKit Direct USB
                                        ▼
                         Canon PIXMA G1010 Hardware
```

---

## 2. Component Specifications

### 2.1 Gutenprint Core Shared Library (`libgutenprint-core`)
- Built via modern CMake (`CMakeLists.txt`).
- Modularized rendering pipeline decoupled from legacy CUPS filter binaries.
- Pure C99 dither calculation with thread-safe memory allocations.

### 2.2 PAPPL Printer Application Daemon (`gutenprint-app`)
- Standalone C executable linked against OpenPrinting PAPPL 1.4+.
- Manages embedded web server on port `8631`.
- Emits IPP attributes: `color-supported: true`, `sides-supported: one-sided, two-sided-long-edge, two-sided-short-edge`.
- Handles USB device auto-detection via `papplPrinterAdd` and `libusb-1.0`.

### 2.3 SwiftUI Menu Bar Companion (`CanonG1010Companion.app`)
- Lightweight native macOS Menu Bar agent (`LSUIElement = true`).
- Periodically queries `/api/printer/status` or reads USB telemetry.
- Renders translucent Liquid Glass styled MegaTank ink indicators (Black, Cyan, Magenta, Yellow).
- Dispatches maintenance operations: Nozzle Check Pattern, Deep Cleaning, Roller Cleaning.

### 2.4 Modern CMake Toolchain & Multi-Arch CI/CD
- Replaces legacy Autotools (`configure.ac`, `Makefile.am`).
- Supports `CMAKE_OSX_ARCHITECTURES="arm64;x86_64"` out of the box.
- Integrated AddressSanitizer (ASan) and automated test runner `ctest`.

---

## 3. Promotion Path & Delivery Traceability

`CON004` -> `DEC_20260909_A` -> `ARC_20260909_B` -> Plan [`PLN006`](../plans/06-modernization/PLN006-modern-pappl-printer-application-and-macos-swiftui-companion-plan.md).

## Footer Navigation

Parent: [`architecture-master.md`](./architecture-master.md) · Decisions: [`../decisions/decisions-master.md`](../decisions/decisions-master.md)
