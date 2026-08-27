#!/usr/bin/env bash

set -euo pipefail

CAM_NAME="HD Pro Webcam C920"
WB_TEMP="${1:-5000}"

DEV=$(v4l2-ctl --list-devices 2>/dev/null \
  | awk -v name="$CAM_NAME" '
        $0 ~ name {found=1; next}
        found && /^\t\/dev\/video/ {print $1; exit}
    ')

if [[ -z "${DEV:-}" ]]; then
  echo "Erro: '$CAM_NAME' not found." >&2
  exit 1
fi

echo "Fixing $DEV (temp=${WB_TEMP}K)"
v4l2-ctl -d "$DEV" --set-ctrl=white_balance_automatic=0
v4l2-ctl -d "$DEV" --set-ctrl=white_balance_temperature="$WB_TEMP"
v4l2-ctl -d "$DEV" --get-ctrl=white_balance_automatic,white_balance_temperature
