# LAC 2026 — Dr.C Workshop Demo

Attendee materials for the Dr.C · Csound 7 workshop. Clone or download this repo, then follow the handout for your platform.

**Repo:** https://github.com/csounder/Dr.C-Workshop-Demo

---

## Start here

| Platform | Handout |
|----------|---------|
| **Mac** | [MAC-ATTENDEE-HANDOUT.md](./MAC-ATTENDEE-HANDOUT.md) |
| **Linux** | [LINUX-ATTENDEE-HANDOUT.md](./LINUX-ATTENDEE-HANDOUT.md) |
| **QR sheet** (print / project) | [ATTENDEE-QR-SHEET.md](./ATTENDEE-QR-SHEET.md) |

No API key is required for offline demos (FM bell, Player, Web Apps).

---

## Get Dr.C Standalone

Workshop build on branch `lac-2026-csound7`:

```bash
git clone -b lac-2026-csound7 https://github.com/csounder/DRC-Standalone.git ~/Dr.C-Standalone
cd ~/Dr.C-Standalone && npm install
```

Releases: https://github.com/csounder/DRC-Standalone/releases

---

## Launchers (double-click on Mac)

| File | Opens |
|------|--------|
| **Dr.C-Attendee.command** | Standalone in free-tier / offline-demo mode (recommended) |
| **Dr.C-Standalone.command** | Full Standalone from `~/Dr.C-Standalone` |
| **Dr.C-Terminal.command** | Dr.C Terminal TUI (project folder = this repo) |

Linux: run `./launch-drc-attendee.sh` (or `launch-drc-standalone.sh` / `launch-drc-terminal.sh`) from this folder.

---

## What's in this folder

- **`player-demos/`** — sample CSDs for the Player
- **`pluck_bass*.csd`** — simple compile / play examples
- **`pluck_bass_web.html`**, **`pluck_bass_cabbage.html`** — web export examples
