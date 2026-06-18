# Day 1 Handoff — LAC 2026 Csound 7 Workshop

**Presenter:** Richard Boulanger  
**Session date:** 2026-06-17 / 2026-06-18 (prep Day 1)  
**Resume at:** University — fresh Cursor chat  
**Audience:** Next agent or Richard resuming work

> **Start here in a new chat:** Read this file, then `handoff.md`, `University-resume.md`, and execute `FINAL-TEST-PLAN.md`.

---

## 1. Session summary — what was accomplished Day 1

Day 1 focused on making the **LAC 2026 Csound 7 workshop** demo-ready on Richard's Mac, with a parallel **Linux VM** story for attendee validation.

| Area | Accomplishment |
|------|----------------|
| **Linux VM** | `lac-2026-linux` provisioned (Ubuntu 22.04 aarch64); Csound 7 built; Node 22, Bun, Chromium; xrdp + XFCE desktop |
| **VM repo sync** | `~/Dr.C-Standalone` and `~/Dr.C` inside VM (not `/mnt`); Linux-native `npm install` with `@rollup/rollup-linux-arm64-gnu` |
| **RDP workflow** | `open-linux-desktop.sh` health checks; Windows App connection at `192.168.252.7:3389` |
| **Mac-side RDP launchers** | `Dr.C Linux Standalone Launch.command` / `Dr.C Linux Terminal Launch.command` — launch Dr.C on VM `DISPLAY=:10` from Mac after RDP connect |
| **VM desktop icons** | XFCE `.desktop` files + trust fixes (`a3a85a3`, `4bac43d`); fallback `~/bin/drc-standalone-gui.sh` |
| **PulseAudio / RDP audio** | Companion tooling added (`6063c03`, `e5e16c9`, `82be7cc`) — audio over RDP still needs manual Windows App setting |
| **Terminal mount fix** | `68e0373` — Linux Terminal launch when Dr.C Multipass mount is stale |
| **Mac Standalone** | Desktop launcher works; `npm test` passes (126 smoke + build) |
| **Workshop bundle** | `Dr.C-Workshop-Demo` on GitHub with handouts, `player-demos/`, launchers, agent docs |
| **Attendee handouts** | `MAC-ATTENDEE-HANDOUT.md`, `LINUX-ATTENDEE-HANDOUT.md` — one-page install/verify guides |
| **Mac Desktop** | Folder aliases to repos; `.command` launchers for Mac/Linux/VM workflows |
| **Prior session fixes** (still relevant) | Web app clobber hardening (`9dfe607`), FM bell routing (`70ab4cd`), Cabbage export (`8b4976c`), `/mnt` rollup guards (`af52b56`) |

**On-stage rule (unchanged):** Primary projector GUI = **Dr.C Mac Standalone only**. Linux VM GUI is for attendee Linux demos and validation inside the VM — not the main stage screen.

---

## 2. Current state (green / yellow / red)

| Status | Item | Notes |
|--------|------|-------|
| 🟢 **Green** | Mac `npm test` | `cd ~/Dr.C-Standalone && npm test` — **126 passed, 0 failed** + build + workshop tests |
| 🟢 **Green** | Mac Standalone launcher | **Dr.C Mac Standalone** on Desktop opens Pro+ instructor mode |
| 🟢 **Green** | VM running | `lac-2026-linux` **Running** @ `192.168.252.7` |
| 🟢 **Green** | Git pushed | Standalone `lac-2026-csound7` @ `68e0373`; Workshop-Demo `main` @ `0419515` |
| 🟢 **Green** | `player-demos/` | FM bell, trumpet, trapped blue/sand CSDs + `manifest.json` + `models/` in Workshop-Demo repo |
| 🟡 **Yellow** | Manual GUI smoke | **FINAL-TEST-PLAN §A2** (FM bell, Player) and **§A5** (web app clobber regression) — **not yet signed off** |
| 🟡 **Yellow** | Mac Terminal | Fix landed (`68e0373`); **verify after `git pull`** — double-click **Dr.C Mac Terminal** |
| 🟡 **Yellow** | RDP audio | No confirmed sound over RDP; enable **Play sound on this computer** in Windows App PC settings |
| 🟡 **Yellow** | VM `npm test` | Automated gate in VM shell — run with `NODE_OPTIONS=--max-old-space-size=4096` |
| 🟡 **Yellow** | Web app regression | Fixes through `9dfe607`; **must re-test §A5** after pull |
| 🔴 **Red** | CsoundQt / Cabbage on VM | **No aarch64 builds** on Ubuntu 22.04 VM — use **Mac** for Cabbage/CsoundQt demos |
| 🔴 **Red** | VM desktop icon clicks | Trackpad/trust quirks in RDP — **use Mac-side Launch.command** instead (recommended workflow) |
| ⚪ **Optional** | Ollama on VM | Not required for workshop; offline demos work without API key |

