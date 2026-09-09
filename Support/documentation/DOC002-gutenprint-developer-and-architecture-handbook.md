<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/g1010_hero-dark.svg">
  <img alt="Gutenprint Developer & Architecture Handbook" src="./assets/g1010_hero-light.svg" width="100%">
</picture>

# DOC002 — Gutenprint Developer & Subsystem Architecture Handbook

> **Parent:** [`documentation-master.md`](./documentation-master.md) · **Status:** Active · **Date:** 2026-09-09
> **Related Architecture:** [`ARC_20260909_A`](../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md)
> **Related Plans:** [`PLN001`](../plans/01-core/PLN001-canon-g1010-support-and-airprint-integration-plan.md) · [`PLN002`](../plans/02-architecture/PLN002-root-level-files-restructuring-and-clean-layout-plan.md)
> **Owner:** nschabra

---

## 1. Subsystem Architecture & Ingress Pipeline

The Gutenprint macOS print architecture routes print jobs through three distinct ingress paths into the core raster engine:

```text
  [ macOS Cocoa Client ]         [ iOS / AirPrint Client ]        [ Operator Terminal ]
  (Safari, Preview, Pages)       (iPhone, iPad, AirDrop)          (bin/g1010-ctl CLI)
             │                              │                              │
             ▼ PostScript / PDF             ▼ IPP Everywhere / URF         │ CUPS IPC (lpadmin)
  ┌──────────────────────────────────────────────────┐                     │
  │ macOS CUPS Spooler (scheduler :631)              │                     │
  └──────────────────────────┬───────────────────────┘                     │
                             │                                             ▼
                             ▼ CUPS Raster Stream                 ┌──────────────────┐
  ┌────────────────────────────────────────────────────────┐      │ Queue State &    │
  │ rastertogutenprint.5.3 (CUPS Raster Filter)            │      │ Ink Telemetry    │
  └──────────────────────────┬─────────────────────────────┘      └──────────────────┘
                             │
                             ▼ Dither & Color Mapping
  ┌────────────────────────────────────────────────────────┐
  │ libgutenprint.la (Core Dither & Micro-Step Engine)     │
  └──────────────────────────┬─────────────────────────────┘
                             │
                             ▼ BJNP / USB Pipeline
  ┌────────────────────────────────────────────────────────┐
  │ Canon PIXMA G1010 Hardware Interface (usb://)          │
  └────────────────────────────────────────────────────────┘
```

---

## 2. Canon PIXMA XML Driver Definition (`src/xml/printers/canon.xml`)

Native driver support for the Canon PIXMA G1010 is declared in the XML printer database:

```xml
<printer translate="name" name="Canon PIXMA G1010"
         driver="bjc-PIXMA-G1010"
         model="17001000"
         parameters="PIXMA_iP4000_params"
         subsumes="bjc-PIXMA-G1000"
         infourl="https://gutenprint.sourceforge.net">
</printer>
```

### Key Technical Parameters:
- **`driver="bjc-PIXMA-G1010"`**: Binds to the Canon BJC/PIXMA driver module in `src/main/print-canon.c`.
- **`model="17001000"`**: Uniquely identifies the G1010 ink-tank engine within Gutenprint's model registry.
- **`parameters="PIXMA_iP4000_params"`**: Inherits the 4-channel CMYK printhead geometry, micro-step ink drop sizes (2 pl / 5 pl), and resolution matrix (up to 4800×1200 dpi).
- **Validation**: Verified through `src/xml/printers/check_duplicate_printers.test`.

---

## 3. Darwin / Xcode Clang Compatibility (`_DARWIN_C_SOURCE`)

Modern Xcode Clang (version 15+) compiles with strict POSIX conformance. Standard Darwin system headers (`<netinet/ip.h>` included indirectly by `<cups/cups.h>`) require legacy BSD type definitions (`u_char`, `u_short`, `u_int`).

To prevent compilation errors without modifying SDK headers:
- In `scripts/global.mk`:
  ```makefile
  AM_CPPFLAGS = -D_DARWIN_C_SOURCE=1 ...
  ```
- In `src/cups/genppd.h`:
  ```c
  #ifndef _DARWIN_C_SOURCE
  #define _DARWIN_C_SOURCE 1
  #endif
  ```
- In out-of-tree builds:
  ```bash
  ../configure CPPFLAGS="-D_DARWIN_C_SOURCE=1" ...
  ```

---

## 4. Apple PPD Directives & Security Hardening

The CUPS PPD generator (`src/cups/genppd.c`) injects specialized Apple PPD attributes into generated PPDs:

### 4.1 Native macOS Presets
Enables macOS print sheets to offer instant one-click switching:
```text
*APPrinterPreset Color/Color: "*ColorModel RGB *StpColorPrecision Accurate *Quality Standard"
*APPrinterPreset BlackAndWhite/Black and White: "*ColorModel Gray *Quality Standard"
*APPrinterPreset Photo/Photo on Photo Paper: "*ColorModel RGB *Quality Best *MediaType GlossyPhoto"
```

### 4.2 Security Hardening Against Network Hangs
```text
*cupsSNMPSupplies: False
```
Prevents CUPS from issuing blocking unauthenticated SNMP v1/v2 queries over Wi-Fi or USB, eliminating beachball freezes when opening the macOS print sheet.

---

## 5. Out-of-Tree Build Pipeline

To maintain a clean source tree, compilation is executed in an isolated build folder:

```bash
# 1. Clean workspace creation
mkdir -p build && cd build

# 2. Configure with disabled legacy docbook tools
../configure --without-gimp2 --without-doc CPPFLAGS="-D_DARWIN_C_SOURCE=1"

# 3. Parallel compilation
make -j$(sysctl -n hw.ncpu)

# 4. Filter validation
./src/cups/rastertogutenprint.5.3 2>&1 | grep -i gutenprint
```

---

## 6. Remote Repository Synchronization Protocol

The project tracks three distinct upstream branches:

| Remote | URL | Role |
| :--- | :--- | :--- |
| **`origin`** | `git@github.com:nschabra/gutenprint.git` | Personal primary GitHub repository (Push/Pull) |
| **`echiu64`** | `git@github.com:echiu64/gutenprint.git` | Upstream GitHub parent fork |
| **`upstream`** | `https://git.code.sf.net/p/gimp-print/source` | Official SourceForge canonical codebase |

### Pulling SourceForge Updates:
```bash
git fetch upstream
git merge upstream/master
git push origin master
```

---

## 7. Footer Navigation

Parent: [`documentation-master.md`](./documentation-master.md) · Architecture: [`ARC_20260909_A`](../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md)
