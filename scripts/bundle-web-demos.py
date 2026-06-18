#!/usr/bin/env python3
"""Copy Dr.C WebApps into web-demos/ for workshop attendees."""
import os
import shutil
import sys
from pathlib import Path

SRC = Path("/Users/richardboulanger/Dr.C-WebApps")
DEST = Path("/Users/richardboulanger/Dr.C-Workshop-Demo/web-demos")
AIMS = Path(
    "/Users/richardboulanger/dB-Studio/AIMS - Berklee (June 3-6)/Presentation"
)

COPIES = [
    (
        "Dr.C-Etude1",
        [
            (SRC / "Etude1" / "ETUDE1_LANDING_PAGE.html", "index.html"),
            (SRC / "Etude1" / "ETUDE1_v5.1_PERFECT_LABELS.html", "ETUDE1_v5.1_PERFECT_LABELS.html"),
        ],
    ),
    (
        "Dr.C-Weather_Sonification",
        [
            (SRC / "Weather Sonification" / "index.html", "index.html"),
            (SRC / "Weather Sonification" / "weather_sonification_v2.html", "weather_sonification_v2.html"),
        ],
    ),
    (
        "Dr.C-DrumMachine",
        [
            (SRC / "DrumMachine-Standalone" / "index.html", "index.html"),
            (SRC / "DrumMachine-Standalone" / "manifest.json", "manifest.json"),
            (SRC / "DrumMachine-Standalone" / "icon.png", "icon.png"),
        ],
    ),
    (
        "Dr.C-StarChart_Sonification",
        [
            (SRC / "StarChart Sonification" / "index.html", "index.html"),
            (SRC / "StarChart Sonification" / "app.html", "app.html"),
            (SRC / "StarChart Sonification" / "app-mobile.html", "app-mobile.html"),
            (SRC / "StarChart Sonification" / "favicon.ico", "favicon.ico"),
            (AIMS / "d-Starchart" / "app-desktop.html", "app-desktop.html"),
        ],
    ),
    (
        "Dr.C-Fractal_Explorer-L_Systems",
        [
            (SRC / "Fractal Explorer (L-Systems)" / "index.html", "index.html"),
            (SRC / "Fractal Explorer (L-Systems)" / "app.html", "app.html"),
        ],
    ),
    (
        "Dr.C-Mandelbrot_Explorer",
        [
            (SRC / "Mandelbrot Explorer" / "index.html", "index.html"),
            (SRC / "Mandelbrot Explorer" / "app-v2.1.html", "app-v2.1.html"),
            (SRC / "Mandelbrot Explorer" / "quickstart.html", "quickstart.html"),
        ],
    ),
    (
        "Dr.C-FM_Explorer-Fibonacci_Version",
        [
            (SRC / "FM Explorer (Fibonacci Version)" / "index.html", "index.html"),
            (
                SRC / "FM Explorer (Fibonacci Version)" / "Dr.C - Fibonacci FM Explorer.html",
                "Dr.C - Fibonacci FM Explorer.html",
            ),
        ],
    ),
    (
        "Dr.C-FM_Simple",
        [
            (SRC / "fm-simple (nice preset approach)" / "index.html", "index.html"),
        ],
    ),
    (
        "Dr.C-FM_Synth",
        [
            (
                SRC
                / "fm-synth (nice waveform and fft split screen display, nive onm screen keuboard and arpeggiator, nice USB MIDI apporach)"
                / "fm-synth.html",
                "index.html",
            ),
        ],
    ),
    (
        "Dr.C_Fibonacci_Pads",
        [
            (SRC / "fibonacci-pads" / "index.html", "index.html"),
        ],
    ),
]

# Alternate source paths if primary missing
ALT = {
    SRC / "fm-simple (nice preset approach)" / "index.html": [
        SRC / "fm-simple" / "index.html",
    ],
    SRC
    / "fm-synth (nice waveform and fft split screen display, nive onm screen keuboard and arpeggiator, nice USB MIDI apporach)"
    / "fm-synth.html": [
        SRC / "fm-synth" / "fm-synth.html",
        SRC / "fm-synth" / "index.html",
    ],
}


def resolve(src: Path) -> Path | None:
    if src.exists():
        return src
    for alt in ALT.get(src, []):
        if alt.exists():
            return alt
    return None


def dir_size(path: Path) -> int:
    total = 0
    for root, _dirs, files in os.walk(path):
        for f in files:
            total += (Path(root) / f).stat().st_size
    return total


def main() -> int:
    DEST.mkdir(parents=True, exist_ok=True)
    missing = []
    copied = []

    for folder, files in COPIES:
        out = DEST / folder
        out.mkdir(parents=True, exist_ok=True)
        got_any = False
        for src, name in files:
            resolved = resolve(src)
            if resolved is None:
                missing.append(f"{folder}: {src}")
                continue
            shutil.copy2(resolved, out / name)
            copied.append(f"{folder}/{name} <- {resolved}")
            got_any = True
        if not got_any:
            print(f"ERROR: no files copied for {folder}", file=sys.stderr)

    print("=== Copied ===")
    for line in copied:
        print(line)

    if missing:
        print("\n=== Missing sources ===")
        for line in missing:
            print(line)

    print("\n=== Sizes ===")
    total = 0
    for d in sorted(DEST.iterdir()):
        if d.is_dir():
            sz = dir_size(d)
            total += sz
            print(f"{sz/1024:.0f}K\t{d.name}")
    print(f"TOTAL {total/1024:.0f}K ({total} bytes)")

    print("\n=== Entry HTML ===")
    for d in sorted(DEST.iterdir()):
        if d.is_dir():
            ok = (d / "index.html").exists()
            print(f"{'OK' if ok else 'MISSING'}\t{d.name}")

    return 1 if missing else 0


if __name__ == "__main__":
    raise SystemExit(main())
