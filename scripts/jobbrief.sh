#!/bin/bash
# Watch your latest job brief live in a terminal.
# Tip: add an alias so you can just type `jobbrief`:
#   echo "alias jobbrief='bash $HOME/.claude/skills/daily-job-brief/scripts/jobbrief.sh'" >> ~/.bash_profile
set -uo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=/dev/null
source "$HERE/config.sh"
F="$STATE_DIR/nightly-brief.txt"
touch "$F"
clear
echo "📋  DAILY JOB-SEARCH BRIEF  —  live view   (Ctrl+C to exit)"
echo "────────────────────────────────────────────────────────────"
tail -n 200 -f "$F"
