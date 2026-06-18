# Linux desktop (Multipass + RDP)

VM name: **lac-2026-linux** (Ubuntu with XFCE via xrdp).

## Quick start (Mac host)

1. Double-click **a-Dr.C Linux Desktop** on the Desktop, or run:
   `~/Dr.C-Standalone/scripts/open-linux-desktop.sh`
2. Connect with **Windows App** (App Store; formerly Microsoft Remote Desktop) to the shown IP on port **3389**.
3. Login: user **ubuntu**, password **ubuntu** (change inside the VM if needed).
4. Launch Dr.C **inside the RDP session** from the Mac host:
   - **Dr.C Linux Standalone Launch.command** — Electron GUI on auto-detected `DISPLAY` (usually `:10`)
   - **Dr.C Linux Terminal Launch.command** — TUI in `xfce4-terminal` on the RDP desktop

Or from Terminal on the Mac:

```bash
~/Dr.C-Standalone/scripts/launch-linux-standalone-rdp.sh
~/Dr.C-Standalone/scripts/launch-linux-terminal-rdp.sh
```

**Order matters:** connect RDP first, then run a Launch command. The scripts detect `/tmp/.X11-unix/X*` (prefers `:10+` for xrdp).

## Presenter workflow (recommended)

1. On the Mac, open **a-Dr.C Linux Desktop** (or `open-linux-desktop.sh`), then connect **Windows App** RDP to the VM.
2. After the XFCE desktop is visible in RDP, double-click **Dr.C Linux Standalone Launch.command** or **Dr.C Linux Terminal Launch.command** on the **Mac Desktop** — not the `.desktop` icons inside the VM.
3. Mac-side launchers are more reliable for workshops: fewer trackpad quirks in RDP, no “untrusted desktop file” prompts, and the same scripts as Terminal (`launch-linux-*-rdp.sh`).

## First-time VM setup

If RDP does not connect, install/configure the desktop on the VM:

```bash
multipass transfer ~/Dr.C-Standalone/scripts/vm-setup-linux-desktop.sh lac-2026-linux:/tmp/
multipass exec lac-2026-linux -- sudo bash /tmp/vm-setup-linux-desktop.sh
```

(Run on the **Mac host**; the script runs **inside** **lac-2026-linux**.)

Check xrdp:

```bash
multipass exec lac-2026-linux -- systemctl is-active xrdp
```

Should print `active`.

## Related

- Standalone Linux app: `~/Dr.C-Standalone/scripts/launch-linux-standalone.sh`
- VM shell: `~/Dr.C-Standalone/scripts/linux-vm-host.sh`

## Dr.C Standalone GUI (inside the VM)

Multipass may mount the Mac copy of the repo at `/mnt/Dr.C-Standalone`. **Do not** run `npm run dev` or `./scripts/launch-drc.sh` from `/mnt` — `node_modules` there contains macOS binaries (e.g. `@rollup/rollup-darwin-arm64`), and electron-vite will fail on Linux.

1. Use the copy in the VM home directory: `~/Dr.C-Standalone` (not `/mnt/...`).
2. After syncing source from the host, install dependencies **once on the VM**:
   ```bash
   export PATH="$HOME/bin:$HOME/Applications/Csound/bin:$HOME/.bun/bin:$PATH"
   cd ~/Dr.C-Standalone
   rm -rf node_modules
   npm install
   ```
3. Preflight: `DRC_DRY_RUN=1 ./scripts/launch-drc.sh`
4. Launch from the XFCE desktop (RDP session) or a VM terminal with `DISPLAY` set.

From the **Mac host**, `./scripts/launch-linux-vm.sh` rsyncs from `/mnt` into `~` (excluding `node_modules`) by default. Use `./scripts/launch-linux-standalone-rdp.sh` or `./scripts/launch-linux-terminal-rdp.sh` after RDP is connected.

## Audio over RDP

**Workshop default:** use **Dr.C Mac Standalone** on the Mac host for live Player / sound demos. RDP audio redirection is unreliable for low-latency Csound playback.

If you need audio inside the Linux VM over RDP:

