#!/bin/bash
set -euo pipefail

echo "Setting up Ollama LaunchDaemon..."

PLIST_PATH="/Library/LaunchDaemons/com.ollama.serve.plist"

sudo tee "$PLIST_PATH" > /dev/null << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.ollama.serve</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/ollama</string>
        <string>serve</string>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
        <key>OLLAMA_HOST</key>
        <string>127.0.0.1:11434</string>
        <key>OLLAMA_FLASH_ATTENTION</key>
        <string>1</string>
        <key>OLLAMA_KV_CACHE_TYPE</key>
        <string>q8_0</string>
    </dict>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/var/log/ollama.log</string>
    <key>StandardErrorPath</key>
    <string>/var/log/ollama.log</string>
</dict>
</plist>
PLIST

sudo chmod 644 "$PLIST_PATH"
sudo chown root:wheel "$PLIST_PATH"

# Set up log rotation
sudo tee /etc/newsyslog.d/ollama.conf > /dev/null << 'LOGROTATE'
/var/log/ollama.log  644  5  10240  *  J
LOGROTATE

# Load the daemon
sudo launchctl bootout system/com.ollama.serve 2>/dev/null || true
sudo launchctl bootstrap system "$PLIST_PATH"

echo "Ollama LaunchDaemon installed and started."
