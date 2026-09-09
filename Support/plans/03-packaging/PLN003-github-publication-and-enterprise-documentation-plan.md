# Plan — GitHub Publication, Architecture Handbooks & Enterprise Documentation (`PUBDOC`)

> **Parent:** [`../plans-master.md`](../plans-master.md) · **Code:** `PUBDOC`
> **Status:** Active · **Owner:** nschabra

## Sources and Traceability

| S.No. | Code | Source record | Plan role | Status |
| ---: | --- | --- | --- | --- |
| 1 | `RUL` | [`../../rules.md`](../../rules.md) | Binding constraints and governance | Current |
| 2 | `ARC` | [`../../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md`](../../architecture/ARC_20260909_A_canon_g1010_macos_airprint_architecture.md) | System and component architecture | Current |
| 3 | `DOC` | [`../../documentation/DOC001-canon-g1010-macos-airprint-guide.md`](../../documentation/DOC001-canon-g1010-macos-airprint-guide.md) | Operator & deployment guide | Current |
| 4 | `DOC` | [`../../documentation/DOC002-gutenprint-developer-and-architecture-handbook.md`](../../documentation/DOC002-gutenprint-developer-and-architecture-handbook.md) | Developer & subsystem handbook | Current |

## Statistics

`TL = PD + IP + CD`. From task markers below.

| S.No. | Plan Scope | TL | PD | IP | CD |
| ---: | --- | ---: | ---: | ---: | ---: |
| 1 | `PUBDOC` direct tasks | 6 | 0 | 0 | 6 |
| 2 | Total | **6** | **0** | **0** | **6** |

## Context

Publish the Gutenprint 5.3.5 Canon G1010 distribution to personal GitHub (`nschabra/gutenprint`), configure tripartite remotes (personal GitHub, parent fork, canonical SourceForge), author comprehensive operator and developer handbooks, and integrate dynamic macOS Dark/Light SVG hero banners.

## 01. Publication & Documentation Tasks

- [x] `PUBDOC-01.01` Establish personal GitHub repository (`nschabra/gutenprint`) and configure tripartite remotes (`origin`, `echiu64`, `upstream`)
- [x] `PUBDOC-01.02` Push all commits and branches (`master`, `feature/canon-g1010-macos-support`) to GitHub
- [x] `PUBDOC-01.03` Author and embed dynamic macOS Dark/Light SVG hero banners in root `README.md`
- [x] `PUBDOC-01.04` Author `DOC001` Operator Guide for Canon G1010 macOS & AirPrint
- [x] `PUBDOC-01.05` Author `DOC002` Developer & Architecture Handbook (CUPS filters, dither matrices, XML definitions, build pipeline)
- [x] `PUBDOC-01.06` Wire documentation records into `documentation-master.md` and verify with `pdm audit Support`

## Footer Navigation

Parent: [`../plans-master.md`](../plans-master.md) · Plans Master: [`../plans-master.md`](../plans-master.md)