1. **Windows App (Mac):** edit the PC connection → enable **Play sound on this computer** (redirect remote audio to Mac).
2. **VM:** ensure PulseAudio is available (`pulseaudio --check` or install `pulseaudio` if missing).
3. **xrdp:** audio uses the RDP sound channel; quality and latency vary. ALSA/JACK inside the VM may not route cleanly through xrdp.
4. **Fallback:** render to WAV in Dr.C and play in **Audacity** on Mac or inside the VM.

See also `~/Dr.C-URLS/INSTALL-STANDALONE.md` § Linux audio notes (ALSA/JACK for native Linux sessions).

## Ollama on the VM (local LLM)

Inside `multipass shell lac-2026-linux` (Ubuntu 22.04 aarch64):

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama serve &    # or: systemctl --user enable --now ollama
ollama pull qwen2.5-coder:7b
```

Dr.C finds Ollama at **`http://127.0.0.1:11434`** (Settings → Local LLM server → **Use local LLM for Agent** → **Test**). Full guide: `~/Dr.C-Standalone/LOCAL-LLM.md`.

## API keys on the VM

Copy and edit (never commit):

```bash
cd ~/Dr.C-Standalone
cp .env.example .env
chmod 600 .env
```

Supported variables (from `.env.example`):

| Variable | Purpose |
|----------|---------|
| `OPENROUTER_API_KEY` | One key for Claude, GPT, Gemini, … |
| `ANTHROPIC_API_KEY` | Direct Claude |
| `OPENAI_API_KEY` | Direct OpenAI |
| `GROQ_API_KEY` | Free-tier backup |
| `GEMINI_API_KEY` | Free-tier backup |

Dev mode loads `~/Dr.C-Standalone/.env`; you can also use `~/.env`. Packaged builds use **Settings → API Keys** in the app.

## Troubleshooting

### Symptom: “Windows App” crashes when you connect (not when you open it)

Usually **the Linux desktop session is dying**, not the Mac app. The VM is up and xrdp answers on port 3389, but XFCE’s window manager can exit immediately and the RDP client closes.

**On the Mac (Terminal):**

1. `multipass list` — **lac-2026-linux** should be **Running** (e.g. `192.168.252.7`).
2. `~/Dr.C-Standalone/scripts/open-linux-desktop.sh` — shows xrdp status and IP.
3. If it still drops: re-apply desktop setup on the VM:
   ```bash
   multipass transfer ~/Dr.C-Standalone/scripts/vm-setup-linux-desktop.sh lac-2026-linux:/tmp/
   multipass exec lac-2026-linux -- sudo bash /tmp/vm-setup-linux-desktop.sh
   ```
4. **Workshop fallback (no GUI):** `multipass shell lac-2026-linux` then run Dr.C from `~/Dr.C-Standalone`.
5. **Workshop fallback (Mac GUI):** run Dr.C Standalone on the Mac host.

**Windows App (Mac client) only:**

- Quit Windows App fully, reopen from Applications.
- Remove and re-add the PC (`192.168.252.7`, user `ubuntu`).
- If needed: delete app data (`~/Library/Containers/com.microsoft.rdc.macos`) and sign in again (last resort).
- Legacy alternative: install **Microsoft Remote Desktop** from the App Store if still available.

**On the VM (from `multipass shell lac-2026-linux`):**

```bash
sudo adduser xrdp ssl-cert
sudo systemctl restart xrdp
tail -20 /var/log/xrdp-sesman.log    # look for "exit code 139" = XFCE WM crash
tail -20 ~/.xsession-errors
```

### Windows App crashes on launch

The VM and xrdp are usually fine — this is **corrupt saved state** in the Mac client.

**Preferred:** `~/Dr.C-Standalone/scripts/reset-windows-app-rdp-state.sh --execute` (quit Windows App first).

**Or reset manually** — backup, then remove container/preferences (see script for paths). Reopen Windows App and re-add `192.168.252.7`.

If it still crashes: reinstall **Windows App** from the App Store, or try legacy **Microsoft Remote Desktop**. Workshop fallbacks: `multipass shell lac-2026-linux` or **Dr.C Mac Standalone**.

### Connect manually

- **PC / host:** `192.168.252.7`
- **Port:** `3389`
- **User / password:** `ubuntu` / `ubuntu`

