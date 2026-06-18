# LAC 2026 Workshop Demo Folder

Double-click launchers on the Desktop point here. Safe project directory for Dr.C Terminal; demo CSDs for compile smoke tests.

---


## Source repository

Clone or download: **https://github.com/csounder/Dr.C-Workshop-Demo**

Includes Mac/Linux attendee handouts, Desktop `.command` launchers, sample CSDs, `player-demos/`, and session docs (`DAY-1-HANDOFF.md`, `handoff.md`, `FINAL-TEST-PLAN.md`).

---

## Launchers

| File | What it opens |
|------|----------------|
| **Dr.C-Standalone.command** | Dr.C Standalone from `~/Dr.C-Standalone` (Pro+ mode) |
| **Dr.C-Terminal.command** | Dr.C Terminal TUI in this folder |
| **Dr.C-Attendee.command** | Standalone in **free-tier / offline-demo** mode |
| **Csound7-WASM-Smoke-Test.command** | Browser Csound 7 WASM check |

---

## Demo files

| File | Description |
|------|-------------|
| `pluck_bass.csd` | Offline pluck bass (~8 s score) — good compile test |
| `pluck_bass_midi.csd` | MIDI hold template |
| `pluck_bass_web.html` | Web synth export example |
| `pluck_bass_cabbage.html` | Cabbage export example |

---

## Prerequisites (your machine)

<!-- Maintainer: attendee handouts are one-page (~70–80 lines). Keep Mac/Linux pairs in sync; Desktop aliases point here. -->

**Mac attendees (own laptop):** see **[MAC-ATTENDEE-HANDOUT.md](./MAC-ATTENDEE-HANDOUT.md)** — one-page install, launch, and verify.

**Linux attendees (own laptop):** see **[LINUX-ATTENDEE-HANDOUT.md](./LINUX-ATTENDEE-HANDOUT.md)** — one-page install, launch, and verify.

1. **Csound 7** — `csound --version` shows version 7
2. **Dr.C Standalone** — cloned to `~/Dr.C-Standalone`, branch `lac-2026-csound7`, `npm install`
3. **Dr.C Terminal** — cloned to `~/Dr.C`, `cd opencode && bun install`
4. **Node 22** (Standalone) and **Bun 1.3.9+** (Terminal)

---

## Verify before class

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
cd ~/Dr.C-Standalone && npm test
cd ~/Dr.C/opencode && npm run test:workshop
```

See `~/Dr.C-Standalone/TESTING.md` for the full manual checklist.

---

## USB copy for attendees

Copy this entire folder plus install PDFs from `~/Dr.C-URLS`:

- `INSTALL-STANDALONE.md`
- `INSTALL-TERMINAL.md`

Point beginners to **Dr.C-Attendee.command** (no API key required for offline demos).
