#!/bin/bash
set -euo pipefail

echo "Configuring macOS for headless server use..."

# Disable Spotlight indexing
sudo mdutil -a -i off

# Disable Siri
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.Siri UserHasDeclinedEnable -bool true

# Disable AirDrop
defaults write com.apple.NetworkBrowser DisableAirDrop -bool true

# Don't save new documents to iCloud by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Enable macOS Application Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp on

echo "macOS server configuration complete."
