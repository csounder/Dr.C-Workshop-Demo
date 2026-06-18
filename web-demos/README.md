# Dr.C Web App Demos (Workshop Snapshots)

After cloning the workshop repo, run from `~/Dr.C-Workshop-Demo/web-demos` (or `./web-demos` from the clone root):

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

Static browser demos bundled for LAC 2026 workshop attendees. Each folder is a self-contained snapshot exported from **Dr.C Standalone → Convert to Web App**. Open any demo folder directly, or use the gallery index at http://localhost:8080.

## Before you play

1. Click **Start Audio** (or equivalent) in each app — browser autoplay policy requires a user gesture.
2. **Internet required** — these demos load Csound WASM from a CDN (jsDelivr / cdnjs). Etude#1 also uses Three.js CDN and remote background images.
3. **Weather Sonification** calls the Open-Meteo API for live weather data.

## Demos

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

## Updating

These are **workshop snapshots**, not live dev projects. To publish a new version, edit the CSD in Dr.C Standalone and use **Convert to Web App**, then replace the matching folder here.

Re-bundle from source (maintainers):

```bash
python3 scripts/bundle-web-demos.py
```
