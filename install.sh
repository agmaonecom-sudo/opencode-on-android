#!/data/data/com.termux/files/usr/bin/bash
# install.sh — run once inside Termux.
set -euo pipefail

DISTRO=ubuntu
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

say() { printf '\n==> %s\n' "$*"; }
die() { printf '\nERROR: %s\n' "$*" >&2; exit 1; }

[ -n "${TERMUX_VERSION:-}" ] || die "Run this inside Termux (F-Droid build). https://f-droid.org/packages/com.termux/"
case "$(uname -m)" in aarch64 | arm64) ;; *) die "arm64 only (this device reports $(uname -m))." ;; esac

say "Termux packages"
pkg update -y
pkg install -y proot-distro

say "Installing Ubuntu (one time, downloads ~200 MB)"
# Fails harmlessly when it is already installed; the login check below decides.
proot-distro install "$DISTRO" || proot-distro login "$DISTRO" -- true ||
  die "Ubuntu could not be installed/started. Check your connection and run install.sh again."

say "Setting up Ubuntu (10-15 min the first time)"
proot-distro login --bind "$REPO_DIR" "$DISTRO" -- bash "$REPO_DIR/ubuntu-setup.sh"

printf '\nDone. Start it with:  bash %s/start.sh\n' "$REPO_DIR"
