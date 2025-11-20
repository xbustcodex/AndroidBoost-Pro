#!/usr/bin/env bash
# AndroidBoost Pro v1.0
# Simple Android optimization toolkit for Termux (root recommended)

VERSION="1.0"
LOG_DIR="$HOME/.androidboost_pro"
LOG_FILE="$LOG_DIR/abp_$(date +%Y%m%d_%H%M%S).log"
DISABLED_LIST="$LOG_DIR/disabled_packages.txt"

mkdir -p "$LOG_DIR"

banner() {
  clear
  echo "========================================="
  echo "        ANDROIDBOOST PRO v$VERSION       "
  echo "      Android Optimization Toolkit       "
  echo "========================================="
  echo
}

log() {
  echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG_FILE"
}

check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "[!] Root not detected (uid != 0)."
    echo "    Some features need root (pm, settings, cmd)."
    echo "    If your device is rooted, run: su"
    echo "    then run this script again."
    echo
    read -p "Continue in limited mode anyway? [y/N]: " ans
    case "$ans" in
      y|Y) return 0 ;;
      *) exit 1 ;;
    esac
  else
    log "Running with root privileges."
  fi
}

pause() {
  echo
  read -p "Press Enter to continue..." _
}

# -------- SAFE BLOATWARE LIST (3rd-party only, no core system) --------
SAFE_BLOAT_PACKAGES=(
  "com.facebook.katana"
  "com.facebook.system"
  "com.facebook.appmanager"
  "com.facebook.services"
  "com.netflix.mediaclient"
  "com.netflix.partner.activation"
  "com.microsoft.skydrive"
  "com.microsoft.office.word"
  "com.microsoft.office.excel"
  "com.microsoft.office.powerpoint"
  "com.microsoft.office.outlook"
  "com.booking"
  "com.tripadvisor.tripadvisor"
  "com.linkedin.android"
  "com.skype.raider"
  "com.udemy.android"
  "com.huawei.appmarket"
  "com.oppo.market"
  "com.sec.android.app.sbrowser"        # Samsung Internet (optional)
  "com.samsung.android.game.gamehome"   # Samsung Game Launcher
)

find_installed_bloat() {
  local found=()
  for pkg in "${SAFE_BLOAT_PACKAGES[@]}"; do
    if pm list packages | grep -q "$pkg"; then
      found+=("$pkg")
    fi
  done

  if [ "${#found[@]}" -eq 0 ]; then
    echo "No known 3rd-party bloatware packages from the list are installed."
    return 1
  fi

  echo "Found possible bloatware packages on this device:"
  echo "------------------------------------------------"
  for p in "${found[@]}"; do
    echo " - $p"
  done
  echo "------------------------------------------------"
  echo
  read -p "Disable ALL of these (pm disable-user --user 0)? [y/N]: " ans
  case "$ans" in
    y|Y)
      for p in "${found[@]}"; do
        if pm disable-user --user 0 "$p" >/dev/null 2>&1; then
          log "Disabled: $p"
          echo "$p" >> "$DISABLED_LIST"
        else
          log "FAILED to disable: $p"
        fi
      done
      echo
      echo "Done. Disabled packages logged in:"
      echo "  $DISABLED_LIST"
      ;;
    *)
      echo "Skipped disabling packages."
      ;;
  esac
}

re_enable_packages() {
  if [ ! -f "$DISABLED_LIST" ]; then
    echo "No disabled package list found at:"
    echo "  $DISABLED_LIST"
    echo "Nothing to re-enable."
    return
  fi

  echo "This will re-enable ALL packages listed in:"
  echo "  $DISABLED_LIST"
  read -p "Continue? [y/N]: " ans
  case "$ans" in
    y|Y)
      while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        if pm enable "$pkg" >/dev/null 2>&1; then
          log "Re-enabled: $pkg"
        else
          log "FAILED to re-enable: $pkg"
        fi
      done < "$DISABLED_LIST"
      echo
      echo "Done re-enabling. You may reboot to fully apply changes."
      ;;
    *)
      echo "Re-enable cancelled."
      ;;
  esac
}

