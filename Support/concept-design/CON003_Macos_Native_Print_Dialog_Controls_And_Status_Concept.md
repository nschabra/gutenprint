<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/concept-design-dark.svg">
  <img alt="Concept Design" src="./assets/concept-design-light.svg" width="100%">
</picture>

# Concept — macOS Native Print Dialog Controls, Presets, and Hardware Status (`CON003`)

> **Parent:** [`concept-design-master.md`](./concept-design-master.md) · **Status:** `Proposed` · **Date:** 2026-09-09
> **Cross-cut:** none · **Fed Plan:** [`PLN004-macos-native-print-dialog-controls-presets-and-status-plan.md`](../plans/04-ui-ux/PLN004-macos-native-print-dialog-controls-presets-and-status-plan.md)
> **Research:** [`RSH_20260909_A`](../research/RSH_20260909_A_macos_print_dialog_ppd_options_and_ink_levels.md)

---

## 1. Problem

In macOS Ventura, Sonoma, and Sequoia, users opening the native print dialog (`Cmd+P`) for the Canon PIXMA G1010 encounter an unresponsive and incomplete interface:
- **Unresponsive `(i)` Buttons**: Under `Printer Options`, clicking the `(i)` button next to `Printer Features` or `Color Matching` does not open or respond, because the PPD overloads the sheet with 69 raw options, custom slider hints, and invalid envelope dimensions.
- **Missing Top-Level Controls**: The essential **Color vs Black & White** option is not exposed as a native dropdown.
- **Missing Two-Sided / Duplex Control**: The native macOS Two-Sided checkbox is hidden because standard PPD duplex directives (`*cupsBackSide: Normal`) are missing.
- **Unpopulated Presets**: The native macOS `Presets` dropdown does not offer standard 1-click photo, draft, or black-and-white presets.

> **One-line Statement**: The PPD must structure printer capabilities into standard Apple PPD groups so macOS renders native Color Mode, Two-Sided, Media & Quality, and Presets directly in the main print sheet without unneeded daemons or failing sub-sheets.

---

## 2. Concept

Deliver a first-class macOS native print dialog experience through standard CUPS PPD compliance:
1. **PPD Group Modernization**:
   - Organize options into Apple standard UI groups:
     - `*OpenGroup: Color/Color Options` with simplified `*OpenUI *ColorModel/Color Mode: PickOne` (`Gray/Black and White`, `RGB/Color`).
     - `*OpenGroup: Media/Media and Quality` with `*OpenUI *MediaType/Media Type` and `*OpenUI *StpQuality/Print Quality`.
   - Add `*cupsBackSide: Normal` to enable the native macOS **Two-Sided** print control under Layout.
   - Clean up non-standard option hints (`length slider input spinbox`) and resolve strict PPD size validation errors so the dialog sheet opens instantly without errors.
2. **Apple Print Presets (`*APPrinterPreset`)**:
   - Provide 4 clean presets in the PPD:
     - `Color_Standard` (Color - Standard)
     - `BW_Standard` (Black & White - Standard)
     - `Photo_Best` (Color Photo - High Quality)
     - `Draft_BW` (Draft - Black & White)
3. **Hardware Status & Ink Reporting**:
   - Suppress broken network SNMP polls on USB queue (`cupsSNMPSupplies: False`).
   - Query printer hardware state (paper jam, cover open, error codes) via `libusb` in `g1010-ctl`.
4. **Architectural Preservation**:
   - Maintain the single existing `ippeveprinter` instance on port 8631 (`com.local.ippeveprinter`).
   - Zero duplicate background daemons, zero redundant web servers.

---

## 3. Ideas Backlog

| # | Idea | Notes |
| ---: | --- | --- |
| 1 | Standard Apple UI Groups in `genppd.c` | Restructure PPD generation to output Apple-compatible groups (`Color`, `Media`, `Finishing`). |
| 2 | Duplex Activation via `*cupsBackSide` | Inject `*cupsBackSide: Normal` so macOS exposes Two-Sided controls. |
| 3 | Clean 1-Click Presets | Eliminate duplicate `Photo` preset keys and standardize dictionary options. |
| 4 | USB Hardware Status Bridge | Enhance `g1010-ctl` to report ink warning flags and hardware paper states via libusb. |

---

## 4. Scope

- **In-Scope**:
  - Restructure `/etc/cups/ppd/Canon_G1010.ppd` and `src/cups/genppd.c`.
  - Fix cupstestppd warnings and errors.
  - Enable native Color Mode dropdown, Two-Sided option, Media & Quality, and Presets.
  - Retain existing `com.local.ippeveprinter` listener on port 8631.
- **Out-of-Scope**:
  - Automatic hardware duplex unit installation (G1010 lacks duplexer hardware; software manual duplex is used).
  - Creating new launch daemons or background HTTP servers.

---

## 5. Open Questions

1. None — technical requirements and PPD group specifications are fully identified.

---

## 6. Promotion Path

`CON003` -> [`PLN004-macos-native-print-dialog-controls-presets-and-status-plan.md`](../plans/04-ui-ux/PLN004-macos-native-print-dialog-controls-presets-and-status-plan.md) -> Execution -> Verification.

## Footer

Parent: [`concept-design-master.md`](./concept-design-master.md) ·
Decisions: [`../decisions/decisions-master.md`](../decisions/decisions-master.md) ·
Plans: [`../plans/plans-master.md`](../plans/plans-master.md)

