#!/bin/bash
# Nightly Job-Search Brief runner.
# Schedule with launchd (macOS) or cron (Linux) — see SETUP.md.
set -uo pipefail

HERE="$(cd "$(dirname "$0")/.." && pwd)"
[ -f "$HERE/config.sh" ] || { echo "Missing config.sh — copy config.example.sh to config.sh and edit it."; exit 1; }
# shellcheck source=/dev/null
source "$HERE/config.sh"

mkdir -p "$STATE_DIR"
BRIEF="$STATE_DIR/nightly-brief.txt"
LOG="$STATE_DIR/run.log"
STAMP="$(date '+%Y-%m-%d %H:%M')"

# Prepend the user's config as context, then the generic prompt.
CONTEXT="CONFIG for this run:
- TRACKER FILE (create if missing): $TRACKER_FILE
- JOB EMAIL — what to read and how: $JOB_EMAIL_NOTES
- CALENDARS to check: $CALENDAR_NOTES
- ALWAYS EXCLUDE (personal): $EXCLUDE
"

echo "[$STAMP] ===== run start =====" >> "$LOG"
OUT="$("$CLAUDE_BIN" -p "$CONTEXT

$(cat "$HERE/prompt.md")" --dangerously-skip-permissions 2>&1)"
printf '%s\n' "$OUT" >> "$LOG"
echo "[$STAMP] ===== run end =====" >> "$LOG"

# Extract the ===BRIEF=== block and append it to the brief file.
BRIEF_TEXT="$(printf '%s\n' "$OUT" | awk '/===BRIEF===/{f=1;next} /===END BRIEF===/{f=0} f')"
{
  echo
  echo "════════════════════════════════════════════"
  echo "  🔔 BRIEF — $STAMP"
  echo "════════════════════════════════════════════"
  printf '%s\n' "${BRIEF_TEXT:-"(no brief produced — see run.log)"}"
} >> "$BRIEF"
