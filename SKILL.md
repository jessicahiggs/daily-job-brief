---
name: daily-job-brief
description: Track job applications and generate a forward-looking daily job-search brief from the user's email and calendar. Use when the user wants to log or track job applications and recruiter conversations, get a summary of their job search, or maintain a job-search tracker. Reads only email + calendar — not LinkedIn, portals, or WhatsApp.
---

# Daily Job-Search Brief

Maintain the user's job-search tracker and produce a short, forward-looking brief.

## Config
Read `config.sh` in this skill's folder (or ask the user) to learn:
- **TRACKER_FILE** — the Markdown file to maintain (create it if it doesn't exist).
- **Email accounts** and how to read each — the Gmail connector, or Apple Mail via `osascript`. Note which accounts are 100% job-related vs. mixed personal.
- **Calendars** to check.
- **EXCLUDE** — personal senders / recurring events / friends / coaching to always ignore.

## Tracker structure (Markdown, in TRACKER_FILE)
- `## 🟢 Interviewing / live` — active interview processes.
- `## 🔵 Open applications` — applied, awaiting.
- `## ⚪ Rejected` — with dates.
- `## 📬 Active conversations & follow-ups` — recruiters/referrers, one line each, ending in an **ACTION:** or "no action."
- `## Contacts / referrals`
Recompute the counts line and set "Last synced" to today each run.

## Each run, do three jobs
1. **Applications.** Scan the job email (label/folder + trash + inbox) and **READ BODIES** to classify: new application / interview / rejection / offer. Add or advance the role. Record **both** application and rejection dates. Never duplicate; never write garbage — skip anything ambiguous and note it. (LinkedIn "your application was sent to X" notices count as applications; role usually unnamed → "role unspecified, confirm.")
2. **Conversations.** Scan for human recruiter/referrer/networking threads — **including the user's Sent mail and the plain inbox**, not just a label. **Re-open active threads** to find the true latest message and who owes a reply. Decide follow-ups **from the text** (a real open loop: they asked something unanswered, promised to get back and the window passed, a call needs scheduling) — **never from elapsed time alone.**
3. **Calendar.** Surface the user's **own** interviews / recruiter / networking calls. Exclude personal events. If you can't tell whether an event is job-related, add it to a **"❓ To confirm"** block and **ask** — do not guess.

## Hard rules (these matter most)
- **Read bodies, not subjects.**
- **Privacy:** on a mixed inbox, judge job-relevance by the **sender's address**; never open personal / legal / financial threads.
- **Blind spots:** you only see **email + calendar.** LinkedIn messages, WhatsApp, and application-portal statuses are **invisible.** Never fabricate a "you owe a reply" from a notification you can't read — note that the user will tell you. A role marked "open" may already be rejected on its portal.
- **Future reminders** ("check back in September") can't live in a brief — put them on the user's calendar as an event (default: a single popup 15 min before, unless they say otherwise).
- When unsure of a thread's state, **say so** rather than invent an action.

## The output — the brief
End with a **forward-looking, ACTION-ONLY** brief. Be **time-aware**: a call earlier today is not "upcoming." **Do NOT rehash rejections or logged history** — the brief is "what needs my attention," not a diary.

```
🔔 BRIEF — <date, time>
Needs you / upcoming:
 • <calls/deadlines still ahead (with date/time), replies you owe, prep needed — most urgent first>
Awaiting (just watching, no action):
 • <who/what you're waiting on>
Totals: <N> applications · <N> open · <N> rejected
```
If nothing needs action, say "nothing needs action right now."
