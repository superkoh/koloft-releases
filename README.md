# Koloft — Releases

Public download mirror for **Koloft**, a macOS desktop app that runs and manages
**Claude Code** (the `claude` command-line tool): pick a workspace, start or resume its
Claude sessions, and get a Workbench panel (changed files, file browser, web pages, a
shell) beside each one. The source lives in a private repo; this repo only hosts the
macOS arm64 installer so anyone can download it.

Koloft was called **KCC** through v0.18, and this repo was `kcc-releases`; the old URLs
still redirect here, so older installs keep updating. Upgrading from a KCC build keeps
your settings, accounts and browser logins — the app carries them across on first launch,
and the installer removes the old `KCC.app`.

## Install (macOS, Apple Silicon)

```bash
curl -fsSL https://raw.githubusercontent.com/superkoh/koloft-releases/main/install.sh | bash
```

This fetches the latest `.dmg` and installs `Koloft.app` into `/Applications`. The build
is an **unsigned** personal build, but because `curl` never sets the macOS quarantine
flag, the app opens with a normal double-click — no Gatekeeper "damaged" prompt, no paid
Apple Developer ID.

Prefer the dmg by hand? Grab it from [Releases](../../releases), drag it to Applications,
then clear the quarantine flag once (a *browser* download sets it, and on macOS Sequoia the
old right-click → Open bypass is gone):

```bash
xattr -dr com.apple.quarantine /Applications/Koloft.app
```

## Updating

Re-run the **same** install command — it always grabs the latest release and replaces any
existing `/Applications/Koloft.app` in place, so there's no need to uninstall first:

```bash
curl -fsSL https://raw.githubusercontent.com/superkoh/koloft-releases/main/install.sh | bash
```

If Koloft is open while you update, quit it (Cmd-Q) and reopen to start the new version.
To check what you currently have installed:

```bash
defaults read /Applications/Koloft.app/Contents/Info.plist CFBundleShortVersionString
```

## Uninstall

```bash
rm -rf /Applications/Koloft.app
```
