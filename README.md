# 📋 Daily Job-Search Brief

A [Claude Code](https://claude.com/claude-code) skill (+ optional nightly automation) that turns your **inbox and calendar** into a living job-search tracker and a short, **forward-looking daily brief** — so you always know what needs your attention (interviews to prep, replies you owe, threads to nudge) without digging through email.

---

## What it does
- Reads your **job-related email** (applications, recruiter replies, rejections) and **calendar** (interviews, recruiter/networking calls).
- Maintains a plain-Markdown **tracker**: Interviewing / Open / Rejected applications, active conversations & follow-ups, and contacts/referrers.
- Produces a **forward-looking daily brief** — *what needs you, what's upcoming, what you're waiting on.* Action-only, time-aware, no noise.
- Two ways to use it:
  - **On demand** — invoke the skill in a Claude Code session ("update my job brief").
  - **Automated** — a nightly background run that writes the brief to a file you can watch with one command.

## What it looks like

At the end of each run it prints a short, forward-looking brief — only what needs you, what's
upcoming, and what you're waiting on. A sample (illustrative — fictional companies and names):

```text
════════════════════════════════════════════
  🔔 BRIEF — 2026-05-14 21:30
════════════════════════════════════════════
Needs you / upcoming:
 • Tomorrow 10:00 AM — final-round panel with Northwind Labs (Growth PM). Prep: pull your
   metrics-impact stories; they flagged experimentation depth in the screen.
 • Reply owed to Dana Okafor (recruiter, Everline) — she asked for your availability the
   week of the 8th; 2 days old.
 • Brightwave take-home (product teardown) due Fri — ~2 hrs of work, not started yet.
Awaiting (just watching, no action):
 • Helio AI — waiting on the recruiter to confirm the hiring-manager screen after Monday's intro.
 • Referral intro to the Cartographer team (via Sam Patel) — sent, no reply yet.
Totals: 14 applications · 5 open · 3 rejected
```

Everything is action-only and time-aware: a call earlier today won't show as "upcoming," and
rejections are never rehashed. And on a quiet day it doesn't pad the brief — it just says:

```text
nothing needs action right now.
```

## What it deliberately does NOT do
It only sees **email and calendar.** It cannot read **LinkedIn messages, WhatsApp, or application portals** — those are blind spots. When something important lives there, *you* tell it and it logs it. It will **never fabricate** a "you owe a reply" from a notification it can't actually read.

## Requirements
- Claude Code
- A way for Claude to read your job email + calendar:
  - the **Gmail / Google Calendar connectors**, and/or
  - **Apple Mail** on macOS (via `osascript`) for accounts not on the connector
- *(Optional, for the nightly run)* macOS `launchd` or Linux `cron`

## Install (as a skill)
```bash
git clone https://github.com/<your-username>/daily-job-brief ~/.claude/skills/daily-job-brief
```
Then in Claude Code just ask: **"update my job brief"** (or run `/daily-job-brief`).

## Configure
```bash
cd ~/.claude/skills/daily-job-brief
cp config.example.sh config.sh    # then edit config.sh
```
Fill in your tracker path, your job email account(s) and how Claude reads each, and your personal-exclusion list. Comments in the file explain each field. `config.sh` is git-ignored so your details stay private.

## Optional: the nightly automation
See [`scripts/`](scripts/) — a runner (`daily-brief.sh`), a live-view command (`jobbrief`), and a `launchd`/`cron` template. Instructions in [`scripts/SETUP.md`](scripts/SETUP.md).

## Design principles (this is what makes it *not annoying*)
These were learned the hard way:
- **Read the email body** — never guess status from a subject line.
- **Forward-looking + time-aware brief** — only what's upcoming or needs action; never rehash rejections; never call a past event "upcoming."
- **Ask when ambiguous** instead of guessing (e.g., a calendar event it can't classify goes to a "❓ To confirm" list).
- **Privacy scoping** — on a mixed personal inbox, only read job-related threads (judged by sender), never personal/legal mail.
- **Respect the blind spots** (LinkedIn / portals / WhatsApp) — note "you tell me," never fabricate.
- **Future reminders go on the calendar**, not buried in a note that rots.

## License
MIT — see [LICENSE](LICENSE). Use it, fork it, make it yours.
