# Plan — Root Level Files Restructuring & Clean Repository Architecture (`ROOTLAY`)

> **Parent:** [`../plans-master.md`](../plans-master.md) · **Code:** `ROOTLAY`
> **Status:** Active · **Owner:** nschabra

## Sources and Traceability

| S.No. | Code | Source record | Plan role | Status |
| ---: | --- | --- | --- | --- |
| 1 | `RUL` | [`../../rules.md`](../../rules.md) | Binding constraints and governance | Current |
| 2 | `ARC` | [`../../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md`](../../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md) | System and component architecture | Current |

## Statistics

`TL = PD + IP + CD`. From task markers below.

| S.No. | Plan Scope | TL | PD | IP | CD |
| ---: | --- | ---: | ---: | ---: | ---: |
| 1 | `ROOTLAY` direct tasks | 6 | 0 | 0 | 6 |
| 2 | Total | **6** | **0** | **0** | **6** |

## Context

Eliminate root directory sprawl (reducing from 48 items to 12 files and structured subdirectories) by organizing historical documentation, packaging scripts, M4 macros, and build artifacts according to standard POSIX/Autotools practices.

## 01. Restructuring & Layout Tasks

- [x] `ROOTLAY-01.01` Group historical logs (`ChangeLog`, `ChangeLog.pre-5.2.11`, `ABOUT-NLS`, `NEWS`, `README`, `INSTALL`, `AUTHORS`) into `doc/history/` and `doc/`
- [x] `ROOTLAY-01.02` Consolidate packaging assets (`macosx/`, `container-build/`, `.travis.yml`, `README.package`) into unified `packaging/` directory
- [x] `ROOTLAY-01.03` Consolidate M4 macros (`m4extra/`, `m4local/`) into `m4/extra/` and `m4/local/`
- [x] `ROOTLAY-01.04` Relocate orphaned `Matgen/` directory into `src/tools/matgen/`
- [x] `ROOTLAY-01.05` Update build configuration (`configure.ac`, `Makefile.am`, `scripts/autogen.sh`, `.gitignore`) for `foreign` mode and macro search paths
- [x] `ROOTLAY-01.06` Clean generated in-tree build clutter from root and verify out-of-tree `build/` compilation and tests

## Footer Navigation

Parent: [`../plans-master.md`](../plans-master.md) · Plans Master: [`../plans-master.md`](../plans-master.md)
