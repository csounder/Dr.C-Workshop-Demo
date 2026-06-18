#!/usr/bin/env bash
# LAC 2026 — Dr.C Standalone for workshop attendees (free tier, offline demos)
set -euo pipefail

export PATH="${HOME}/bin:${HOME}/Applications/Csound:${HOME}/.local/bin:/opt/homebrew/opt/node@22/bin:/opt/homebrew/bin:/usr/local/bin:${PATH:-}"

DRC_ROOT="${DRC_STANDALONE_ROOT:-${HOME}/Dr.C-Standalone}"

[[ -d "$DRC_ROOT" ]] || {
  echo "Dr.C Standalone not found at $DRC_ROOT"
  echo "Clone: git clone https://github.com/mateolarreaferro/Dr.C-Standalone.git ~/Dr.C-Standalone"
  read -r -p "Press Enter to close..." || true
  exit 1
}

echo "Dr.C Standalone — ATTENDEE mode (free tier, offline demos)"
echo "Source: $DRC_ROOT"
echo "Csound: $(csound --version 2>&1 | head -1)"
echo ""

cd "$DRC_ROOT"
exec ./scripts/launch-workshop-attendee.sh
