# Plan — Canon G1010 Support and AirPrint Integration (`G1010`)

> **Parent:** [`../plans-master.md`](../plans-master.md) · **Code:** `G1010`
> **Status:** Active · **Owner:** nschabra

## Sources and Traceability

| S.No. | Code | Source record | Plan role | Status |
| ---: | --- | --- | --- | --- |
| 1 | `RUL` | [`../../rules.md`](../../rules.md) | Binding constraints and governance | Current |

## Statistics

`TL = PD + IP + CD`. From task markers below.

| S.No. | Plan Scope | TL | PD | IP | CD |
| ---: | --- | ---: | ---: | ---: | ---: |
| 1 | `G1010` direct tasks | 7 | 0 | 0 | 7 |
| 2 | Total | **7** | **0** | **0** | **7** |

## Context

Comprehensive Day One delivery of Canon PIXMA G1010 Gutenprint 5.3.5 drivers, macOS/Haiku build fixes, Apple Presets, Living Room AirPrint options forwarding, and g1010-ctl CLI management.

## 01. Day One Delivery Tasks

- [x] `G1010-01.01` Native Model Integration in `canon.xml` (binds model 17001000 with CMYK profiles)
- [x] `G1010-01.02` macOS & Haiku POSIX Build Compatibility in `scripts/global.mk` & `genppd.h` (`_DARWIN_C_SOURCE`)
- [x] `G1010-01.03` Modern Apple Presets (Color, B&W, Photo) & SNMP Supply Security in `genppd.c`
- [x] `G1010-01.04` Living Room AirPrint (`ippeveprinter`) Color, 2-Sided, and Speed Advertising
- [x] `G1010-01.05` Client Print Options Forwarding in `print_wrapper.sh`
- [x] `G1010-01.06` Interactive Console Management Tool `g1010-ctl` with Visual ANSI Ink Meters
- [x] `G1010-01.07` ProjectOps v2 Repository Governance Scaffolding & Root-Level Cleanup

## Footer Navigation

Parent: [`../plans-master.md`](../plans-master.md) · Plans Master: [`../plans-master.md`](../plans-master.md)
