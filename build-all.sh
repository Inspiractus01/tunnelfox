#!/usr/bin/env bash
set -e

echo "🏗  Building TunnelFox for all platforms..."

# ensure output directory
mkdir -p builds

# macOS ARM (Apple Silicon)
echo "🍏 Building for macOS (arm64)..."
GOOS=darwin GOARCH=arm64 go build -o builds/tunnelfox-macos-arm64 ./cmd/tunnelfox

# Linux x86_64
echo "🐧 Building for Linux (amd64)..."
GOOS=linux GOARCH=amd64 go build -o builds/tunnelfox-linux-amd64 ./cmd/tunnelfox

# Linux ARM (Raspberry Pi)
echo "🍓 Building for Linux (arm64)..."
GOOS=linux GOARCH=arm64 go build -o builds/tunnelfox-linux-arm64 ./cmd/tunnelfox

echo "✅ All builds complete!"
echo
ls -lh builds/