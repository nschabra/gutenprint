#!/usr/bin/env bash
# ==============================================================================
# build-release-pkg.sh — Builds standalone macOS .pkg installer
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

VERSION="5.3.5"
PKG_ID="org.gutenprint.canon-g1010"
OUTPUT_DIR="$REPO_ROOT/releases"
OUTPUT_PKG="$OUTPUT_DIR/Canon-PIXMA-G1010-v${VERSION}.pkg"

echo "=== Building Canon PIXMA G1010 macOS Release Package (v${VERSION}) ==="

mkdir -p "$OUTPUT_DIR"

# Temporary directories
TMP_ROOT="$(mktemp -d /tmp/g1010-pkg-root.XXXXXX)"
TMP_SCRIPTS="$(mktemp -d /tmp/g1010-pkg-scripts.XXXXXX)"

cleanup() {
    rm -rf "$TMP_ROOT" "$TMP_SCRIPTS"
}
trap cleanup EXIT

echo "1. Staging payload..."

# A. Calibrated PPD
mkdir -p "$TMP_ROOT/Library/Printers/PPDs/Contents/Resources"
cp "$REPO_ROOT/src/cups/Canon_PIXMA_G1010.ppd" \
   "$TMP_ROOT/Library/Printers/PPDs/Contents/Resources/Canon_PIXMA_G1010.ppd"

# B. CLI Companion
mkdir -p "$TMP_ROOT/usr/local/bin"
cp "$REPO_ROOT/bin/canon-g1010" \
   "$TMP_ROOT/usr/local/bin/canon-g1010"
chmod 755 "$TMP_ROOT/usr/local/bin/canon-g1010"

# C. LaunchAgent Plist
mkdir -p "$TMP_ROOT/Library/LaunchAgents"
cp "$REPO_ROOT/packaging/macos/com.local.ippeveprinter.plist" \
   "$TMP_ROOT/Library/LaunchAgents/com.local.ippeveprinter.plist"

echo "2. Staging installer scripts..."
cp "$REPO_ROOT/packaging/macos/scripts/postinstall" "$TMP_SCRIPTS/postinstall"
chmod 755 "$TMP_SCRIPTS/postinstall"

echo "3. Compiling .pkg with pkgbuild..."
pkgbuild \
    --root "$TMP_ROOT" \
    --scripts "$TMP_SCRIPTS" \
    --identifier "$PKG_ID" \
    --version "$VERSION" \
    --install-location "/" \
    "$OUTPUT_PKG"

echo ""
echo "=== Package Built Successfully! ==="
ls -lh "$OUTPUT_PKG"
echo "Location: $OUTPUT_PKG"