apply_ui_tweaks() {
  echo "Applying UI / animation tweaks..."
  if command -v settings >/dev/null 2>&1; then
    # Faster animations
    settings put global window_animation_scale 0.5
    settings put global transition_animation_scale 0.5
    settings put global animator_duration_scale 0.5

    # Optional: reduce Wi-Fi scan always-on for battery
    settings put global wifi_scan_always_enabled 0

    log "Set animation scales to 0.5 and wifi_scan_always_enabled=0"
    echo " - Animations set to 0.5 (faster UI)"
    echo " - Wi-Fi scan always-on disabled (battery help)"
  else
    echo "Command 'settings' not available. Skipping UI tweaks."
    log "'settings' command missing - UI tweaks skipped."
  fi

  echo
  echo "UI tweaks applied. You may need to lock/unlock screen to feel changes."
}

apply_gaming_mode() {
  echo "Enabling 'Gaming Mode' tweaks..."
  if command -v settings >/dev/null 2>&1; then
    settings put global window_animation_scale 0
    settings put global transition_animation_scale 0
    settings put global animator_duration_scale 0

    log "Set animation scales to 0 for gaming mode."
    echo " - Animations disabled (snappier feel)"
  else
    echo "Command 'settings' not available. Skipping animation tweaks."
    log "'settings' cmd missing - gaming anim tweaks skipped."
  fi

  if command -v cmd >/dev/null 2>&1; then
    cmd power set-fixed-performance-mode-enabled true 2>/dev/null \
      && log "Enabled fixed performance mode (if supported)" \
      && echo " - Requested performance mode (if supported)"
  fi

  echo
  echo "Gaming mode tweaks applied. For best effect, close background apps too."
}

reset_tweaks() {
  echo "This will reset animation scales back to 1.0 (Android default)."
  read -p "Continue? [y/N]: " ans
  case "$ans" in
    y|Y)
      if command -v settings >/dev/null 2>&1; then
        settings put global window_animation_scale 1
        settings put global transition_animation_scale 1
        settings put global animator_duration_scale 1
        log "Reset animation scales to 1.0"
        echo " - Animations reset to default (1.0)"
      else
        echo "Command 'settings' not available. Skipping."
        log "'settings' cmd missing - cannot reset anim."
      fi

      if command -v cmd >/dev/null 2>&1; then
        cmd power set-fixed-performance-mode-enabled false 2>/dev/null \
          && log "Disabled fixed performance mode (if supported)"
      fi

      ;;
    *)
      echo "Reset cancelled."
      ;;
  esac
}

show_status() {
  echo "Current key settings:"
  echo "------------------------------"
  if command -v settings >/dev/null 2>&1; then
    echo -n "window_animation_scale: "
    settings get global window_animation_scale 2>/dev/null
    echo -n "transition_animation_scale: "
    settings get global transition_animation_scale 2>/dev/null
    echo -n "animator_duration_scale: "
    settings get global animator_duration_scale 2>/dev/null
    echo -n "wifi_scan_always_enabled: "
    settings get global wifi_scan_always_enabled 2>/dev/null
  else
    echo "settings command not available."
  fi
  echo "------------------------------"
  echo "Log file for this session:"
  echo "  $LOG_FILE"
  echo "Disabled packages list:"
  echo "  $DISABLED_LIST (if any)"
}

menu() {
  while true; do
    banner
    echo "Device optimization menu:"
    echo
    echo "  1) Detect & disable common bloatware"
    echo "  2) Apply battery + performance tweaks"
    echo "  3) Enable Gaming Mode (snappier UI)"
    echo "  4) Re-enable previously disabled packages"
    echo "  5) Reset animation / performance tweaks"
    echo "  6) Show current status"
    echo "  0) Exit"
    echo
    read -p "Select an option: " choice
    echo

    case "$choice" in
      1) find_installed_bloat; pause ;;
      2) apply_ui_tweaks; pause ;;
      3) apply_gaming_mode; pause ;;
      4) re_enable_packages; pause ;;
      5) reset_tweaks; pause ;;
      6) show_status; pause ;;
      0) echo "Bye."; exit 0 ;;
      *) echo "Invalid choice."; pause ;;
    esac
  done
}

# -------- MAIN --------
banner
check_root
menu
