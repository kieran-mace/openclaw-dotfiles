#!/bin/bash
set -euo pipefail

eval "$(/opt/homebrew/bin/brew shellenv)"

# Install all packages from Brewfile
# chezmoi hash: {{ include "Brewfile" | sha256sum }}
echo "Installing Brewfile packages..."
brew bundle --file="{{ .chezmoi.sourceDir }}/Brewfile" --no-lock
