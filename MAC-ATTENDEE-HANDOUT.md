# LAC 2026 — Dr.C Standalone (Mac attendee)

**Your laptop** · branch **`lac-2026-csound7`** · min commit **`68e0373`** · v1.3.1  
Repo: https://github.com/csounder/DRC-Standalone

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

## 2. Get Dr.C — git clone

**Git clone** (workshop build on `lac-2026-csound7`):

```bash
git clone -b lac-2026-csound7 https://github.com/csounder/DRC-Standalone.git ~/Dr.C-Standalone
cd ~/Dr.C-Standalone && git pull && npm install && chmod +x launchers/*.command scripts/*.sh
cp .env.example .env   # optional
```

Pre-built installers may be added later; for LAC 2026 use **git clone** on `lac-2026-csound7`.

## 3. Launch (attendees)

**Double-click:** `~/Dr.C-Standalone/launchers/Dr.C-Workshop-Attendee.command`

**First launch (Mac):** Right-click the `.command` file → **Open** → **Open** (Gatekeeper). If blocked or “damaged”:

```bash
xattr -cr ~/Dr.C-Standalone/launchers/*.command
xattr -cr ~/Dr.C-Workshop-Demo/*.command
chmod +x ~/Dr.C-Standalone/launchers/*.command
```

Or in Terminal:

```bash
cd ~/Dr.C-Standalone && ./scripts/launch-workshop-attendee.sh
```

Launcher prepends `~/bin` + `~/Applications/Csound` so Csound 7 wins over Homebrew 6.x.

## 4. No-key demo

1. **Agent** → **Load workshop FM bell (no key)**
2. **Player** → **Demos** → FM-Bell · **Web Apps** tab
3. **Browser gallery** — clone [Dr.C-Workshop-Demo](https://github.com/csounder/Dr.C-Workshop-Demo), then:

```bash
cd ~/Dr.C-Workshop-Demo/web-demos
python3 -m http.server 8080
```

Open **http://localhost:8080** — ten demos: Dr.C-Etude1 · Dr.C-Weather_Sonification · Dr.C-DrumMachine · Dr.C-StarChart_Sonification · Dr.C-Fractal_Explorer-L_Systems · Dr.C-Mandelbrot_Explorer · Dr.C-FM_Explorer-Fibonacci_Version · Dr.C-FM_Simple · Dr.C-FM_Synth · Dr.C_Fibonacci_Pads

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
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
csound --version && cd ~/Dr.C-Standalone && npm run test:platform && npm test
csound -n -d -m0 -o /tmp/fm.wav resources/workshop-starters/fm_starter.csd
```

Expected: platform checks + **126 passed, 0 failed** (smoke) + build + `Workshop tests passed`

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `csound not found` / brew 6.x | Csound 7 in `~/Applications/Csound`; use launcher |
| `.command` blocked / “damaged” | Right-click → **Open** → **Open**; or §3 `xattr -cr` + `chmod +x` |
| DrC.app “damaged” / Gatekeeper | Right-click → **Open** → **Open**; or `xattr -cr /Applications/DrC.app` |
| Blank screen after Send | Quit + relaunch (stale port 5173) |
| `npm install` fails | Node 22; `npx electron-builder install-app-deps` |
| Agent weak | **Load workshop FM bell (no key)** or Ollama/API key |
| Web app silent | **Start Audio**; internet for WASM CDN |

Full: `~/Dr.C-Standalone/PARTICIPANTS.md` · `~/Dr.C-URLS/INSTALL-STANDALONE.md`