---

## 3. Repos & commits

### Pull before university session

```bash
cd ~/Dr.C-Standalone && git fetch && git checkout lac-2026-csound7 && git pull
cd ~/Dr.C && git pull
cd ~/Dr.C-URLS && git pull
cd ~/Dr.C-Workshop-Demo && git pull
```

### Dr.C-Standalone (`lac-2026-csound7`)

| Item | Value |
|------|-------|
| Path | `~/Dr.C-Standalone` |
| Branch | `lac-2026-csound7` |
| **HEAD (Day 1 end)** | **`68e0373`** |
| Remote | `https://github.com/mateolarreaferro/DRC-Standalone.git` |

**Day 1 commits (newest first):**

```
68e0373 Fix Linux Terminal launch when Dr.C Multipass mount is stale.
e5e16c9 Fix pulseaudio-module-xrdp source build on Linux VMs.
82be7cc Simplify linux-vm-install-audio-companion.sh for one-shot VM use.
6063c03 Add PulseAudio and companion tooling for lac-2026-linux aarch64 VM.
72e48ae Add RDP-aware Mac launchers for Linux VM Dr.C apps.
4bac43d Fix XFCE desktop launcher trust so VM icons launch over RDP.
a3a85a3 Use explicit $HOME script paths in VM desktop launchers.
0cd5d22 Harden Linux desktop RDP for lac-2026 workshop VMs.
af52b56 Guard Linux VM launches against Mac node_modules from /mnt mounts.
476ddc5 Fix XFCE desktop launchers for lac-2026-linux VM.
9dfe607 Harden web-app artifact lock against CSD clobber during playback.
70ab4cd Route workshop "FM bell" to shimmer starter…
8b4976c Harden Cabbage/VST export for Csound 7…
```

### Dr.C-Workshop-Demo (`main`)

| Item | Value |
|------|-------|
| Path | `~/Dr.C-Workshop-Demo` |
| Branch | `main` |
| **HEAD (Day 1 handoff)** | **`0419515`** |
| Remote | `https://github.com/csounder/Dr.C-Workshop-Demo.git` |

```
0419515 Add Day 1 handoff doc for university resume.
9289663 Document Mac-side RDP presenter workflow for Linux Dr.C launches.
ac0207a Document RDP launchers, audio, Ollama, and API keys for Linux VM.
01fbd26 Document Workshop-Demo as tracked git repo on GitHub.
892b7f4 Add full LAC workshop demo folder and Player CSD bundle.
a32510f Add Mac attendee handout and link both platform handouts in README.
```

### Other repos (session baseline)

| Repo | Path | Branch | HEAD (session) |
|------|------|--------|----------------|
| Dr.C Terminal | `~/Dr.C` | `main` | `f7e88ab` |
| Install / URLs | `~/Dr.C-URLS` | `main` | `ed46c4d` |
| Web apps | `~/Dr.C-WebApps` | — | `_CsoundLive/web` |
| WASM smoke | `~/Dr.C-WASM` | — | experiments |

---

## 4. Mac Desktop assets

### Folder aliases (double-click opens in Finder)

