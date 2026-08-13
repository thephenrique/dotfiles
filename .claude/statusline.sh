#!/bin/bash
# Claude Code statusline: model + directory + git branch + context bar + cost + session time
# Installed/updated by the statusline-setup agent.

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
# dir=$(echo "$input" | jq -r '.workspace.current_dir // empty')
used_pct_raw=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
used_pct=$(printf '%.0f' "$used_pct_raw" 2>/dev/null || echo 0)
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

# Shorten $HOME to ~ for readability
# dir_display="${dir/#$HOME/\~}"

# Git branch for the current directory (skip optional locks; safe if not a repo)
# branch=""
# if git -C "$dir" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
#   branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
# fi

# Dim-friendly ANSI colors
CYAN='\033[36m'
BLUE='\033[34m'
MAGENTA='\033[35m'
YELLOW='\033[33m'
GREEN='\033[32m'
RED='\033[31m'
RESET='\033[0m'

# Context usage bar, colored by severity
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

# Session cost + elapsed time
cost_fmt=$(printf '$%.2f' "$cost")
mins=$((duration_ms / 60000))
secs=$(((duration_ms % 60000) / 1000))

# Caveman plugin mode badge (renders nothing if caveman mode is inactive)
# CAVEMAN_SCRIPT="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/hooks/caveman-statusline.sh"
# caveman_badge=""
# if [ -f "$CAVEMAN_SCRIPT" ]; then
#   caveman_badge=$(bash "$CAVEMAN_SCRIPT" 2>/dev/null)
# fi

# Line 1: [model] 📁 dir 🌿 branch + caveman badge
line1="${CYAN}[${model}]${RESET}"
# [ -n "$dir_display" ] && line1="${line1} 📁 ${BLUE}${dir_display}${RESET}"
# [ -n "$branch" ] && line1="${line1} 🌿 ${MAGENTA}${branch}${RESET}"
# [ -n "$caveman_badge" ] && line1="${line1} ${caveman_badge}"

# Line 2: context bar | cost | session time
# line2="${BAR_COLOR}${bar}${RESET} ${used_pct}% | ${YELLOW}${cost_fmt}${RESET} | ⏱️ ${mins}m ${secs}s"
line1="${line1} ${BAR_COLOR}${bar}${RESET} ${used_pct}% | ${YELLOW}${cost_fmt}${RESET} | ⏱️ ${mins}m ${secs}s"

# printf "%b\n%b" "$line1" "$line2"
printf "%b\n%b" "$line1"
