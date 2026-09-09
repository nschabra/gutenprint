# Gutenprint 5.3.5 — Enhanced with Canon PIXMA G1010 & macOS AirPrint

This repository is an enhanced distribution of **Gutenprint 5.3.5** tailored for modern macOS and Haiku systems, featuring native driver support and management tools for the **Canon PIXMA G1010** ink-tank printer family.

---

## Key Features

1. **Native Canon PIXMA G1010 Support**:
   - Model definition with accurate CMYK color mapping, resolution matrices (up to 4800x1200 dpi), and borderless photo paper profiles.
2. **Apple GUI Presets & macOS ColorSync**:
   - Native macOS print panel presets: **Color**, **Black & White**, and **Photo on Photo Paper**.
   - Two-Sided (Duplex) software workflow enabled in standard print dialogs.
   - Built-in cybersecurity protection (`*cupsSNMPSupplies: False`) to prevent unauthenticated network SNMP hangs.
3. **Living Room AirPrint & Web UI Integration**:
   - Automated IPP Everywhere / AirPrint service (`ippeveprinter`) with live ink supplies reporting at `https://<ip>:8631/supplies`.
   - Full options forwarding from iOS and macOS devices to the CUPS printer queue.
4. **Console-Based Installation & Control Tool (`g1010-ctl`)**:
   - Interactive terminal manager located at [`src/cups/g1010-ctl`](./src/cups/g1010-ctl).
   - Visual ANSI ink level meters, one-command PPD installation, Color/B&W mode switching, and calibration test prints.
5. **Project Governance**:
   - Managed under [ProjectOps v2](./Support/support-master.md) governance (`Support/`).

---

## Console Quickstart

```bash
# Check printer queue status & live ink levels
./src/cups/g1010-ctl status

# Set default mode to Color (RGB)
./src/cups/g1010-ctl set-mode color

# Set default mode to Black & White (Gray)
./src/cups/g1010-ctl set-mode bw

# Launch the interactive terminal menu
./src/cups/g1010-ctl menu

# Send a calibration test print
./src/cups/g1010-ctl test-print --color
```

---

## Project Documentation & Architecture

For development runbooks, architectural decision records, and roadmaps, see:
- [ProjectOps Governance Master](./Support/support-master.md)
- [Rules & Guidelines](./Support/rules.md)
- [Plans & Milestones](./Support/plans/plans-master.md)
