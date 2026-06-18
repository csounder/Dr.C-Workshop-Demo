# LAC 2026 — Dr.C Standalone (Mac attendee)

**Your laptop** · branch **`lac-2026-csound7`** · min commit **`68e0373`** · v1.3.1  
Repo: https://github.com/csounder/DRC-Standalone · Releases: https://github.com/csounder/DRC-Standalone/releases

> **No API key required** for offline demos (FM bell, Player, Web Apps).

<!-- Maintainer: keep in sync with LINUX-ATTENDEE-HANDOUT.md structure (~70–80 lines, one printed page). -->

## Prerequisites

- **Csound 7.x** on `PATH` — Homebrew `csound` may be **6.x** (gate fails)
- **Node.js 22** · macOS desktop session for Electron GUI
- **CsoundQt 7** and **Cabbage** (required — see § Companion tools)

## 1. Csound 7 + Node 22

```bash
csound --version    # must show version 7.x
brew install node@22
node -v             # v22.x
```

Install Csound 7 from [csound/csound releases](https://github.com/csound/csound/releases) (universal `.pkg` or `.dmg`) to **`~/Applications/Csound/`**:

```bash
mkdir -p ~/bin && ln -sf ~/Applications/Csound/csound ~/bin/csound
echo 'export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

If Homebrew Csound 6 shadows CS7: `brew unlink csound`

## Companion tools

Install **after Csound 7**. In Dr.C: **Settings → CsoundQt** / **Settings → Cabbage** (auto-detect or **Choose…**).

| Tool | Install |
|------|---------|
| **CsoundQt 7** (required) | [CsoundQt releases](https://github.com/CsoundQt/CsoundQt/releases) — `CsoundQt-*-MacOS.dmg` (v7 beta) → **Applications** |
| **Cabbage** (required) | [cabbageaudio.com/download](https://cabbageaudio.com/download/) or [GitHub releases](https://github.com/cabbageaudio/Cabbage/releases) (2.10.7+) → **Applications** |

**Optional:** [Audacity](https://www.audacityteam.org/) (`brew install --cask audacity`) · [Reaper](https://www.reaper.fm/download.php) (ARM64 or x64 Mac build)

## 2. Get Dr.C — git clone (recommended)

**Git clone** (workshop build on `lac-2026-csound7`):

```bash
git clone -b lac-2026-csound7 https://github.com/csounder/DRC-Standalone.git ~/Dr.C-Standalone
cd ~/Dr.C-Standalone && git pull && npm install && chmod +x launchers/*.command scripts/*.sh
cp .env.example .env   # optional
```

**Optional — DMG:** if a release is posted on [csounder/DRC-Standalone Releases](https://github.com/csounder/DRC-Standalone/releases), use `DrC-*-arm64.dmg` or `DrC-*-x64.dmg` → drag **DrC** to **Applications**. First launch: **Right-click → Open → Open**, or `xattr -cr /Applications/DrC.app`. **Workshop build:** prefer **git clone** above.

## 3. Launch (attendees)

**Double-click:** `~/Dr.C-Standalone/launchers/Dr.C-Workshop-Attendee.command`

Or in Terminal:

```bash
cd ~/Dr.C-Standalone && ./scripts/launch-workshop-attendee.sh
```

Launcher prepends `~/bin` + `~/Applications/Csound` so Csound 7 wins over Homebrew 6.x.

## 4. No-key demo

1. **Agent** → **Load workshop FM bell (no key)**
2. **Player** → **Demos** → FM-Bell · **Web Apps** tab

## 5. Agent / LLM (optional)

| Option | Type | Setup |
|--------|------|-------|
| **Ollama** (best free) | Local | [ollama.com/download](https://ollama.com/download) → `ollama pull qwen2.5-coder:7b` → Settings → **Local LLM server** → **Use local LLM for Agent** → **Test** |
| Groq | Cloud free | [console.groq.com/keys](https://console.groq.com/keys) → Settings → paste key (rate limits) |
| Gemini | Cloud free | [aistudio.google.com/apikey](https://aistudio.google.com/apikey) → Settings → paste key (backup when Groq throttles) |
| OpenRouter | Cloud | [openrouter.ai/keys](https://openrouter.ai/keys) — best quality with credits; free slugs at [openrouter.ai/models?max_price=0](https://openrouter.ai/models?max_price=0) |

**No key:** Agent → **Load workshop FM bell (no key)** · Player demos · Web Apps. Full guide: `~/Dr.C-Standalone/LOCAL-LLM.md`

**Dr.C Terminal only:** [opencode.ai/zen](https://opencode.ai/docs/zen/) free models via `/connect` — not wired into Standalone GUI.

## 6. Verify before class

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
csound --version && cd ~/Dr.C-Standalone && npm run test:platform && npm test
csound -n -d -m0 -o /tmp/fm.wav resources/workshop-starters/fm_starter.csd
```

Expected: platform checks + **126 passed, 0 failed** (smoke) + build + `Workshop tests passed`

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `csound not found` / brew 6.x | Csound 7 in `~/Applications/Csound`; use launcher |
| "App is damaged" / Gatekeeper | Right-click → Open, or `xattr -cr DrC.app` |
| Blank screen after Send | Quit + relaunch (stale port 5173) |
| `npm install` fails | Node 22; `npx electron-builder install-app-deps` |
| Agent weak | **Load workshop FM bell (no key)** or Ollama/API key |
| Web app silent | **Start Audio**; internet for WASM CDN |

Full: `~/Dr.C-Standalone/PARTICIPANTS.md` · `~/Dr.C-URLS/INSTALL-STANDALONE.md`
