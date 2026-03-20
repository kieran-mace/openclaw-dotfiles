#!/bin/bash
set -euo pipefail

echo "Configuring power management for headless server..."

# Prevent sleep entirely
sudo pmset -a sleep 0 disablesleep 1 hibernatemode 0

# Wake on network access (Tailscale / SSH)
sudo pmset -a womp 1

# Auto-restart after power failure
sudo pmset -a autorestart 1

# No display sleep (headless)
sudo pmset -a displaysleep 0

echo "Power management configured. Verify with: pmset -g"
