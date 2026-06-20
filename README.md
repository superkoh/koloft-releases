# KCC — Releases

Public download mirror for **KCC** (K Claude Code), a multi-tab terminal IDE with a
Claude Code session sidebar and in-app document preview. The source lives in a private
repo; this repo only hosts the macOS arm64 installer so anyone can download it.

## Install (macOS, Apple Silicon)

```bash
curl -fsSL https://raw.githubusercontent.com/superkoh/kcc-releases/main/install.sh | bash
```

This fetches the latest `.dmg` and installs `KCC.app` into `/Applications`. The build is
an **unsigned** personal build, but because `curl` never sets the macOS quarantine flag,
the app opens with a normal double-click — no Gatekeeper "damaged" prompt, no paid Apple
Developer ID.

Prefer the dmg by hand? Grab it from [Releases](../../releases), drag it to Applications,
then clear the quarantine flag once (a *browser* download sets it, and on macOS Sequoia the
old right-click → Open bypass is gone):

```bash
xattr -dr com.apple.quarantine /Applications/KCC.app
```

## Updating

Re-run the **same** install command — it always grabs the latest release and replaces any
existing `/Applications/KCC.app` in place, so there's no need to uninstall first:

```bash
curl -fsSL https://raw.githubusercontent.com/superkoh/kcc-releases/main/install.sh | bash
```

If KCC is open while you update, quit it (Cmd-Q) and reopen to start the new version. To
check what you currently have installed:

```bash
defaults read /Applications/KCC.app/Contents/Info.plist CFBundleShortVersionString
```

## Uninstall

```bash
rm -rf /Applications/KCC.app
```
