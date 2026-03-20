#!/bin/bash
set -euo pipefail

# Install OpenClaw globally
if command -v openclaw &>/dev/null; then
  echo "OpenClaw already installed: $(openclaw --version)"
else
  echo "Installing OpenClaw..."
  curl -fsSL https://openclaw.ai/install.sh | bash
fi