| Desktop item | Target |
|--------------|--------|
| `Dr.C-Standalone` | `~/Dr.C-Standalone` |
| `Dr.C-Terminal` | `~/Dr.C` |
| `Dr.C-URLS` | `~/Dr.C-URLS` |
| `Dr.C-WebApps+` | `~/Dr.C-WebApps` |
| `Dr.C-WASM` | `~/Dr.C-WASM` |
| `Dr.C-Workshop-Demo` | `~/Dr.C-Workshop-Demo` |
| `MAC-ATTENDEE-HANDOUT` | `~/Dr.C-Workshop-Demo/MAC-ATTENDEE-HANDOUT.md` |
| `LINUX-ATTENDEE-HANDOUT` | `~/Dr.C-Workshop-Demo/LINUX-ATTENDEE-HANDOUT.md` |

### `.command` launchers (symlinks on Desktop)

| Desktop icon | Script |
|--------------|--------|
| **Dr.C Mac Standalone** | `~/Dr.C-Standalone/launchers/Dr.C Mac Standalone.command` |
| **Dr.C Mac Terminal** | `~/Dr.C/opencode/launchers/Dr.C Mac Terminal.command` |
| **a-Dr.C Linux Desktop** | `~/Dr.C-Standalone/launchers/Dr.C Linux Desktop.command` → `open-linux-desktop.sh` |
| **Dr.C Linux VM Shell** | `~/Dr.C-Standalone/launchers/Dr.C Linux VM Shell.command` |
| **Dr.C Linux VM Start** | `~/Dr.C-Standalone/launchers/Dr.C-Linux-VM-Start.command` |
| **Dr.C Linux Standalone** | `~/Dr.C-Standalone/launchers/Dr.C Linux Standalone.command` (shell workflow) |
| **Dr.C Linux Terminal** | `~/Dr.C-Standalone/launchers/Dr.C Linux Terminal.command` (shell workflow) |
| **Dr.C Linux Standalone Launch** | `~/Dr.C-Standalone/launchers/Dr.C Linux Standalone Launch.command` → **RDP workflow (recommended)** |
| **Dr.C Linux Terminal Launch** | `~/Dr.C-Standalone/launchers/Dr.C Linux Terminal Launch.command` → **RDP workflow (recommended)** |

### Workshop-Demo launchers (in repo; also via folder alias)

| File | Purpose |
|------|---------|
| `Dr.C-Standalone.command` | → `launch-drc-standalone.sh` (Pro+ mode) |
| `Dr.C-Terminal.command` | → `launch-drc-terminal.sh` (TUI, project = Workshop-Demo) |
| `Dr.C-Attendee.command` | → attendee / free-tier mode |
| `Csound7-WASM-Smoke-Test.command` | Browser WASM check |

### Attendee handouts

| File | Audience |
|------|----------|
| `MAC-ATTENDEE-HANDOUT.md` | Mac attendees — Csound 7, Node 22, clone/DMG, verify |
| `LINUX-ATTENDEE-HANDOUT.md` | Linux attendees — no apt csound 6.x, AppImage/git |

---

## 5. Linux VM (`lac-2026-linux`)

| Item | Value |
|------|-------|
| VM name | `lac-2026-linux` |
| OS | Ubuntu 22.04.5 LTS **aarch64** |
| State | **Running** (verify: `multipass list`) |
| IPv4 | **`192.168.252.7`** (verify: `multipass info lac-2026-linux`) |
| Login | `ubuntu` / `ubuntu` |
| Csound 7 | `~/Applications/Csound/bin/csound` |
| RDP | xrdp port **3389** — **Windows App** (Mac App Store) |
| DISPLAY (RDP) | Typically **`:10`** (auto-detected by Mac launch scripts) |
| Mounts | `/Users/richardboulanger/Dr.C-Standalone` → `/mnt/Dr.C-Standalone`; `Dr.C` → `/mnt/Dr.C` |
| **Use in VM** | **`~/Dr.C-Standalone`** — **never** `/mnt/Dr.C-Standalone` for `npm run dev` |

