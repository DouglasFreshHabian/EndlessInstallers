# 🖥️ Endless Installers (Cosmetic Terminal Simulators)
[![asciicast](https://asciinema.org/a/763047.svg)](https://asciinema.org/a/763047)
A collection of **three fully safe, purely cosmetic terminal simulators** that mimic Linux installer/update behavior.
These scripts generate **realistic-looking** package operations, progress bars, repo fetches, and system setup sequences — but they **do not install anything** and **perform no system changes**.

Great for:

* terminal aesthetics
* demos and presentations
* pranks
* screensaver-style loops
* learning animations & CLI UX

---

## 🎭 Included Scripts

### 1. **Endless Ubuntu**

Simulates an endless Debian/Ubuntu-style `apt-get update` and `apt install` loop with:

* Realistic repo hits, misses, and downloads
* Randomized package names and versions
* Animated progress bars
* Cosmetic unpacking, setting-up, and compiling steps

---

### 2. **Endless Kali**

A Kali-themed installer simulator that includes:

* `apt update` + `apt install` simulation
* Kali-flavored package prefixes (exploit, pentest, recon…)
* Custom-themed installs for:

  * **hashcat**
  * **aircrack-ng**
  * **starkiller**
* Animated GPU/kernel setup sequences
* Offensive-security style terminal prompts

---

### 3. **Endless Fedora**

A Fedora-themed DNF-based simulator that mimics:

* `dnf check-update` and `dnf install` behavior
* Fedora/RPMFusion repo listings
* RPM-style version strings
* DNF’s “Dependencies resolved”, “Running scriptlet”, and verification stages
* Delta-RPM vibes and verification passes

---

## 🚀 Running a Script

Make the file executable:

```bash
chmod +x <scriptname>.sh
```

Run it:

```bash
./<scriptname>.sh
```

Stop anytime with **Ctrl + C**.

---

## 🔒 Safety

These scripts:

* **Do NOT install any packages**
* **Do NOT modify system files**
* **Do NOT require root**
* Only print cosmetic output designed to *look* like real package installs

They’re safe for demos, stream overlays, aesthetic terminal loops, etc.

---

## 📂 File Structure (Recommended)

```
EndlessInstallers/
├── endlessFedora.sh
├── endlessKali.sh
├── endlessUbuntu.sh
└── README.md
```

---

### ☕ Support This Project

If **EndlessInstallers™** helps make you look busy or your terminal look cool, consider supporting continued development:

<p align="center">
  <a href="https://www.buymeacoffee.com/dfreshZ" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
</p>

---

<!-- 
    Fresh Forensics, LLC | Douglas Fresh Habian | 2025
    github.com/DouglasFreshHabian
    freshforensicsllc@tuta.com
-->
