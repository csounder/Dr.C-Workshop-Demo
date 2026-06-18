# LAC 2026 — Dr.C Standalone (Linux attendee)

**Your laptop** · branch **`lac-2026-csound7`** · min commit **`0cd5d22`** · v1.3.1  
Repo: https://github.com/mateolarreaferro/Dr.C-Standalone · Releases: https://github.com/mateolarreaferro/Dr.C-Standalone/releases

> **No API key required** for offline demos (FM bell, Player, Web Apps).

<!-- Maintainer: keep in sync with MAC-ATTENDEE-HANDOUT.md structure (~70–80 lines, one printed page). -->

## Prerequisites

- **Csound 7.x** on `PATH` — Ubuntu 22.04 `apt install csound` = **6.17** (gate fails)
- **Node.js 22** · Desktop session (X11/Wayland) for Electron GUI

## 1. Csound 7 + Node 22

```bash
csound --version    # must show version 7.x
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs build-essential cmake git libjack-jackd2-dev
node -v    # v22.x
```

**Jammy:** do **not** use apt csound. Install from [csound/csound releases](https://github.com/csound/csound/releases) or [BUILD.md](https://github.com/csound/csound/blob/develop/BUILD.md); symlink:

```bash
mkdir -p ~/bin && ln -sf ~/Applications/Csound/csound ~/bin/csound
```

## 2. Get Dr.C — AppImage or git clone

**A — AppImage:** `DrC-*.AppImage` from [Releases](https://github.com/mateolarreaferro/Dr.C-Standalone/releases) → `chmod +x DrC-*.AppImage && ./DrC-*.AppImage`

**B — Git clone:**

```bash
git clone -b lac-2026-csound7 https://github.com/mateolarreaferro/Dr.C-Standalone.git ~/Dr.C-Standalone
cd ~/Dr.C-Standalone && git pull && npm install && chmod +x launchers/*.sh scripts/*.sh
cp .env.example .env   # optional
```

Electron deps: `sudo apt install -y libnss3 libatk-bridge2.0-0 libgtk-3-0 libxss1 libasound2`

## 3. Launch (attendees)

```bash
cd ~/Dr.C-Standalone && ./launchers/Dr.C-Workshop-Attendee.sh
```

Launcher prepends `~/bin` + `~/Applications/Csound` so Csound 7 wins over system 6.x.

## 4. No-key demo

1. **Agent** → **Load workshop FM bell (no key)**
2. **Player** → **Demos** → FM-Bell · **Web Apps** tab

## 5. Agent model (optional)

OpenRouter [openrouter.ai/keys](https://openrouter.ai/keys) · Ollama `ollama pull qwen2.5-coder:7b` → Settings → Use local LLM · Groq/Gemini free = backup only

## 6. Verify before class

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$HOME/.local/bin:$PATH"
csound --version && cd ~/Dr.C-Standalone && npm run test:platform && npm test
csound -n -d -m0 -o /tmp/fm.wav resources/workshop-starters/fm_starter.csd
```

`test:smoke` on Csound 6.x is **not** a full gate — need **7.x** for `test:platform`.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `csound not found` / apt 6.x | Csound 7 binaries or build; use launcher |
| Blank screen after Send | Quit + relaunch (stale port 5173) |
| `npm install` fails | Node 22; `npx electron-builder install-app-deps` |
| Agent weak | **Load workshop FM bell (no key)** or Ollama/API key |
| Web app silent | **Start Audio**; internet for WASM CDN |

Full: `~/Dr.C-Standalone/PARTICIPANTS.md` · `~/Dr.C-URLS/INSTALL-STANDALONE.md`
