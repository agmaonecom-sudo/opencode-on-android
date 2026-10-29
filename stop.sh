#!/data/data/com.termux/files/usr/bin/bash
# stop.sh — stops a server left running after start.sh was killed.
set -euo pipefail

proot-distro login ubuntu -- bash -lc 'openchamber stop' || true
termux-wake-unlock 2>/dev/null || true
printf 'OpenChamber stopped.\n'