### Recommended Mac-side launch workflow (RDP)

1. Double-click **a-Dr.C Linux Desktop** (or `~/Dr.C-Standalone/scripts/open-linux-desktop.sh`).
2. Connect **Windows App** → Add PC → `192.168.252.7:3389` → `ubuntu` / `ubuntu`.
3. Wait for XFCE desktop inside RDP.
4. On the **Mac Desktop** (not inside VM), double-click:
   - **Dr.C Linux Standalone Launch.command**, or
   - **Dr.C Linux Terminal Launch.command**

Equivalent Terminal:

```bash
~/Dr.C-Standalone/scripts/launch-linux-standalone-rdp.sh
~/Dr.C-Standalone/scripts/launch-linux-terminal-rdp.sh
```

**Why Mac-side launch?** Fewer RDP trackpad quirks, no “untrusted desktop file” prompts, same scripts as documented in `LINUX-DESKTOP.md`.

### VM desktop icons (fallback / trust issues)

XFCE icons exist but can fail to launch reliably over RDP. If needed:

```bash
# Inside VM terminal (RDP or multipass shell):
~/bin/drc-standalone-gui.sh
```

Re-apply desktop setup:

```bash
multipass transfer ~/Dr.C-Standalone/scripts/vm-setup-linux-desktop.sh lac-2026-linux:/tmp/
multipass exec lac-2026-linux -- sudo bash /tmp/vm-setup-linux-desktop.sh
```

---

## 6. What works

| Feature | Status |
|---------|--------|
| **Dr.C Mac Standalone** | Opens from Desktop; Pro+ instructor mode |
| **Mac `npm test`** | Passes — platform + 126 smoke + build + workshop |
| **`player-demos/`** | `player_fm_bell.csd`, trumpet, trapped blue/sand + `manifest.json` + `models/` |
| **FM bell offline** | Agent → **Load workshop FM bell (no key)** |
| **Player demos** | Player → Demos → FM-Bell (no API key) |
| **Linux VM shell** | `multipass shell lac-2026-linux`; Csound 7 on PATH |
| **RDP connect** | xrdp active; XFCE visible when session stable |
| **Mac → VM app launch** | RDP-aware scripts detect `DISPLAY=:10` |
| **Terminal mount fix** | `68e0373` — stale `/mnt/Dr.C` mount handled |
| **Attendee mode** | `Dr.C-Attendee.command` / `launch-workshop-attendee.sh` |

---

## 7. Known issues / blockers

| Issue | Mitigation |
|-------|------------|
| **No sound over RDP** | Windows App → edit PC → **Play sound on this computer**; workshop stage uses **Mac Standalone** for live audio |
| **CsoundQt / Cabbage on VM** | No aarch64 on Ubuntu 22.04 VM — demo on **Mac**; headless: `node scripts/test-cabbage-export.mjs` |
| **VM desktop click / trust** | Use **Mac-side Launch.command**; fallback `~/bin/drc-standalone-gui.sh` |
| **Web app clobber regression** | Re-test **FINAL-TEST-PLAN §A5** after `git pull` (`9dfe607`+) |
| **RDP clipboard paste from Mac** | Unreliable — paste long strings via `multipass shell` |
| **Windows App crash on open** | `~/Dr.C-Standalone/scripts/reset-windows-app-rdp-state.sh --execute` |
| **XFCE WM exit 139** | Re-run `vm-setup-linux-desktop.sh` |
| **Ubuntu apt `csound` = 6.17** | Workshop gate requires **7.x** — VM build at `~/Applications/Csound/bin/csound` |
| **Ollama** | Optional; offline demos do not require it |

---

## 8. Pending before workshop

Execute in order — see `FINAL-TEST-PLAN.md` for full steps and checkboxes.

