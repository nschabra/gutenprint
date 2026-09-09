<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/gaps-issues-dark.svg">
  <img alt="Gaps and Issues" src="./assets/gaps-issues-light.svg" width="100%">
</picture>

# Active Gap Cluster

> **Parent:** [`gaps-issues-master.md`](./gaps-issues-master.md)

## Status Summary

| S.No. | Lifecycle State | Count | % of Total |
| --- | --- | --- | --- |
| 1 | Open | 0 | 0.0% |
| 2 | In Delivery | 0 | 0.0% |
| 3 | Resolved / Closed | 1 | 100.0% |
| 4 | Abandoned / Deprecated | 0 | 0.0% |
| 5 | Rejected | 0 | 0.0% |
| 6 | Unknown | 0 | 0.0% |
| 7 | **Total Registered** | **1** | **100.0%** |

| S.No. | Gap | State | Title |
| --- | --- | --- | --- |
| 1 | G_01 | Resolved / Closed | Printer Features Dialog Exposes Raw CMYK and Cluttered Internal Driver Options |
| 2 | **Total** | **1** | All records in this cluster |

### G_01 — Printer Features Dialog Exposes Raw CMYK and Cluttered Internal Driver Options

| Field | Value |
| :--- | :--- |
| **Status** | Closed |
| **Owning Plan** | `MACUI` |

#### 1. Problem
In macOS Print Dialog, opening Printer Features popup under General displays Color Model as CMYK instead of Color/RGB, alongside raw driver options like Color Precision and Shrink Page, confusing users.

#### 2. Evidence
- media_1788919754549.png

#### 3. Resolution
Planned for delivery under `MACUI`.

#### 4. Verification
- [x] Conformance verified with zero regressions.

#### 5. Progress
- 2026-09-09: Gap intake opened.

**Closed** — 2026-09-09 · Plan `MACUI-02.01` · Worklog `WL_20260909_C`

**Changed:** Files modified and verified.

**Verified by:** Eliminated raw CMYK default, suppressed InkType, suppressed Color Precision, grouped options into standard Apple groups, verified lpoptions and cupstestppd PASS

**Followed / touched:** Rules — · Architecture — · Decisions — · Concept/Research — · Diagrams —

