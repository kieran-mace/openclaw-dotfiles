#!/bin/bash
set -euo pipefail

# Install Homebrew if not already present
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew is on PATH for subsequent scripts
eval "$(/opt/homebrew/bin/brew shellenv)"
