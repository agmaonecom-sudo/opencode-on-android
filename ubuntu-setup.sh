#!/usr/bin/env bash
# ubuntu-setup.sh — runs inside Ubuntu via install.sh. Safe to re-run.
set -euo pipefail

say() { printf '\n==> %s\n' "$*"; }
export DEBIAN_FRONTEND=noninteractive

say "System packages"
apt-get update
apt-get install -y --no-install-recommends \
  ca-certificates curl xz-utils git build-essential python3

# OpenChamber needs Node >= 24.14. The tarball is glibc arm64, same as this Ubuntu.
NODE_MAJOR=24
if ! command -v node >/dev/null 2>&1 ||
  [ "$(node -p 'process.versions.node.split(".")[0]' 2>/dev/null || echo 0)" -lt "$NODE_MAJOR" ]; then
  say "Node.js $NODE_MAJOR"
  base="https://nodejs.org/dist/latest-v${NODE_MAJOR}.x"
  sums="$(curl -fsSL "$base/SHASUMS256.txt")"
  file="$(printf '%s\n' "$sums" | awk '/linux-arm64\.tar\.xz$/{print $2; exit}')"
  [ -n "$file" ] || { echo "ERROR: could not resolve the Node.js tarball" >&2; exit 1; }
  tmp="$(mktemp -d)"
  curl -fsSL "$base/$file" -o "$tmp/node.tar.xz"
  (cd "$tmp" && printf '%s\n' "$sums" | grep " $file\$" | sha256sum -c -)
  tar -xJf "$tmp/node.tar.xz" -C /usr/local --strip-components=1
  rm -rf "$tmp"
fi
node -v

say "OpenCode"
npm install -g @opencode/cli@latest --no-audit --no-fund

say "OpenChamber"
npm install -g @openchamber/web@latest --no-audit --no-fund

mkdir -p "$HOME/projects"

say "Versions"
opencode --version
openchamber --version
printf '\nProject folder: %s/projects\n' "$HOME"
