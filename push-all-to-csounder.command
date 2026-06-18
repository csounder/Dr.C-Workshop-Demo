#!/bin/bash
# One-click: push workshop app to csounder and fix all handout links.
set -euo pipefail
APP=~/Dr.C-Standalone
WS=~/Dr.C-Workshop-Demo

echo "=== Push lac-2026-csound7 to csounder/DRC-Standalone ==="
git -C "$APP" checkout lac-2026-csound7
gh repo create csounder/DRC-Standalone --public --description "Dr.C Standalone LAC 2026 Csound 7" 2>/dev/null || true
git -C "$APP" remote remove csounder 2>/dev/null || true
git -C "$APP" remote add csounder https://github.com/csounder/DRC-Standalone.git
git -C "$APP" push -u csounder lac-2026-csound7 --force-with-lease

echo "=== Fix handout links (mateolarreaferro → csounder) ==="
for f in MAC-ATTENDEE-HANDOUT.md LINUX-ATTENDEE-HANDOUT.md ATTENDEE-QR-SHEET.md README.md DAY-1-HANDOFF.md handoff.md; do
  [ -f "$WS/$f" ] || continue
  sed -i '' 's|mateolarreaferro/[^ )"]*|csounder/DRC-Standalone|g' "$WS/$f"
done
[ -f "$APP/PARTICIPANTS.md" ] && sed -i '' 's|mateolarreaferro/[^ )"]*|csounder/DRC-Standalone|g' "$APP/PARTICIPANTS.md"

git -C "$APP" add PARTICIPANTS.md 2>/dev/null && git -C "$APP" commit -m "Point participant links to csounder/DRC-Standalone" && git -C "$APP" push csounder lac-2026-csound7 || true

git -C "$WS" add -A
git -C "$WS" commit -m "Point all attendee links to csounder/DRC-Standalone" || true
git -C "$WS" push

echo ""
echo "=== DONE ==="
echo "Workshop: https://github.com/csounder/Dr.C-Workshop-Demo"
echo "App:      git clone -b lac-2026-csound7 https://github.com/csounder/DRC-Standalone.git"
echo "App SHA:  $(git -C "$APP" rev-parse --short lac-2026-csound7)"
echo "Docs SHA: $(git -C "$WS" rev-parse --short HEAD)"
read -r -p "Press Enter to close."
