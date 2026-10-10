#!/bin/bash
# Claude Code statusline: caveman + model + effort + context + rate limits + cost + session time
#
# Component env vars (set to 0 to hide):
#   SL_CAVEMAN=0   SL_EFFORT=0   SL_5H=0   SL_7D=0

# ── palette ───────────────────────────────────────────────────────────────────

CYAN='\033[36m'
YELLOW='\033[33m'
GREEN='\033[32m'
RED='\033[31m'
RESET='\033[0m'
BRIGHT_RED='\033[38;5;196m'
BRIGHT_YELLOW='\033[38;5;220m'
SOFT_GREEN='\033[38;5;114m'
ORANGE='\033[38;5;208m'
SKY_BLUE='\033[38;5;75m'
GRAY='\033[38;5;244m'
DARK_GRAY='\033[38;5;240m'
AMBER='\033[38;5;172m'

# ── helpers ───────────────────────────────────────────────────────────────────

fill_bar() {
  local pct="${1:-0}" width="${2:-10}"
  local filled=$((pct * width / 100))
  [ $filled -gt $width ] && filled=$width
  local bar="" i=0
  while [ $i -lt $filled ]; do
    bar="${bar}█"
    i=$((i + 1))
  done
  while [ $i -lt $width ]; do
    bar="${bar}░"
    i=$((i + 1))
  done
  printf '%s' "$bar"
}

fmt_seconds() {
  local secs="${1:-0}"
  local now remaining
  now=$(date +%s)
  remaining=$((secs - now))
  [ $remaining -lt 0 ] && remaining=0
  local days=$((remaining / 86400))
  local hrs=$(((remaining % 86400) / 3600))
  local mins=$(((remaining % 3600) / 60))
  if [ $days -gt 0 ]; then
    printf '%dd %dh' "$days" "$hrs"
  elif [ $hrs -gt 0 ]; then
    printf '%dh %dm' "$hrs" "$mins"
  else
    printf '%dm' "$mins"
  fi
}

# Return ANSI color for a "used" percentage (green→yellow→red as usage rises)
used_color() {
  local pct="${1:-0}"
  if [ "$pct" -ge 80 ]; then
    printf '%b' "$BRIGHT_RED"
  elif [ "$pct" -ge 50 ]; then
    printf '%b' "$BRIGHT_YELLOW"
  else
    printf '%b' "$SOFT_GREEN"
  fi
}

# Return ANSI color for a "remaining" percentage (red→yellow→green as remainder rises)
rem_color() {
  local pct="${1:-0}"
  if [ "$pct" -le 20 ]; then
    printf '%b' "$BRIGHT_RED" # almost none left
  elif [ "$pct" -le 50 ]; then
    printf '%b' "$BRIGHT_YELLOW"
  else
    printf '%b' "$SOFT_GREEN" # plenty left
  fi
}

# ── read stdin JSON ───────────────────────────────────────────────────────────

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct_raw=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
used_pct=$(printf '%.0f' "$used_pct_raw" 2>/dev/null || echo 0)
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

if [ "$used_pct" -ge 90 ]; then
  BAR_COLOR="$RED"
elif [ "$used_pct" -ge 70 ]; then
  BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

filled=$((used_pct / 10))
empty=$((10 - filled))
printf -v fill "%${filled}s"
printf -v pad "%${empty}s"
bar="${fill// /█}${pad// /░}"

cost_fmt=$(printf '$%.2f' "$cost")
mins=$((duration_ms / 60000))
secs=$(((duration_ms % 60000) / 1000))

# ── caveman badge (renders nothing if caveman mode is inactive) ───────────────
CAVEMAN_BADGE=""
if [ "${SL_CAVEMAN:-1}" != "0" ]; then
  CFG="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
  FLAG="$CFG/.caveman-active"
  SESSION_ID=$(printf '%s' "$input" | jq -r '.session_id // empty' 2>/dev/null | tr -cd 'A-Za-z0-9-')
  if [ -n "$SESSION_ID" ] && [ -f "$CFG/.caveman-sessions/$SESSION_ID.mode" ]; then
    FLAG="$CFG/.caveman-sessions/$SESSION_ID.mode"
  fi
  if [ ! -L "$FLAG" ] && [ -f "$FLAG" ]; then
    MODE=$(head -c 64 "$FLAG" 2>/dev/null | tr -d '\n\r' | tr '[:upper:]' '[:lower:]')
    MODE=$(printf '%s' "$MODE" | tr -cd 'a-z0-9-')
    BADGE=""
    case "$MODE" in
      caveman | lite | full) BADGE="CAVEMAN" ;;
      ultracave | ultra) BADGE="ULTRACAVE" ;;
      megacave | wenyan | wenyan-lite | wenyan-full | wenyan-ultra) BADGE="MEGACAVE" ;;
      commit | review | compress) BADGE="CAVEMAN:$(printf '%s' "$MODE" | tr '[:lower:]' '[:upper:]')" ;;
    esac
    [ -n "$BADGE" ] && CAVEMAN_BADGE=$(printf "${AMBER}[🪨 %s]${RESET}" "$BADGE")
  fi
fi

# ── effort level ──────────────────────────────────────────────────────────────
EFFORT_BADGE=""
if [ "${SL_EFFORT:-1}" != "0" ]; then
  EFFORT=$(printf '%s' "$input" | jq -r '.effort.level // empty' 2>/dev/null)
  if [ -n "$EFFORT" ]; then
    EFFORT_UP=$(printf '%s' "$EFFORT" | tr '[:lower:]' '[:upper:]')
    case "$EFFORT" in
      low)
        EFFORT_COLOR="$GRAY"
        EFFORT_ICON="▁"
        ;;
      medium)
        EFFORT_COLOR="$SKY_BLUE"
        EFFORT_ICON="▄"
        ;;
      high)
        EFFORT_COLOR="$BRIGHT_YELLOW"
        EFFORT_ICON="▇"
        ;;
      xhigh)
        EFFORT_COLOR="$ORANGE"
        EFFORT_ICON="█"
        ;;
      max)
        EFFORT_COLOR="$BRIGHT_RED"
        EFFORT_ICON="█"
        ;;
      *)
        EFFORT_COLOR="$GRAY"
        EFFORT_ICON="?"
        ;;
    esac
    EFFORT_BADGE=$(printf "${EFFORT_COLOR}⚡ %s %s${RESET}" "$EFFORT_ICON" "$EFFORT_UP")
  fi
fi

# ── assemble output ───────────────────────────────────────────────────────────
SEP=$(printf "${DARK_GRAY} │ ${RESET}")
OUT=""

append() {
  local part="$1"
  [ -z "$part" ] && return
  if [ -z "$OUT" ]; then
    OUT="$part"
  else
    OUT="${OUT}${SEP}${part}"
  fi
}

MODEL_BADGE="${CYAN}[${model}]${RESET}"
CTX_BADGE="${BAR_COLOR}${bar}${RESET} ${used_pct}%"
COST_BADGE="${YELLOW}${cost_fmt}${RESET}"
TIME_BADGE="⏱️ ${mins}m ${secs}s"

append "$CAVEMAN_BADGE"
append "$MODEL_BADGE"
append "$EFFORT_BADGE"
append "$CTX_BADGE"
append "$COST_BADGE"
append "$TIME_BADGE"

printf "%b" "$OUT"
