#!/usr/bin/env bash
# Configura white balance fixo na Logitech C920
set -euo pipefail

CAM_NAME="HD Pro Webcam C920"
WB_TEMP="${1:-5000}" # passa um valor como argumento ou usa 5000

# Encontra o /dev/videoN da C920 (pega o primeiro device, que é o de captura)
DEV=$(v4l2-ctl --list-devices 2>/dev/null \
  | awk -v name="$CAM_NAME" '
        $0 ~ name {found=1; next}
        found && /^\t\/dev\/video/ {print $1; exit}
    ')

if [[ -z "${DEV:-}" ]]; then
  echo "Erro: '$CAM_NAME' não encontrada." >&2
  exit 1
fi

echo "Configurando $DEV (temp=${WB_TEMP}K)"
v4l2-ctl -d "$DEV" --set-ctrl=white_balance_automatic=0
v4l2-ctl -d "$DEV" --set-ctrl=white_balance_temperature="$WB_TEMP"

# Mostra o estado final para confirmação
v4l2-ctl -d "$DEV" --get-ctrl=white_balance_automatic,white_balance_temperature
