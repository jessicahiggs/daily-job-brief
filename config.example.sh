#!/bin/bash
# ─────────────────────────────────────────────────────────────
# Daily Job-Search Brief — configuration
# Copy this file to `config.sh` and fill in your details.
# (config.sh is git-ignored, so your personal info stays local.)
# ─────────────────────────────────────────────────────────────

# Absolute path to your Markdown job tracker (created if it doesn't exist).
TRACKER_FILE="$HOME/Documents/Job Search.md"

# Where the daily brief text + run log get written.
STATE_DIR="$HOME/.daily-job-brief"

# Path to the Claude Code CLI (run `which claude` to find it).
CLAUDE_BIN="claude"

# Describe your job inbox(es) and how Claude should read each — free text.
# The nightly prompt passes this straight through, so be specific. Examples:
#   - "jobs@gmail.com  — Gmail connector; EVERY email is job-related; check the
#      'Job Applications' label, Trash (rejections), and the inbox."
#   - "me@gmail.com  — Apple Mail account 'Gmail'; MIXED personal + job. Only read
#      threads whose sender is a company/recruiter domain. Job folder: 'Job apps'.
#      Also check its Trash for deleted rejections."
JOB_EMAIL_NOTES="Describe your job inbox(es) here — see examples above."

# Which calendar(s) to check for interviews / recruiter / networking calls.
# e.g. "jobs@gmail.com (all job-related)" — connector calendar id(s).
CALENDAR_NOTES="Describe your job calendar(s) here."

# Personal senders / recurring events / friends / coaching to ALWAYS ignore.
# Comma-separated keywords or addresses. Examples:
#   "gym, dentist, mom@example.com, weekly therapy, my coaching clients"
EXCLUDE="List personal things to ignore here."
