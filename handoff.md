# LAC 2026 Csound 7 Workshop — Session Handoff

**Presenter:** Richard Boulanger  
**Date:** 2026-06-17  
**Audience:** Next agent or human resuming at university (fresh Cursor chat)

> **Start here:** Read `DAY-1-HANDOFF.md` (Day 1 summary), then this file, then `University-resume.md`, then run `FINAL-TEST-PLAN.md`.

---

## Environment snapshot (as of 2026-06-17)

### Mac home layout

| Path | Purpose |
|------|---------|
| `~/Dr.C-Standalone` | Electron GUI — branch **`lac-2026-csound7`** |
| `~/Dr.C` | Terminal / opencode monorepo — branch **`main`** |
| `~/Dr.C-URLS` | Install guides, canonical **`LINUX-DESKTOP.md`** |
| `~/Dr.C-WebApps` | Web apps (e.g. `_CsoundLive/web`) |
| `~/Dr.C-Workshop-Demo` | Workshop bundle (handouts, `player-demos/`, launchers, agent docs) — **git** [`main`](https://github.com/csounder/Dr.C-Workshop-Demo) |
| `~/Dr.C-WASM` | Csound 7 WASM smoke / experiments |

### Linux VM (Multipass)

| Item | Value |
|------|-------|
| VM name | `lac-2026-linux` |
| OS | Ubuntu 22.04 **aarch64** |
| Typical IP | `192.168.252.7` (verify with `multipass info lac-2026-linux`) |
| Login | `ubuntu` / `ubuntu` |
| Csound 7 | `~/Applications/Csound/bin/csound` (built from source in VM) |
| RDP | xrdp on port **3389** — connect via **Windows App** (Mac App Store) |
| Repo copy | Use **`~/Dr.C-Standalone`** inside VM — **not** `/mnt/Dr.C-Standalone` |

### Mac Desktop shortcuts (double-click)

| Desktop icon | Typical target |
|--------------|----------------|
| **Dr.C Mac Standalone** | `~/Dr.C-Workshop-Demo/Dr.C-Standalone.command` → Pro+ instructor mode |
| **Dr.C Mac Terminal** | `~/Dr.C-Workshop-Demo/Dr.C-Terminal.command` |
| **Dr.C Linux Desktop** | `~/Dr.C-Standalone/scripts/open-linux-desktop.sh` (RDP workflow) |
| **Dr.C Linux VM Shell** | `~/Dr.C-Standalone/scripts/launch-linux-vm.sh` |
| **Dr.C Linux VM Start** | `~/Dr.C-Standalone/scripts/start-linux-vm.sh` |
| **Dr.C Linux Standalone** | `~/Dr.C-Standalone/scripts/launch-linux-standalone.sh` |
| **Dr.C Linux Terminal** | `~/Dr.C-Standalone/scripts/launch-linux-terminal.sh` |

### On-stage rule

**Primary on-stage GUI = Dr.C Mac Standalone only.** Do not rely on RDP/Electron on the Mac projector screen. Linux VM GUI is for attendee Linux demos and validation inside the VM desktop.

---

## What was completed this session

| Area | Status |
|------|--------|
| Linux VM provision | `lac-2026-linux` created; Csound 7 built; Node 22, Bun, Chromium/Chrome |
| VM `npm install` | Linux-native rollup (`@rollup/rollup-linux-arm64-gnu`) in `~/Dr.C-Standalone` |
| XFCE desktop icons | Trust + `xfce4-terminal --hold`; `~/bin/drc-standalone-gui.sh` fallback |
| Windows App crash | Reset script: `reset-windows-app-rdp-state.sh --execute` |
| `open-linux-desktop.sh` | xrdp health checks; prefers legacy **Microsoft Remote Desktop** when both installed |
| `launch-drc.sh` | Guards against `/mnt` Mac `node_modules`; rollup arch checks |
| Git pushed | See **Repos & branches** below |
| Cabbage export | Commit `8b4976c` — MIDI opcode / envelope fixes for CS7 |
| FM Bell routing | Commit `70ab4cd` — shimmer starter before Chowning Hz models |
| Web app clobber | Commits `90f1e84` → `9dfe607` — artifact lock / freeze — **needs re-test** |

---

## Known issues / open items

| Issue | Notes |
|-------|-------|
| **Web app convert → reverts to CSD / autoplay** | Fixes through `9dfe607`; **must re-test** after `git pull` (see `FINAL-TEST-PLAN.md` §A) |
| **RDP clipboard paste from Mac** | Does not work reliably — paste long strings via **Mac Terminal** into `multipass shell` |
| **Windows App vs VM session crash** | Distinguish client crash (reset script) vs XFCE WM exit 139 (re-run `vm-setup-linux-desktop.sh`) |
| **Ubuntu apt `csound` = 6.17** | Workshop gate requires Csound **7.x** — use VM build at `~/Applications/Csound/bin/csound` |

---

## Key scripts

| Path | Purpose |
|------|---------|
| `~/Dr.C-Standalone/scripts/launch-drc.sh` | Main Standalone launcher (Pro+ default); `/mnt` + rollup guards |
| `~/Dr.C-Standalone/scripts/launch-workshop-attendee.sh` | Attendee / free-tier (`DRC_WORKSHOP_LITE=1`) |
| `~/Dr.C-Standalone/scripts/open-linux-desktop.sh` | Start VM, show RDP IP/credentials, open RDP client |
| `~/Dr.C-Standalone/scripts/reset-windows-app-rdp-state.sh` | Fix Windows App crash on launch (`--execute`) |
| `~/Dr.C-Standalone/scripts/linux-vm-provision.sh` | One-time VM packages, CS7 build, Node, Bun, browser |
| `~/Dr.C-Standalone/scripts/vm-setup-linux-desktop.sh` | XFCE + xrdp + desktop `.desktop` files + `drc-standalone-gui.sh` |
| `~/Dr.C-Standalone/scripts/linux-vm-host.sh` | Shared VM helpers, rsync `/mnt` → `~` (excludes `node_modules`) |
| `~/Dr.C-Standalone/scripts/launch-linux-vm.sh` | Start VM, sync, `multipass shell` |
| `~/Dr.C-Standalone/scripts/start-linux-vm.sh` | Start VM only |
| `~/Dr.C-Standalone/scripts/launch-linux-standalone.sh` | Host script → preflight/launch in VM |
| `~/Dr.C-Standalone/scripts/launch-linux-terminal.sh` | Host script → Terminal TUI in VM |
| `~/Dr.C-Standalone/scripts/test-cabbage-export.mjs` | Headless Cabbage export smoke |
| `~/Dr.C-Standalone/scripts/smoke-test.mjs` | 126 automated checks (`npm run test:smoke`) |
| `~/Dr.C-Standalone/scripts/test-platform-launchers.mjs` | Launcher + PATH contract |
| `~/Dr.C-Standalone/scripts/workshop-path.sh` | PATH for Csound 7 workshop |
| `~/Dr.C-Workshop-Demo/launch-drc-standalone.sh` | Desktop wrapper → `launch-drc.sh` |
| `~/Dr.C-Workshop-Demo/launch-drc-terminal.sh` | Desktop wrapper → `bun run dev -- ~/Dr.C-Workshop-Demo` |
| `~/Dr.C-Workshop-Demo/launch-drc-attendee.sh` | Attendee mode wrapper |
| **VM only:** `~/bin/drc-standalone-gui.sh` | Fallback GUI launcher inside `lac-2026-linux` |

---

## Repos & branches

| Repo | Path | Branch | HEAD (session) | Remote |
|------|------|--------|----------------|--------|
| Dr.C Standalone | `~/Dr.C-Standalone` | `lac-2026-csound7` | `68e0373` | `https://github.com/mateolarreaferro/DRC-Standalone.git` |
| Dr.C Terminal | `~/Dr.C` | `main` | `f7e88ab` | `https://github.com/mateolarreaferro/Dr.C.git` |
| Install / URLs | `~/Dr.C-URLS` | `main` | `ed46c4d` | `https://github.com/csounder/Dr.C.git` |
| Workshop demo bundle | `~/Dr.C-Workshop-Demo` | `main` | see `DAY-1-HANDOFF.md` | `https://github.com/csounder/Dr.C-Workshop-Demo.git` |

### Recent Standalone commits (lac-2026-csound7)

```
68e0373 Fix Linux Terminal launch when Dr.C Multipass mount is stale.
e5e16c9 Fix pulseaudio-module-xrdp source build on Linux VMs.
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

### Pull before university session

```bash
cd ~/Dr.C-Standalone && git fetch && git checkout lac-2026-csound7 && git pull
cd ~/Dr.C && git pull
cd ~/Dr.C-URLS && git pull
cd ~/Dr.C-Workshop-Demo && git pull
```

---

## Reference docs (in repos)

| Doc | Path |
|-----|------|
| Testing guide | `~/Dr.C-Standalone/TESTING.md` |
| Workshop build notes | `~/Dr.C-Standalone/WORKSHOP.md` |
| Participant handout | `~/Dr.C-Standalone/PARTICIPANTS.md` |
| Linux desktop (canonical) | `~/Dr.C-URLS/LINUX-DESKTOP.md` |
| Linux desktop (local copy) | `~/Dr.C-Workshop-Demo/LINUX-DESKTOP.md` |
| Workshop demo README | `~/Dr.C-Workshop-Demo/README.md` |

---

## How to start a fresh Cursor chat

Paste into a new chat (or use `AGENT-BRIEF.md`):

1. **Read first:** `~/Dr.C-Workshop-Demo/DAY-1-HANDOFF.md`, `handoff.md`, `University-resume.md`, `FINAL-TEST-PLAN.md`
2. **Do not re-provision the VM** unless `multipass list` shows missing/broken VM or xrdp dead
3. **Execute** `FINAL-TEST-PLAN.md` in order; prioritize Mac Standalone + web-app regression
4. **On-stage:** Mac Standalone only for projector demos

Participants can clone or download **https://github.com/csounder/Dr.C-Workshop-Demo** (handouts, launchers, demo CSDs, `player-demos/`). Optional: copy `FINAL-TEST-PLAN.md` to `~/Dr.C-URLS` for the install repo too.

---

## VM quick commands (copy-paste)

```bash
# Status
multipass list
multipass info lac-2026-linux

# Shell (no RDP)
~/Dr.C-Standalone/scripts/launch-linux-vm.sh

# RDP workflow
~/Dr.C-Standalone/scripts/open-linux-desktop.sh

# Re-apply desktop (XFCE / icons / xrdp)
multipass transfer ~/Dr.C-Standalone/scripts/vm-setup-linux-desktop.sh lac-2026-linux:/tmp/
multipass exec lac-2026-linux -- sudo bash /tmp/vm-setup-linux-desktop.sh

# VM tests (inside multipass shell)
export PATH="$HOME/bin:$HOME/Applications/Csound/bin:$HOME/.bun/bin:$PATH"
export NODE_OPTIONS=--max-old-space-size=4096
cd ~/Dr.C-Standalone && npm test
DRC_DRY_RUN=1 ./scripts/launch-drc.sh
```
