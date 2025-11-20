<p align="center">
  <img src="https://raw.githubusercontent.com/xbustcodex/AndroidBoost-Pro/main/androidboost_banner.png" width="90%" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Version-v1.0-brightgreen?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Platform-Android-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Works%20In-Termux-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Root-Optional-yellow?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-Custom-lightgrey?style=for-the-badge" />
</p>
# AndroidBoost-Pro
AndroidBoost Pro v1.0  ⚡ All-in-One Android Speed, Battery &amp; Gaming Optimizer  AndroidBoost Pro is a lightweight Android optimization toolkit designed for Termux (root recommended). It safely debloats your phone, increases UI speed, boosts battery life, and includes a Gaming Mode for maximum performance.

➡️ **Pro version** (safe bloatware removal, logs, restore system, deep tweaks)  
is available via DM or purchase link.

---

- Detect & disable safe 3rd-party bloatware
- Apply battery & performance tweaks
- Enable ultra-snappy Gaming Mode
- Fully revert changes if needed
. 
## ✨ Features

### ✅ Core Features
- Safe bloatware detection from a curated list (Facebook, Netflix, OEM stores, etc.)
- Disable packages via `pm disable-user --user 0`
- Log every action to a timestamped log file
- Keep a list of disabled packages for easy restore

### 🚀 Performance & Battery
- Lower animation scales for a snappier UI
- Optionally disable Wi-Fi scan-always for better standby
- Toggle "fixed performance mode" (if your device supports `cmd power set-fixed-performance-mode-enabled`)

### 🎮 Gaming Mode
- Completely disable animations
- Request max performance mode (where supported)
- Combine with manual background-app closing for best results

### ⏪ Revert & Status
- Re-enable all previously disabled apps from a log file
- Reset animation scales to Android defaults (1.0)
- Show current settings and what was changed

---

## 🧪 Lite vs Pro

| Feature | Lite (Free) | **Pro (Paid)** |
|--------|-------------|----------------|
| Apply UI + battery tweaks | ✔ | ✔ |
| Basic Gaming Mode | ✔ | ✔ (enhanced) |
| Show status | ✔ | ✔ |
| Safe bloatware detection | ❌ | **✔** |
| Disable bloatware | ❌ | **✔** |
| Re-enable disabled apps | ❌ | **✔** |
| Detailed logging | ❌ | **✔** |
| Curated OEM lists (Samsung/Oppo/Xiaomi) | ❌ | **Planned** |

The repository includes :
- `androidboost_lite.sh`
  
---

## 📦 Installation

### Requirements
- Android device
- Termux installed
- Root (Magisk, etc.) for full functionality

## 📥 Install Termux (Required)

Download Termux from the official source (F-Droid):

👉 **https://f-droid.org/en/packages/com.termux/**

⚠️ *Do NOT install Termux from the Play Store — it is outdated and broken.*

---

### 1. Install Termux dependencies

```bash
pkg update && pkg upgrade -y
pkg install -y bash
```

### 2. Download the script(s)

```bash
cd ~
curl -O https://raw.githubusercontent.com/xbustcodex/AndroidBoost-Pro/main/androidBoost-lite.sh
chmod +x androidBoost-lite.sh
bash androidBoost-lite.sh
```

### 3. Run (Lite, no root required for some tweaks)

```bash
bash androidboost_lite.sh
 or ./androidboost_lite.sh
```

If you see a "root not detected" warning, either:
- Run `su` first in Termux, or
- Accept limited mode (only some tweaks will work)

---
---

🛡 Safety Notes

AndroidBoost Pro is designed to be **conservative**:

- It only targets a known list of 3rd-party packages
- It logs every package it disables
- It offers a one-shot restore to re-enable everything
- It does **not**:
  - Flash anything
  - Touch system partitions directly
  - Edit boot images or kernels

Still, use common sense and always test on your own device(s) before using on client phones.

---

💰 Get AndroidBoost Pro+ (Paid Version)

Upgrade to the paid “Pro+ Edition” to unlock:

Deep Debloat Mode (Samsung/Pixel/Oppo/Xiaomi)

Auto-Gaming Mode

Kernel Tweaks (if rooted)

Auto Battery Calibration

App Freeze Mode (instead of disable)

ADB PC version (No root required)

Scheduled Optimization (daily/weekly)


Price: $15 one-time
Message me to buy your copy.

---

⭐ Support the Project

If you like this tool:

Star ⭐ the repo

Share it

DM for the Pro version

---

AndroidBoost Pro v1.0 - License
--------------------------------

You are allowed to:
- Use this software for personal or commercial purposes.
- Modify it for your own use or for services you sell.
- Bundle it as part of a paid service (e.g., phone optimization).

You are NOT allowed to:
- Publicly re-upload the full Pro script in a free/open repository.
- Resell this script verbatim without adding any value (support, customization, etc.).

There is no warranty. Use at your own risk. You are responsible for any changes made on devices using this script.

