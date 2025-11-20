
#!/usr/bin/env bash
# AndroidBoost Lite v1.0
# Basic UI + battery optimization (no bloatware manager)

VERSION="1.0"

banner() {
  clear
  echo "==============================="
  echo "    ANDROIDBOOST LITE v$VERSION"
  echo "   Basic Optimization Toolkit"
  echo "==============================="
  echo
}

pause() {
  echo
  read -p "Press Enter to continue..." _
}

apply_ui_tweaks() {
  echo "Applying UI / animation tweaks..."
  if command -v settings >/dev/null 2>&1; then
    settings put global window_animation_scale 0.5
    settings put global transition_animation_scale 0.5
    settings put global animator_duration_scale 0.5
    settings put global wifi_scan_always_enabled 0
    echo " - Animations set to 0.5 (faster UI)"
    echo " - Wi-Fi scan always-on disabled (battery help)"
  else
    echo "settings command not available, cannot apply tweaks."
  fi
}

apply_gaming_mode() {
  echo "Enabling Gaming Mode..."
  if command -v settings >/dev/null 2>&1; then
    settings put global window_animation_scale 0
    settings put global transition_animation_scale 0
    settings put global animator_duration_scale 0
    echo " - Animations disabled (snappier UI)"
  else
    echo "settings command not available, cannot apply tweaks."
  fi
}

reset_tweaks() {
  echo "Resetting animation scales to default (1.0)..."
  if command -v settings >/dev/null 2>&1; then
    settings put global window_animation_scale 1
    settings put global transition_animation_scale 1
    settings put global animator_duration_scale 1
    echo " - Animations reset to 1.0"
  else
    echo "settings command not available, cannot reset."
  fi
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
}

menu() {
  while true; do
    banner
    echo " 1) Apply battery + performance tweaks"
    echo " 2) Enable Gaming Mode"
    echo " 3) Reset animation tweaks"
    echo " 4) Show status"
    echo " 0) Exit"
    echo
    read -p "Select an option: " choice
    echo
    case "$choice" in
      1) apply_ui_tweaks; pause ;;
      2) apply_gaming_mode; pause ;;
      3) reset_tweaks; pause ;;
      4) show_status; pause ;;
      0) echo "Bye."; exit 0 ;;
      *) echo "Invalid choice."; pause ;;
    esac
  done
}

banner
menu
