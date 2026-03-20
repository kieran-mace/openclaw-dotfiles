#!/bin/bash
set -euo pipefail

echo "Configuring SSH hardening..."

SSHD_CONFIG="/etc/ssh/sshd_config"

# Enable Remote Login (macOS-specific)
sudo systemsetup -setremotelogin on 2>/dev/null || true

# Back up original config
if [ ! -f "${SSHD_CONFIG}.bak" ]; then
  sudo cp "$SSHD_CONFIG" "${SSHD_CONFIG}.bak"
fi

# Write hardened sshd_config
sudo tee "$SSHD_CONFIG" > /dev/null << 'SSHD'
# OpenClaw Mac mini — hardened SSH config

# Only allow specific users
AllowUsers openclaw kieran

# Disable root login
PermitRootLogin no

# Public key auth only
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no

# Limit auth attempts
MaxAuthTries 3

# Disable unused auth methods
UsePAM no
ChallengeResponseAuthentication no

# Logging
SyslogFacility AUTH
LogLevel INFO
SSHD

echo "SSH hardened. Restart sshd or reboot to apply."
