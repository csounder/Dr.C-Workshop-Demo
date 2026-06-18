# LAC 2026 — Dr.C Standalone (Mac attendee)

**Your laptop** · branch **`lac-2026-csound7`** · min commit **`68e0373`** · v1.3.1  
Repo: https://github.com/csounder/DRC-Standalone · Releases: https://github.com/csounder/DRC-Standalone (main only — **use git clone for workshop**)

> **No API key required** for offline demos (FM bell, Player, Web Apps).

<!-- Maintainer: keep in sync with LINUX-ATTENDEE-HANDOUT.md structure (~70–80 lines, one printed page). -->

## Prerequisites

- **Csound 7.x** on `PATH` — Homebrew `csound` may be **6.x** (gate fails)
- **Node.js 22** · macOS desktop session for Electron GUI

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

## 2. Get Dr.C — git clone (recommended)

**Git clone** (workshop build on `lac-2026-csound7`):

```bash
git clone -b lac-2026-csound7 https://github.com/csounder/DRC-Standalone ~/Dr.C-Standalone
cd ~/Dr.C-Standalone && git pull && npm install && chmod +x launchers/*.command scripts/*.sh
cp .env.example .env   # optional
```

**Optional — DMG (older main-branch build, not workshop):** `DrC-*-arm64.dmg` or `DrC-*-x64.dmg` from [Releases](https://github.com/csounder/DRC-Standalone) → drag **DrC** to **Applications**. First launch: **Right-click → Open → Open**, or `xattr -cr /Applications/DrC.app`

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

## 5. Agent model (optional)

OpenRouter [openrouter.ai/keys](https://openrouter.ai/keys) · Ollama `ollama pull qwen2.5-coder:7b` → Settings → Use local LLM · Groq/Gemini free = backup only

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
