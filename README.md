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

**Before class:** install **Csound 7**, **CsoundQt 7**, and **Cabbage** (required). **Audacity** and **Reaper** are optional but recommended — see your platform handout § Companion tools.

---

## Get Dr.C Standalone

Workshop build on branch `lac-2026-csound7`:

```bash
git clone -b lac-2026-csound7 https://github.com/csounder/DRC-Standalone.git ~/Dr.C-Standalone
cd ~/Dr.C-Standalone && npm install
```

Pre-built installers may be added later; for LAC 2026 use **git clone** on `lac-2026-csound7`.

---

## Launchers (double-click on Mac)

| File | Opens |
|------|--------|
| **Dr.C-Attendee.command** | Standalone in free-tier / offline-demo mode (recommended) |
| **Dr.C-Standalone.command** | Full Standalone from `~/Dr.C-Standalone` |
| **Dr.C-Terminal.command** | Dr.C Terminal TUI (project folder = this repo) |

**Mac first launch:** Right-click a `.command` file → **Open** → **Open** (Gatekeeper). If blocked or “damaged”:

```bash
xattr -cr ~/Dr.C-Workshop-Demo/*.command
xattr -cr ~/Dr.C-Standalone/launchers/*.command
chmod +x ~/Dr.C-Standalone/launchers/*.command
```

For a packaged app: `xattr -cr /Applications/DrC.app`

Linux: run `./launch-drc-attendee.sh` (or `launch-drc-standalone.sh` / `launch-drc-terminal.sh`) from this folder.

---

## Web demos

After cloning this repo, run the browser gallery from `~/Dr.C-Workshop-Demo/web-demos` (or `./web-demos` from the clone root):

```bash
cd ~/Dr.C-Workshop-Demo/web-demos
python3 -m http.server 8080
```

Then open **http://localhost:8080**

1. Dr.C-Etude1
2. Dr.C-Weather_Sonification
3. Dr.C-DrumMachine
4. Dr.C-StarChart_Sonification
5. Dr.C-Fractal_Explorer-L_Systems
6. Dr.C-Mandelbrot_Explorer
7. Dr.C-FM_Explorer-Fibonacci_Version
8. Dr.C-FM_Simple
9. Dr.C-FM_Synth
10. Dr.C_Fibonacci_Pads

Click **Start Audio** in each app. Internet required for Csound WASM CDN. Details: [web-demos/README.md](./web-demos/README.md)

---

## What's in this folder

- **`player-demos/`** — sample CSDs for the Player
- **`web-demos/`** — ten browser Web Apps (see **Web demos** above)
- **`pluck_bass*.csd`** — simple compile / play examples
- **`pluck_bass_web.html`**, **`pluck_bass_cabbage.html`** — web export examples
