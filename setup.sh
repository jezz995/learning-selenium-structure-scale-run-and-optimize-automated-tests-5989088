#!/bin/bash

set -e

echo "🧼 Cleaning up any previous Chrome installs..."
sudo rm -f /usr/bin/google-chrome || true
rm -rf ~/chrome138

echo "⬇️ Downloading Chrome for Testing (v138)..."
mkdir -p ~/chrome138 && cd ~/chrome138
wget https://storage.googleapis.com/chrome-for-testing-public/142.0.7444.175/linux64/chrome-linux64.zip
unzip chrome-linux64.zip

echo "🔗 Linking chrome binary to /usr/bin/google-chrome"
sudo ln -sf "$PWD/chrome-linux64/chrome" /usr/bin/google-chrome

echo "📦 Installing required libraries..."
sudo apt update
sudo apt install -y \
  libatk1.0-0t64 \
  libatk-bridge2.0-0t64 \
  libcups2t64 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libgbm1 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libgtk-3-0t64 \
  libdrm2 \
  libxss1 \
  libnss3 \
  libx11-xcb1 \
  libasound2t64

echo "✅ Chrome installed:"
google-chrome --version
