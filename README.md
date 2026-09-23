<p align="center">
  <img src="assets/icon.png" width="128" alt="Koloft icon">
</p>

# Koloft — Releases

Installers for **Koloft**, a macOS desktop app that runs and manages **Claude Code**
(the `claude` command-line tool). The source code is at
[superkoh/koloft](https://github.com/superkoh/koloft); this repo only holds the macOS
arm64 installer, so the release list stays nothing but downloads.

What Koloft does:

- Pick a **workspace** (a folder). Koloft lists every Claude session that folder already
  has, straight from Claude's own storage, and lets you start new ones or resume old ones.
- Each session gets a **Workbench** panel beside it: the files Claude changed, a file
  browser and editor, a real in-app browser the agent can drive, and a shell.
- Each workspace gets a plain-text **note**.
- **Multi-account balancing**: register several Claude accounts and every launch starts
  on the least-loaded one.
- A built-in **statusline** (model, cost, context, git branch), OS **notifications** when
  a session needs you, and an in-app **updater**.

## Install (macOS, Apple Silicon)

```bash
curl -fsSL https://raw.githubusercontent.com/superkoh/koloft-releases/main/install.sh | bash
```

This fetches the latest `.dmg` and installs `Koloft.app` into `/Applications`. The build
is **unsigned**, but because `curl` never sets the macOS quarantine flag, the app opens
with a normal double-click — no Gatekeeper "damaged" prompt.

Prefer the dmg by hand? Grab it from [Releases](../../releases), drag it to Applications,
then clear the quarantine flag once (a *browser* download sets it, and on macOS Sequoia the
old right-click → Open bypass is gone):

```bash
xattr -dr com.apple.quarantine /Applications/Koloft.app
```

## Updating

Koloft updates itself: **Koloft ▸ Check for Updates…** in the menu bar downloads the
latest release, shows what changed, and swaps the app in place.

The install command works too — it always grabs the latest release and replaces any
existing `/Applications/Koloft.app`, so there's no need to uninstall first.

If Koloft is open while you update by command, quit it (Cmd-Q) and reopen to start the new
version. To check what you currently have installed:

```bash
defaults read /Applications/Koloft.app/Contents/Info.plist CFBundleShortVersionString
```

## Uninstall

```bash
rm -rf /Applications/Koloft.app
```

## Bugs and ideas

Open an issue on the source repo: [superkoh/koloft/issues](https://github.com/superkoh/koloft/issues).

## Licence

Koloft is free software under the GNU General Public License v3.0 or later. The source
for every installer here is the tag of the same name in
[superkoh/koloft](https://github.com/superkoh/koloft/tags).
