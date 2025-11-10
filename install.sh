#!/usr/bin/env bash
set -e

REPO_USER="inspiractus01"
REPO_NAME="tunnelfox"
INSTALL_DIR="/usr/local/bin"

# detect OS/arch
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# map to asset names from GitHub release
case "${OS}-${ARCH}" in
  linux-x86_64)
    ASSET="tunnelfox-linux-amd64"
    ;;
  linux-aarch64|linux-arm64)
    ASSET="tunnelfox-linux-arm64"
    ;;
  darwin-arm64)
    ASSET="tunnelfox-macos-arm64"
    ;;
  *)
    echo "unsupported OS/arch: ${OS} ${ARCH}"
    exit 1
    ;;
esac

echo "=== TunnelFox auto-installer ==="
echo "repo: ${REPO_USER}/${REPO_NAME}"
echo "asset: ${ASSET}"
echo

API_URL="https://api.github.com/repos/${REPO_USER}/${REPO_NAME}/releases/latest"

DOWNLOAD_URL=$(curl -s "${API_URL}" \
  | grep "browser_download_url" \
  | grep "${ASSET}" \
  | cut -d '"' -f 4 \
  | head -n 1)

if [ -z "${DOWNLOAD_URL}" ]; then
  echo "Could not find asset ${ASSET} in latest release."
  echo "Make sure it is uploaded to GitHub Releases."
  exit 1
fi

echo "[*] Downloading ${DOWNLOAD_URL}"
curl -L "${DOWNLOAD_URL}" -o tunnelfox
chmod +x tunnelfox

echo "[*] Installing to ${INSTALL_DIR}/tunnelfox ..."
sudo mv tunnelfox "${INSTALL_DIR}/tunnelfox"

echo "[OK] Installed."
tunnelfox version || true