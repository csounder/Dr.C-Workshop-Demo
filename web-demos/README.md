# Dr.C Web App Demos (Workshop Snapshots)

Static browser demos bundled for LAC 2026 workshop attendees. Each folder is a self-contained snapshot exported from **Dr.C Standalone → Convert to Web App**.

## Run locally

```bash
cd web-demos
python3 -m http.server 8080
```

Open **http://localhost:8080** for the gallery, or open any demo folder directly.

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
