#!/usr/bin/env bash
# One-line installer for KCC (macOS arm64, unsigned personal build):
#
#   curl -fsSL https://raw.githubusercontent.com/superkoh/kcc-releases/main/install.sh | bash
#
# Why this exists: KCC's .dmg is unsigned and un-notarized, so a *browser*
# download gets the com.apple.quarantine attribute and Gatekeeper refuses to
# launch it ("damaged" / "unidentified developer"). Files fetched with curl
# carry no quarantine — so downloading the dmg here and copying the app out
# yields an /Applications/KCC.app that opens with a normal double-click, with
# no paid Apple Developer ID and no Gatekeeper prompt.
set -euo pipefail

# Binaries live in a PUBLIC releases repo so anonymous downloaders aren't
# blocked by the private source repo's 404. Source stays in superkoh/kcc.
REPO="superkoh/kcc-releases"
APP="/Applications/KCC.app"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "KCC is macOS-only." >&2; exit 1
fi
if [ "$(uname -m)" != "arm64" ]; then
  echo "KCC ships arm64-only; this Mac reports $(uname -m)." >&2; exit 1
fi

echo "Finding the latest KCC release…"
DMG_URL=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
  | grep -o 'https://[^"]*-arm64\.dmg' | head -1) || true
if [ -z "${DMG_URL:-}" ]; then
  echo "Could not find an arm64 .dmg in the latest release of $REPO." >&2; exit 1
fi

TMP="$(mktemp -d)"
MNT="$(mktemp -d)"
cleanup() { hdiutil detach "$MNT" -quiet 2>/dev/null || true; rm -rf "$TMP" "$MNT"; }
trap cleanup EXIT

echo "Downloading ${DMG_URL##*/}…"
curl -fL --progress-bar -o "$TMP/KCC.dmg" "$DMG_URL"

echo "Mounting…"
hdiutil attach "$TMP/KCC.dmg" -nobrowse -quiet -mountpoint "$MNT"

# /Applications is group-writable by admins; fall back to sudo only if not.
SUDO=""; [ -w /Applications ] || SUDO="sudo"
echo "Installing to $APP…"
$SUDO rm -rf "$APP"
$SUDO cp -R "$MNT/KCC.app" "$APP"
# Belt and suspenders: nothing above applies quarantine, but if an earlier
# browser download left the flag on a previous copy, clear it too.
$SUDO xattr -dr com.apple.quarantine "$APP" 2>/dev/null || true

if pgrep -x KCC >/dev/null 2>&1; then
  echo "✓ Installed. KCC is still running the previous version —"
  echo "  quit it (Cmd-Q) and reopen to use this one."
else
  echo "✓ Installed. Launch from /Applications, or run: open -a KCC"
fi
