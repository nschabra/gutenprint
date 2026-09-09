# Plan — Homebrew Console Distribution and Standalone Release PKG Pipeline (`DIST`)

> **Parent:** [`../plans-master.md`](../plans-master.md) · **Code:** `DIST`
> **Status:** Active · **Owner:** Agent

## Sources and Traceability

| S.No. | Code | Source record | Plan role | Status |
| ---: | --- | --- | --- | --- |
| 1 | `RUL` | [`../../rules.md`](../../rules.md) | Binding constraints and governance | Current |
| 2 | `CON` | [`../../concept-design/CON005_Homebrew_And_Release_Pkg_Distribution_Concept.md`](../../concept-design/CON005_Homebrew_And_Release_Pkg_Distribution_Concept.md) | Concept Intake | Current |

## Statistics

`TL = PD + IP + CD`. From task markers below.

| S.No. | Plan Scope | TL | PD | IP | CD |
| ---: | --- | ---: | ---: | ---: | ---: |
| 1 | `DIST` direct tasks | 7 | 7 | 0 | 0 |
| 2 | **Total** | **7** | **7** | **0** | **0** |

## Context

Deliver a dual-channel distribution pipeline for Canon PIXMA G1010 on macOS:
1. Homebrew Console Formula (`Formula/canon-pixma-g1010.rb`) with background service orchestration.
2. Standalone `.pkg` Release Pipeline (`releases/`) with automated queue provisioning.
3. Companion CLI tool (`bin/canon-g1010`) for headless status, setup, and diagnostics.

## 01. Implementation Tasks

- [ ] `DIST-01.01` Develop unified companion CLI `bin/canon-g1010` supporting status, setup, test-page, and clean commands
- [ ] `DIST-01.02` Author sophisticated Homebrew formula `Formula/canon-pixma-g1010.rb` with integrated service definition and caveats
- [ ] `DIST-01.03` Develop release packaging script `packaging/macos/build-release-pkg.sh` using Apple `pkgbuild`
- [ ] `DIST-01.04` Implement `packaging/macos/scripts/postinstall` for automatic daemon activation and `Canon_G1010_2` queue provisioning
- [ ] `DIST-01.05` Build standalone release package `releases/Canon-PIXMA-G1010-v5.3.5.pkg` and verify with `pkgutil`
- [ ] `DIST-01.06` Generate `releases/README.md` with SHA256 checksums, release notes, and install instructions
- [ ] `DIST-01.07` Create Tahoe Liquid Glass architecture diagram for distribution channels using `ThemeStyleOps` / `svgImageOpsLoop`

## Footer Navigation

Parent: [`../plans-master.md`](../plans-master.md) · Plans Master: [`../plans-master.md`](../plans-master.md)