| Priority | Task | Section |
|----------|------|---------|
| 1 | `git pull` all repos; confirm Standalone ≥ `68e0373` | Preflight |
| 2 | Mac `npm test` | A1 |
| 3 | **Manual GUI:** FM bell, Player FM-Bell | **A2** |
| 4 | **Manual GUI:** Web app convert survival (no CSD revert) | **A5** |
| 5 | Cabbage headless + optional UI | A4 |
| 6 | Mac Terminal — verify after `68e0373` pull | B |
| 7 | VM shell `npm test` + `DRC_DRY_RUN=1` | C |
| 8 | RDP sound test (Windows App audio setting) | D + `LINUX-DESKTOP.md` |
| 9 | Fill regression log | §E |
| 10 | USB / links: Workshop-Demo + `INSTALL-*.md` from `~/Dr.C-URLS` | `README.md` |

---

## 9. Quick commands cheat sheet

### Status

```bash
multipass list
multipass info lac-2026-linux
git -C ~/Dr.C-Standalone rev-parse --short HEAD
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
csound --version | head -1
```

### Connect RDP

```bash
~/Dr.C-Standalone/scripts/open-linux-desktop.sh
# Windows App → 192.168.252.7:3389 → ubuntu / ubuntu
```

### Mac Standalone (on-stage)

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
~/Dr.C-Standalone/scripts/launch-drc.sh
# or: double-click Dr.C Mac Standalone
```

### Mac Terminal

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$HOME/.bun/bin:$PATH"
cd ~/Dr.C/opencode && bun run dev -- ~/Dr.C-Workshop-Demo
# or: double-click Dr.C Mac Terminal
```

### Linux VM — RDP launch from Mac (after RDP connected)

```bash
~/Dr.C-Standalone/scripts/launch-linux-standalone-rdp.sh
~/Dr.C-Standalone/scripts/launch-linux-terminal-rdp.sh
```

### Linux VM — shell (no RDP)

```bash
~/Dr.C-Standalone/scripts/launch-linux-vm.sh
# inside VM:
export PATH="$HOME/bin:$HOME/Applications/Csound/bin:$HOME/.bun/bin:$PATH"
export NODE_OPTIONS=--max-old-space-size=4096
cd ~/Dr.C-Standalone && npm test
DRC_DRY_RUN=1 ./scripts/launch-drc.sh
```

### Attendee mode (no API key)

```bash
~/Dr.C-Standalone/scripts/launch-workshop-attendee.sh
```

### Multipass fixes

```bash
multipass start lac-2026-linux
multipass transfer ~/Dr.C-Standalone/scripts/vm-setup-linux-desktop.sh lac-2026-linux:/tmp/
multipass exec lac-2026-linux -- sudo bash /tmp/vm-setup-linux-desktop.sh
~/Dr.C-Standalone/scripts/reset-windows-app-rdp-state.sh --execute   # Windows App crash
```

### Git pull (all workshop repos)

```bash
cd ~/Dr.C-Standalone && git fetch && git checkout lac-2026-csound7 && git pull
cd ~/Dr.C && git pull
cd ~/Dr.C-URLS && git pull
cd ~/Dr.C-Workshop-Demo && git pull
```

---

## 10. New chat pickup instructions

Paste this block into a **fresh Cursor chat** at university:

