# Nightly automation setup

Runs the brief automatically each night in the background and appends it to a file
you can watch with `jobbrief`.

## 1. Configure
```bash
cd ~/.claude/skills/daily-job-brief
cp config.example.sh config.sh   # then edit config.sh with your details
```

## 2. Add the `jobbrief` command (optional but nice)
```bash
echo "alias jobbrief='bash $HOME/.claude/skills/daily-job-brief/scripts/jobbrief.sh'" >> ~/.bash_profile
# (use ~/.zshrc if your terminal runs zsh). Open a new terminal, then type: jobbrief
```

## 3a. Schedule it — macOS (launchd)
Edit `com.user.daily-job-brief.plist.example`: set the script path and the hour, then:
```bash
cp scripts/com.user.daily-job-brief.plist.example ~/Library/LaunchAgents/com.user.daily-job-brief.plist
launchctl load ~/Library/LaunchAgents/com.user.daily-job-brief.plist
launchctl list | grep daily-job-brief    # confirm it's registered
```
Note: it runs on *your Mac*, so the machine must be awake at the scheduled time
(a missed run fires at next wake).

## 3b. Schedule it — Linux (cron)
```bash
crontab -e
# add (runs 8 PM daily):
0 20 * * * /bin/bash $HOME/.claude/skills/daily-job-brief/scripts/daily-brief.sh
```

## Test it now
```bash
bash ~/.claude/skills/daily-job-brief/scripts/daily-brief.sh
jobbrief
```

## How it works
`daily-brief.sh` prepends your `config.sh` details to `prompt.md`, runs Claude Code
headless to read your email + calendar and update your tracker, then extracts the
`===BRIEF===` block into `nightly-brief.txt` — which `jobbrief` follows live.
