#!/bin/bash
set -euo pipefail

echo "Checking Tailscale installation..."

# Tailscale is installed via Brewfile (cask). This script verifies it's present
# and reminds to authenticate if not already connected.
# Note: Tailscale should already be set up in Phase 2 (before chezmoi runs),
# but this serves as a safety net.

if [ -d "/Applications/Tailscale.app" ]; then
  echo "Tailscale app is installed."
else
  echo "WARNING: Tailscale not found. Install with: brew install --cask tailscale"
  exit 1
fi

# Check if tailscale CLI is available via the app
TAILSCALE_CLI="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
if [ -x "$TAILSCALE_CLI" ]; then
  STATUS=$("$TAILSCALE_CLI" status 2>&1 || true)
  if echo "$STATUS" | grep -q "Logged out"; then
    echo "WARNING: Tailscale is installed but not authenticated."
    echo "Run: tailscale up --ssh"
  else
    echo "Tailscale is connected."
  fi
fi

echo "Tailscale setup check complete."