```
LAC 2026 Csound 7 workshop — resume from university.

Read first (in order):
1. ~/Dr.C-Workshop-Demo/DAY-1-HANDOFF.md
2. ~/Dr.C-Workshop-Demo/handoff.md
3. ~/Dr.C-Workshop-Demo/University-resume.md
4. ~/Dr.C-Workshop-Demo/FINAL-TEST-PLAN.md

Environment:
- Mac: ~/Dr.C-Standalone branch lac-2026-csound7 @ 68e0373+
- Multipass VM lac-2026-linux (ubuntu/ubuntu, ~192.168.252.7, DISPLAY :10 over RDP)
- Never run Dr.C from /mnt in VM — use ~/Dr.C-Standalone with Linux npm install
- VM tests: NODE_OPTIONS=--max-old-space-size=4096

Execute FINAL-TEST-PLAN.md in order. Priorities:
1. git pull all repos; confirm Standalone HEAD ≥ 68e0373
2. Mac npm test (automated gate)
3. Manual GUI: FINAL-TEST-PLAN §A2 (FM bell, Player) and §A5 (web app clobber regression) — highest risk
4. Mac Terminal verify after 68e0373 (double-click Dr.C Mac Terminal)
5. node scripts/test-cabbage-export.mjs on Mac (CsoundQt/Cabbage not on VM aarch64)
6. VM shell npm test + DRC_DRY_RUN=1
7. RDP: sound test with Windows App "Play sound on this computer"; prefer Mac-side Launch.command over VM desktop icons

Do NOT re-provision VM unless multipass list shows missing/broken VM or xrdp dead.

On-stage GUI = Dr.C Mac Standalone only — not RDP on projector.

Do not commit Workshop-Demo unless Richard asks.
```

---

## 11. File index

### Workshop-Demo (`~/Dr.C-Workshop-Demo`)

| File | Purpose |
|------|---------|
| **DAY-1-HANDOFF.md** | **This file** — Day 1 session resume |
| `handoff.md` | Full session handoff (environment, scripts, repos) |
| `University-resume.md` | 5-minute green checklist |
| `FINAL-TEST-PLAN.md` | Executable test plan with checkboxes |
| `AGENT-BRIEF.md` | Paste block for fresh Cursor chats |
| `README.md` | Workshop folder overview |
| `LINUX-DESKTOP.md` | RDP workflow, audio, Ollama, troubleshooting |
| `MAC-ATTENDEE-HANDOUT.md` | Mac attendee one-pager |
| `LINUX-ATTENDEE-HANDOUT.md` | Linux attendee one-pager |
| `launch-drc-standalone.sh` | Mac Standalone wrapper |
| `launch-drc-terminal.sh` | Mac Terminal wrapper |
| `launch-drc-attendee.sh` | Attendee mode wrapper |
| `Dr.C-*.command` | Double-click launchers |
| `player-demos/` | Player CSD bundle + `manifest.json` |
| `pluck_bass*.csd/html` | Compile / export examples |

### Dr.C-Standalone scripts (`~/Dr.C-Standalone/scripts/`)

| Script | Purpose |
|--------|---------|
| `launch-drc.sh` | Main Standalone launcher (Pro+) |
| `launch-workshop-attendee.sh` | Attendee / free-tier |
| `open-linux-desktop.sh` | Start VM, RDP IP/credentials |
| `launch-linux-standalone-rdp.sh` | Mac → VM Standalone on RDP DISPLAY |
| `launch-linux-terminal-rdp.sh` | Mac → VM Terminal on RDP DISPLAY |
| `launch-linux-vm.sh` | Start VM, sync, `multipass shell` |
| `linux-vm-host.sh` | Shared VM helpers |
| `vm-setup-linux-desktop.sh` | XFCE + xrdp + desktop files |
| `linux-vm-provision.sh` | One-time VM provision |
| `reset-windows-app-rdp-state.sh` | Fix Windows App crash |
| `smoke-test.mjs` | 126 automated checks |
| `test-cabbage-export.mjs` | Headless Cabbage export |
| `test-platform-launchers.mjs` | Launcher contract tests |

### Canonical install docs (`~/Dr.C-URLS`)

| Doc | Purpose |
|-----|---------|
| `INSTALL-STANDALONE.md` | Standalone install |
| `INSTALL-TERMINAL.md` | Terminal install |
| `LINUX-DESKTOP.md` | Canonical Linux desktop copy |

### Standalone workshop docs (`~/Dr.C-Standalone`)

| Doc | Purpose |
|-----|---------|
| `TESTING.md` | Full testing guide |
| `WORKSHOP.md` | Build notes, golden prompts |
| `PARTICIPANTS.md` | Participant handout (long form) |
| `LOCAL-LLM.md` | Ollama setup |

---

*Last updated: 2026-06-18 — Day 1 handoff for university resume.*
