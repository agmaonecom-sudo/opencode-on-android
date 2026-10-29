#!/data/data/com.termux/files/usr/bin/bash
# start.sh — starts OpenChamber inside Ubuntu and opens the browser.
#   bash start.sh            localhost only
#   START_LAN=1 bash start.sh   reachable from your PC on the same Wi-Fi
#   PORT=40254 bash start.sh    different port
set -euo pipefail

DISTRO=ubuntu
PORT="${PORT:-40253}"
CONF_DIR="$HOME/.config/opencode-android"
PW_FILE="$CONF_DIR/ui-password"

proot-distro login "$DISTRO" -- true >/dev/null 2>&1 ||
  { echo "Ubuntu is not installed yet. Run: bash install.sh" >&2; exit 1; }

mkdir -p "$CONF_DIR"
chmod 700 "$CONF_DIR"
if [ -s "$PW_FILE" ]; then
  PW="$(cat "$PW_FILE")"
else
  PW="$(tr -dc 'A-Za-z0-9_-' </dev/urandom | head -c 32)"
  printf '%s' "$PW" >"$PW_FILE"
  chmod 600 "$PW_FILE"
fi

HOST=127.0.0.1
if [ "${START_LAN:-0}" = "1" ]; then HOST=0.0.0.0; fi

termux-wake-lock 2>/dev/null || true
trap 'termux-wake-unlock 2>/dev/null || true' EXIT

(
  sleep 5
  command -v termux-open-url >/dev/null 2>&1 && termux-open-url "http://127.0.0.1:$PORT"
) >/dev/null 2>&1 &

printf '\nOpenChamber: http://127.0.0.1:%s\nPassword:     %s\nSaved in:     %s\n\nKeep this session open. Ctrl+C stops the server.\n\n' \
  "$PORT" "$PW" "$PW_FILE"

proot-distro login "$DISTRO" -- env OPENCHAMBER_UI_PASSWORD="$PW" \
  bash -lc "exec openchamber serve --host '$HOST' --port '$PORT' --foreground"
