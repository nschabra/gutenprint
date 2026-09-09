<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./Support/documentation/assets/g1010_hero-dark.svg">
  <img alt="Gutenprint 5.3.5 — Canon PIXMA G1010 & macOS AirPrint Hub" src="./Support/documentation/assets/g1010_hero-light.svg" width="100%">
</picture>

<br/>

[![Platform](https://img.shields.io/badge/Platform-macOS%20Sequoia%20%7C%20Sonoma%20%7C%20Ventura-007AFF?style=for-the-badge&logo=apple&logoColor=white)](https://apple.com)
[![Architecture](https://img.shields.io/badge/Architecture-Apple%20Silicon%20(ARM64)%20%7C%20x86__64-34C759?style=for-the-badge&logo=apple&logoColor=white)](https://apple.com)
[![Protocol](https://img.shields.io/badge/Protocol-IPP%20Everywhere%20%2F%20AirPrint%202.0-0A84FF?style=for-the-badge&logo=airplayvideo&logoColor=white)](./Support/architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md)
[![Governance](https://img.shields.io/badge/Governance-ProjectOps%20v2%20(LXC)-AF52DE?style=for-the-badge)](./Support/support-master.md)
[![License](https://img.shields.io/badge/License-GNU%20GPL%20v2-FF9500?style=for-the-badge)](./COPYING)

<p align="center">
  <b>High-Performance Open-Source Print Subsystem with Native Canon PIXMA G1010 Support, Apple GUI Presets, Living Room AirPrint Broadcast, and Terminal Management Console.</b>
</p>

---

</div>

## 🌟 Executive Overview

This repository provides an enterprise-hardened distribution of **Gutenprint 5.3.5** specifically optimized for modern macOS (Apple Silicon & Intel) and network environments. It introduces native driver and rasterization support for the **Canon PIXMA G1010** ink-tank printer family, full integration with macOS Cocoa print sheets, bidirectional AirPrint streaming from iOS/iPadOS devices, and zero-overhead terminal telemetry.

The entire codebase is governed under the **[ProjectOps v2](./Support/support-master.md)** framework and follows a clean, modular repository taxonomy.

---

## ⚡ Key Capabilities

| Capability | Canon OEM Driver | Gutenprint 5.3.5 Enhanced | Operational Advantage |
| :--- | :--- | :--- | :--- |
| **macOS Native Architecture** | Legacy Rosetta x86_64 translation | Native Apple Silicon (ARM64) & Intel (x86_64) | Zero translation latency, minimal memory footprint |
| **Apple Print Sheet Presets** | Generic defaults only | **Color**, **Black & White**, **Photo on Photo Paper** | 1-click toggling directly inside Safari, Preview, Pages & Word |
| **Double-Sided (Duplex)** | Hardware duplex (unsupported, jams) | Software / Manual Long-Edge Duplex (`DuplexNoTumble`) | Flawless 2-sided booklet printing without hardware faults |
| **Living Room AirPrint** | Requires proprietary vendor app | Native mDNS / DNS-SD IPP Everywhere (`ippeveprinter`) | Seamless driverless printing directly from iPhones & iPads |
| **GI-790 Ink Telemetry** | Vendor dialog app only | Live Visual ANSI Meters & Web UI (`:8631/supplies`) | Real-time level monitoring directly in Terminal or browser |
| **Cybersecurity Hardening** | Unauthenticated SNMP query hangs | Explicitly Disabled (`*cupsSNMPSupplies: False`) | Eliminates network timeout freezes and queue deadlocks |

---

## 🖥️ Console Control & Management Tool (`bin/g1010-ctl`)

A zero-dependency Python 3 operator CLI is symlinked directly at the repository root: [`bin/g1010-ctl`](./bin/g1010-ctl).

```text
$ ./bin/g1010-ctl status

===============================================================
   Canon PIXMA G1010 - Console Control & Installation Tool
         Gutenprint 5.3.5 / macOS & AirPrint Management
===============================================================

Configured CUPS Printer Queues:
  • Canon_G1010: idle
    Device: usb://Canon/G1010%20series?serial=004049
    Mode:   Color (RGB/CMYK)
    Duplex: None
    Quality: Standard

  • Canon_G1010_2: idle
    Device: dnssd://Canon%20G1010._ipps._tcp.local./?uuid=adb6d191-406e-357a-54d4-2e8a4685fc1d
    Mode:   Color (RGB/CMYK)
    Duplex: None
    Quality: Normal

AirPrint / Living Room Ink Supplies Status:
  Ink Waste Tank   [██████░░░░░░░░░░░░░░░░░░░]  25%
  Black Ink        [███████████████████░░░░░░]  75%
  Cyan Ink         [████████████░░░░░░░░░░░░░]  50%
  Magenta Ink      [████████░░░░░░░░░░░░░░░░░]  33%
  Yellow Ink       [█████████████████░░░░░░░░]  67%
```

### Essential Commands:
```bash
# 1. Live Telemetry & Queue Health
./bin/g1010-ctl status

# 2. Instant Color / Monochrome Mode Toggling
./bin/g1010-ctl set-mode color
./bin/g1010-ctl set-mode bw

# 3. Two-Sided (Duplex) Software Workflow
./bin/g1010-ctl set-duplex on
./bin/g1010-ctl set-duplex off

# 4. Interactive ASCII Management Menu
./bin/g1010-ctl menu

# 5. Direct Calibration Test Prints
./bin/g1010-ctl test-print --color
./bin/g1010-ctl test-print --bw

# 6. One-Command CUPS PPD Deployment
./bin/g1010-ctl install
```

---

## 🏗️ Building From Source (Out-of-Tree Paradigm)

This project adopts the clean **out-of-tree build** standard, ensuring the source tree remains 100% pristine.

### Prerequisites:
- macOS with Xcode Command Line Tools (`clang`, `make`)
- CUPS Development Headers & Libraries

### Build Instructions:
```bash
# 1. Create and enter isolated build directory
mkdir -p build && cd build

# 2. Configure with modern Darwin flags
../configure --without-gimp2 --without-doc CPPFLAGS="-D_DARWIN_C_SOURCE=1"

# 3. Compile across all CPU cores
make -j$(sysctl -n hw.ncpu)

# 4. Install drivers & filters into system CUPS (requires root)
sudo make install
```

---

## 📂 Repository Architecture & File Taxonomy

```
gutenprint-5.3.5/
├── bin/                       # Operator CLI entrypoints (bin/g1010-ctl)
├── build/                     # Out-of-tree build workspace (gitignored)
├── doc/                       # Comprehensive documentation & manuals
│   ├── history/               # Historical logs (ChangeLog, NEWS, README.legacy)
│   ├── users_guide/           # User manuals and formatting guides
│   └── developer/             # Developer and internal API documentation
├── include/                   # Public and internal C headers (gutenprint/)
├── m4/                        # Consolidated M4 macro definitions
│   ├── extra/                 # Supplementary build macros (formerly m4extra)
│   └── local/                 # Local Gutenprint extensions (formerly m4local)
├── man/                       # Unix manual pages (cups-genppd, escputil)
├── packaging/                 # Distribution & platform packaging
│   ├── macos/                 # macOS installer scripts, packages & dmg tools
│   ├── docker/                # Container build definitions & Dockerfiles
│   └── ci/                    # Continuous Integration manifests (.travis.yml)
├── po/                        # Internationalization & gettext translations
├── samples/                   # Test patterns & color samples
├── scripts/                   # Maintainer scripts & global makefile definitions
├── src/                       # Core driver implementation
│   ├── cups/                  # CUPS filters, backends & rastertogutenprint
│   ├── main/                  # Core Gutenprint library & dither engine
│   ├── xml/                   # Printer XML definitions (canon.xml G1010)
│   └── tools/matgen/          # Matrix generation scripts (formerly Matgen)
├── test/                      # Regression testing suite & validation patterns
├── Support/                   # ProjectOps v2 Engineering Governance
│   ├── architecture/          # Vector SVG diagrams & Architecture Records
│   ├── documentation/         # User guides & administrative playbooks
│   ├── plans/                 # Delivery milestones (PLN001, PLN002)
│   ├── context/               # Autonomous context & state fingerprints
│   └── rules.md               # Visual rules & project invariants
├── project-system.yaml        # ProjectOps v2 manifest (theme: macos)
├── configure.ac               # Top-level GNU Autoconf orchestrator (foreign mode)
├── Makefile.am                # Top-level GNU Automake build definition
├── COPYING                    # GNU General Public License v2
└── README.md                  # Root documentation landing page
```

---

## 🛡️ Governance, Architecture & Documentation Links

This project is governed under **ProjectOps v2**:

- **Governance Master Index**: [`Support/support-master.md`](./Support/support-master.md)
- **Project Rules & macOS Theme**: [`Support/rules.md`](./Support/rules.md)
- **System Architecture Record**: [`Support/architecture/ARC_20260909_A`](./Support/architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md)
- **Operator & Admin Guide**: [`Support/documentation/DOC001`](./Support/documentation/DOC001-canon-g1010-macos-airprint-guide.md)
- **Day One Delivery Plan**: [`Support/plans/01-core/PLN001`](./Support/plans/01-core/PLN001-canon-g1010-support-and-airprint-integration-plan.md)
- **Root Restructuring Plan**: [`Support/plans/02-architecture/PLN002`](./Support/plans/02-architecture/PLN002-root-level-files-restructuring-and-clean-layout-plan.md)
- **Changelog**: [`Support/changelog.md`](./Support/changelog.md)

---

## 🔄 Git Synchronization & Contributing

To sync and contribute changes to GitHub:

1. **GitHub Fork**: Fork [`echiu64/gutenprint`](https://github.com/echiu64/gutenprint) to your authenticated GitHub account (`nschabra/gutenprint`).
2. **Push Feature Branch**:
   ```bash
   git push -u fork feature/canon-g1010-macos-support
   ```
3. **Open Pull Request**: Navigate to GitHub and submit a PR from `nschabra/gutenprint:feature/canon-g1010-macos-support` to `echiu64/gutenprint:master`.
