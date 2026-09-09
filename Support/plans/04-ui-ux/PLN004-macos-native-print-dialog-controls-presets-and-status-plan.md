# Plan — macOS Native Print Dialog Controls, Presets, and Status (`MACUI`)

> **Parent:** [`../plans-master.md`](../plans-master.md) · **Code:** `MACUI`
> **Status:** Active · **Owner:** Agent

## Sources and Traceability

| S.No. | Code | Source record | Plan role | Status |
| ---: | --- | --- | --- | --- |
| 1 | `RUL` | [`../../rules.md`](../../rules.md) | Binding constraints and governance | Current |
| 2 | `RSH` | [`../../research/RSH_20260909_A_macos_print_dialog_ppd_options_and_ink_levels.md`](../../research/RSH_20260909_A_macos_print_dialog_ppd_options_and_ink_levels.md) | Research on PPD groups, duplex, and ink status | Complete |
| 3 | `CON` | [`../../concept-design/CON003_Macos_Native_Print_Dialog_Controls_And_Status_Concept.md`](../../concept-design/CON003_Macos_Native_Print_Dialog_Controls_And_Status_Concept.md) | Concept for macOS native print dialog UI | Proposed |
| 4 | `GAP` | [`../../gaps-issues/gap_cluster_active.md`](../../gaps-issues/gap_cluster_active.md) | Defect Remediation (`G_01`) | Active |

## Statistics

`TL = PD + IP + CD`. From task markers below.

| S.No. | Plan Scope | TL | PD | IP | CD |
| ---: | --- | ---: | ---: | ---: | ---: |
| 1 | `MACUI` direct tasks | 11 | 0 | 0 | 11 |
| 2 | Total | **11** | **0** | **0** | **11** |

## Context

Deliver a fully functioning native macOS Print Dialog (`Cmd+P`) for the Canon PIXMA G1010:
1. Fix unresponsive `(i)` info buttons under `Printer Options` by restructuring PPD options into standard Apple UI groups.
2. Expose **Color vs Black & White** as a native top-level dropdown.
3. Enable the native **Two-Sided (Duplex)** control under Layout via `*cupsBackSide: Normal`.
4. Provide standard 1-click **Presets** (`Color`, `Black and White`, `Photo`, `Draft`).
5. Eliminate raw driver noise (CMYK default, Color Precision) in `Printer Features` (`G_01`).
6. Maintain single listener integrity on port 8631 (`com.local.ippeveprinter`) without duplicate daemons.

## 01. Execution Tasks

- [x] `MACUI-01.01` Audit current PPD baseline and eliminate invalid dimensions (`w229h459_l`, `w255h581_l`, `w277h538_l`) in `cupstestppd`
- [x] `MACUI-01.02` Structure Apple standard UI groups (`*OpenGroup: Color/Color Options`, `*OpenGroup: Media/Media and Quality`) in `genppd.c`
- [x] `MACUI-01.03` Inject `*cupsBackSide: Normal` and configure `*Duplex` directives to activate native macOS Two-Sided controls
- [x] `MACUI-01.04` Standardize `ColorModel` options to clean `Gray` (Black and White) and `RGB` (Color) entries with proper default selection
- [x] `MACUI-01.05` Generate unified Apple Print Presets (`*APPrinterPreset`) for 1-click preset switching without duplicate keys
- [x] `MACUI-01.06` Regenerate active PPDs (`/etc/cups/ppd/Canon_G1010.ppd` and `/etc/cups/ppd/Canon_G1010_2.ppd`) and reload CUPS daemon
- [x] `MACUI-01.07` Verify macOS print dialog UI controls, Presets dropdown, and confirm zero daemon duplication

## 02. Printer Features UI Clutter & Color Model Rectification Tasks

- [x] `MACUI-02.01` Structure all Printer Features into Apple groups (`Color Options`, `Media and Quality`, `Finishing Options`) and purge internal driver options (`Color Precision`, raw shrink modes)
- [x] `MACUI-02.02` Enforce strict `RGB/Color` default and `Gray/Black and White` fallback for `ColorModel`, removing raw `CMYK`
- [x] `MACUI-02.03` Recompile PPD, update `/etc/cups/ppd/Canon_G1010.ppd` and `src/cups/Canon_PIXMA_G1010.ppd`, and verify `lpoptions` and `cupstestppd`
- [x] `MACUI-02.04` Re-build `releases/Canon-PIXMA-G1010-v5.3.5.pkg` and verify checksums in `releases/README.md`

## Footer Navigation

Parent: [`../plans-master.md`](../plans-master.md) · Plans Master: [`../plans-master.md`](../plans-master.md)
