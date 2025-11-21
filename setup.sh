#!/usr/bin/env bash
set -euo pipefail

echo "🧼 Cleaning up any previous Chrome installs..."
sudo rm -f /usr/local/bin/google-chrome || true
rm -rf ~/chrome_for_testing

echo "⬇️ Downloading Chrome for Testing (linux64)..."
mkdir -p ~/chrome_for_testing
cd ~/chrome_for_testing

# Use explicit filename and check for required tools
sudo apt update -y
sudo apt install -y --no-install-recommends wget unzip ca-certificates

# Example: replace this URL if you want a different version or detect dynamically.
CHROME_URL="https://storage.googleapis.com/chrome-for-testing-public/142.0.7444.175/linux64/chrome-linux64.zip"
wget -q --show-progress -O chrome.zip "$CHROME_URL"

unzip -q chrome.zip -d chrome-extract

# Find the chrome binary in the extracted tree
FOUND_CHROME="$(find chrome-extract -type f -name 'chrome' | head -n1 || true)"
if [ -z "$FOUND_CHROME" ]; then
  echo "Error: extracted chrome binary not found"
  ls -R chrome-extract
  exit 1
fi

echo "🔗 Linking chrome binary to /usr/local/bin/google-chrome"
sudo ln -sf "$PWD/$FOUND_CHROME" /usr/local/bin/google-chrome
sudo chmod +x "/usr/local/bin/google-chrome"

echo "📦 Installing required libraries..."
# Install correct package names (no trailing 't64')
sudo apt update -y
sudo apt install -y --no-install-recommends \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libgbm1 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libgtk-3-0 \
  libdrm2 \
  libxss1 \
  libnss3 \
  libx11-xcb1 \
  libasound2

echo "✅ Chrome installed:"
google-chrome --version
