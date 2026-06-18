# LAC 2026 — Dr.C Standalone (Linux attendee)

**Your laptop** · branch **`lac-2026-csound7`** · min commit **`68e0373`** · v1.3.1  
Repo: https://github.com/csounder/DRC-Standalone

> **No API key required** for offline demos (FM bell, Player, Web Apps).

<!-- Maintainer: keep in sync with MAC-ATTENDEE-HANDOUT.md structure (~70–80 lines, one printed page). -->

## Prerequisites

- **Csound 7.x** on `PATH` — Ubuntu 22.04 `apt install csound` = **6.17** (gate fails)
- **Node.js 22** · Desktop session (X11/Wayland) for Electron GUI
- **CsoundQt 7** and **Cabbage** (required — see § Companion tools; aarch64 caveats below)

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

## Companion tools

Install **after Csound 7**. In Dr.C: **Settings → CsoundQt** / **Settings → Cabbage**.

| Tool | Install |
|------|---------|
| **CsoundQt 7** (required) | [CsoundQt releases](https://github.com/CsoundQt/CsoundQt/releases) — **x86_64:** v7 AppImage (`chmod +x`; symlink `~/bin/csoundqt`). **aarch64:** no official v7 binary — build `csoundqt7` branch (see `PARTICIPANTS.md`) or use macOS. `apt install csoundqt` on 22.04 is **6.x — not enough**. |
| **Cabbage** (required) | [cabbageaudio.com/download](https://cabbageaudio.com/download/) · [rorywalsh/cabbage releases](https://github.com/rorywalsh/cabbage/releases) — **x86_64:** `CabbageLinux-*.zip` → `installCabbage.sh`. **aarch64:** zip is **x86_64 only** — no native IDE; use macOS for full GUI or build from source. Dr.C **Convert → Cabbage** still works. |

**Optional:** Audacity (`sudo apt install audacity` or [Flatpak](https://flathub.org/apps/org.audacityteam.Audacity)) · Reaper tarball → `~/Applications/Reaper` ([reaper.fm/download.php](https://www.reaper.fm/download.php); aarch64 + x86_64)

## 2. Get Dr.C — git clone

**Git clone** (workshop build on `lac-2026-csound7`):

```bash
git clone -b lac-2026-csound7 https://github.com/csounder/DRC-Standalone.git ~/Dr.C-Standalone
cd ~/Dr.C-Standalone && git pull && npm install && chmod +x launchers/*.sh scripts/*.sh
cp .env.example .env   # optional
```

Electron deps: `sudo apt install -y libnss3 libatk-bridge2.0-0 libgtk-3-0 libxss1 libasound2`

Pre-built installers may be added later; for LAC 2026 use **git clone** on `lac-2026-csound7`.

## 3. Launch (attendees)

```bash
cd ~/Dr.C-Standalone && ./launchers/Dr.C-Workshop-Attendee.sh
```

Launcher prepends `~/bin` + `~/Applications/Csound` so Csound 7 wins over system 6.x.

## 4. No-key demo

1. **Agent** → **Load workshop FM bell (no key)**
2. **Player** → **Demos** → FM-Bell · **Web Apps** tab
3. **Browser gallery:** clone this repo → `cd web-demos && python3 -m http.server 8080` → http://localhost:8080

## 5. Agent / LLM (optional)

**Instructor typical:** Anthropic or OpenAI (paid). **Attendees:** Ollama, Groq, or Gemini (free).

| Option | Type | Setup |
|--------|------|-------|
| **Ollama** (recommended local) | Local | [ollama.com/download](https://ollama.com/download) → `ollama pull qwen2.5-coder:7b` → Settings → **Local LLM server** → **Use local LLM for Agent** → **Test** |
| **Anthropic** | Cloud paid | [console.anthropic.com/settings/keys](https://console.anthropic.com/settings/keys) → Settings → **Anthropic (Claude)** → **Test** · or `ANTHROPIC_API_KEY=` in `.env` |
| **OpenAI** | Cloud paid | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) → Settings → **OpenAI** → **Test** · or `OPENAI_API_KEY=` in `.env` |
| OpenRouter | Cloud | [openrouter.ai/keys](https://openrouter.ai/keys) — one key, many models; credits for best quality · free slugs at [openrouter.ai/models?max_price=0](https://openrouter.ai/models?max_price=0) |
| Groq | Cloud free | [console.groq.com/keys](https://console.groq.com/keys) → Settings → paste key (rate limits; backup) |
| Gemini | Cloud free or paid | [aistudio.google.com/apikey](https://aistudio.google.com/apikey) → Settings → paste key · same key for free tier or paid (enable billing in AI Studio for higher quotas) |

**No key:** Agent → **Load workshop FM bell (no key)** · Player demos · Web Apps. Full guide: `~/Dr.C-Standalone/LOCAL-LLM.md`

**Cursor API:** not supported in Standalone — Cursor’s API key runs [Cursor SDK agents](https://cursor.com/docs/sdk/typescript) (IDE/CI automation), not a drop-in chat key for Dr.C. Use Anthropic, OpenAI, OpenRouter, or Gemini instead.

**OpenCode Zen:** [opencode.ai/docs/zen](https://opencode.ai/docs/zen/) — **Dr.C Terminal only** (`/connect`); not wired into Standalone GUI.

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
