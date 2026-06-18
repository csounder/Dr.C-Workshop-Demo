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

Linux: run `./launch-drc-attendee.sh` (or `launch-drc-standalone.sh` / `launch-drc-terminal.sh`) from this folder.

---

## Web demos

Ten browser Web Apps in **`web-demos/`**. Run the gallery locally:

```bash
cd web-demos
python3 -m http.server 8080
```

Open **http://localhost:8080**. Click **Start Audio** in each app; **internet required** for Csound WASM (CDN). See [web-demos/README.md](./web-demos/README.md) for per-demo notes.

| Folder | Description |
|--------|-------------|
| `Dr.C-Etude1` | Generative audio-visual etude |
| `Dr.C-Weather_Sonification` | Live weather → sound |
| `Dr.C-DrumMachine` | Drum machine / sequencer |
| `Dr.C-StarChart_Sonification` | Night sky → sound |
| `Dr.C-Fractal_Explorer-L_Systems` | L-system fractal explorer |
| `Dr.C-Mandelbrot_Explorer` | Mandelbrot set sonification |
| `Dr.C-FM_Explorer-Fibonacci_Version` | Fibonacci FM synthesis explorer |
| `Dr.C-FM_Simple` | Simple FM synth with presets |
| `Dr.C-FM_Synth` | FM synth with waveform/FFT display |
| `Dr.C_Fibonacci_Pads` | Fibonacci pad synthesizer |

---

## What's in this folder

- **`player-demos/`** — sample CSDs for the Player
- **`web-demos/`** — ten browser Web Apps (see **Web demos** above)
- **`pluck_bass*.csd`** — simple compile / play examples
- **`pluck_bass_web.html`**, **`pluck_bass_cabbage.html`** — web export examples
