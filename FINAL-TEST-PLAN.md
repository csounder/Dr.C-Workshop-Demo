# FINAL-TEST-PLAN — LAC 2026 Csound 7 Workshop

**Target commits:** `Dr.C-Standalone` `lac-2026-csound7` @ **`0cd5d22`** or newer  
**Date:** ___________ **Tester:** Richard Boulanger

---

## Preflight (all platforms)

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound/bin:$HOME/Applications/Csound:$HOME/.bun/bin:$PATH"
csound --version | head -1    # expect: version 7.x
git -C ~/Dr.C-Standalone rev-parse --short HEAD
```

| Repo | Expected branch | Min commit |
|------|-----------------|------------|
| `~/Dr.C-Standalone` | `lac-2026-csound7` | `0cd5d22` |
| `~/Dr.C` | `main` | `f7e88ab` |
| `~/Dr.C-URLS` | `main` | `ed46c4d` |

---

## A. Mac Standalone (primary on-stage)

**Launcher:** `~/Dr.C-Standalone/scripts/launch-drc.sh` or Desktop **Dr.C Mac Standalone**  
**Branch:** `lac-2026-csound7` · Key fixes: `70ab4cd` (FM bell), `8b4976c` (Cabbage), `9dfe607` (web app)

### A1. Automated gate

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
cd ~/Dr.C-Standalone
npm test
```

**Expected:** platform checks + **126 passed, 0 failed** (smoke) + build + `Workshop tests passed`

### A2. Launch + workshop models

```bash
~/Dr.C-Standalone/scripts/launch-drc.sh
```

| Step | Action | Pass? |
|------|--------|-------|
| A2a | App opens; no blank screen after load | ☐ |
| A2b | Agent → **Load workshop FM bell (no key)** — CSD appears, sound plays | ☐ |
| A2c | Player → Demos → **FM-Bell** — keyboard audible, on-pitch | ☐ |
| A2d | Golden shortcut / woodblock routing works (if exposed in UI) | ☐ |

### A3. Load custom CSD → convert to player

| Step | Action | Pass? |
|------|--------|-------|
| A3a | Open `~/Dr.C-Workshop-Demo/pluck_bass.csd` in Agent or load as artifact | ☐ |
| A3b | Player → **Load current CSD from Agent** → adapt → keyboard plays | ☐ |

### A4. Export to Cabbage

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
cd ~/Dr.C-Standalone
node scripts/test-cabbage-export.mjs
```

| Step | Action | Pass? |
|------|--------|-------|
| A4a | Script reports PASS for prepare/export checks | ☐ |
| A4b | UI: plain CSD → **Convert → Cabbage** → opens in Cabbage (if installed) | ☐ |

Reference demo: `~/Dr.C-Workshop-Demo/pluck_bass_cabbage.csd`

### A5. Web app export + Open in Browser — **clobber regression**

> **Critical:** Re-test after `9dfe607`. Failure = panel reverts to `main.csd` orchestra text and/or original bell autoplays.

**Launch (attendee OK):**

```bash
~/Dr.C-Standalone/scripts/launch-workshop-attendee.sh
```

| # | Step | Pass? |
|---|------|-------|
| 1 | Agent → **Load workshop FM bell (no key)** — wait for CSD + autoplay | ☐ |
| 2 | Artifact panel → **Convert** → **Web App** — wait for Preview tab | ☐ |
| 3 | Panel stays **Web App** / Preview (not orchestra `main.csd` text) | ☐ |
| 4 | **Open in Browser** — Chrome/Safari opens `~/Documents/DrC/webapps/.../index.html` | ☐ |
| 5 | Browser: **Start Audio** → keyboard plays bell | ☐ |
| 6 | **Wait 5–10 s** in Preview (no follow-up message) — panel must **not** flip to CSD or replay bell CSD | ☐ |
| 7 | Agent: type `add a reverb mix knob` — web app must **not** revert to original CSD | ☐ |
| 8 | Switch Web Apps tab ↔ Agent — web app artifact still in panel | ☐ |

**Fail signatures:** Preview → CSD text; original bell autoplays; missing **Open in Browser**.

---

## B. Mac Terminal (Dr.C TUI)

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$HOME/.bun/bin:$PATH"
cd ~/Dr.C/opencode
npm run test:platform
npm run test:workshop
```

**Expected:** platform + **12 passed, 0 failed** (workshop)

### B1. Interactive

```bash
cd ~/Dr.C/opencode && bun run dev -- ~/Dr.C-Workshop-Demo
```

| Step | Action | Pass? |
|------|--------|-------|
| B1a | TUI opens; project = `Dr.C-Workshop-Demo` | ☐ |
| B1b | Generate plain FM CSD (workshop prompt) | ☐ |
| B1c | Compile / smoke from CSD panel | ☐ |
| B1d | **Open in Cabbage** (if Cabbage installed) | ☐ |

---

## C. Linux VM via `multipass shell`

**Do not run from `/mnt/Dr.C-Standalone`.**

```bash
# Mac host
~/Dr.C-Standalone/scripts/launch-linux-vm.sh
```

Inside VM:

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound/bin:$HOME/.bun/bin:$PATH"
export NODE_OPTIONS=--max-old-space-size=4096
csound --version | head -1
cd ~/Dr.C-Standalone

# If rollup missing (Mac node_modules copied):
# rm -rf node_modules && npm install

npm test
DRC_DRY_RUN=1 ./scripts/launch-drc.sh
```

| Step | Action | Pass? |
|------|--------|-------|
| C1 | `csound --version` → **7.x** at `~/Applications/Csound/bin/csound` | ☐ |
| C2 | `npm test` passes (may need `NODE_OPTIONS` on aarch64) | ☐ |
| C3 | `DRC_DRY_RUN=1 ./scripts/launch-drc.sh` → preflight OK | ☐ |
| C4 | `./scripts/launch-drc.sh` from `/mnt/Dr.C-Standalone` → **refused** with helpful message | ☐ |

Terminal in VM (optional):

```bash
cd ~/Dr.C/opencode && npm run test:workshop
```

---

## D. Linux VM via RDP (Windows App)

```bash
~/Dr.C-Standalone/scripts/open-linux-desktop.sh
```

Connect: **`192.168.252.7:3389`** · `ubuntu` / `ubuntu`  
(Verify IP if connection fails: `multipass info lac-2026-linux`)

| Step | Action | Pass? |
|------|--------|-------|
| D1 | xrdp status **active** in script output | ☐ |
| D2 | Windows App connects (or legacy Microsoft Remote Desktop) | ☐ |
| D3 | XFCE desktop visible; no immediate disconnect (WM exit 139) | ☐ |
| D4 | Double-click **Dr.C Standalone** desktop icon — app launches | ☐ |
| D5 | FM bell offline demo works in VM GUI | ☐ |
| D6 | Fallback: `~/bin/drc-standalone-gui.sh` in VM terminal | ☐ |

**If Windows App crashes on launch (Mac):**

```bash
~/Dr.C-Standalone/scripts/reset-windows-app-rdp-state.sh --execute
```

**If session dies on connect:**

```bash
multipass transfer ~/Dr.C-Standalone/scripts/vm-setup-linux-desktop.sh lac-2026-linux:/tmp/
multipass exec lac-2026-linux -- sudo bash /tmp/vm-setup-linux-desktop.sh
```

---

## E. Regression checklist

| ID | Area | Test | Pass | Fail notes |
|----|------|------|------|------------|
| R1 | Mac auto | `npm test` | ☐ | |
| R2 | Mac GUI | FM bell no-key load | ☐ | |
| R3 | Mac GUI | Player FM-Bell audible | ☐ | |
| R4 | Mac GUI | Web app convert survival (A5) | ☐ | |
| R5 | Mac GUI | Open in Browser + Start Audio | ☐ | |
| R6 | Mac | `test-cabbage-export.mjs` | ☐ | |
| R7 | Mac TUI | `test:workshop` + interactive | ☐ | |
| R8 | VM shell | `npm test` + `DRC_DRY_RUN=1` | ☐ | |
| R9 | VM RDP | Desktop icon launch | ☐ | |
| R10 | VM | Not using `/mnt` node_modules | ☐ | |

### Session log

```
Date: ___________
Machine: MacBook ___ / macOS ___
Standalone HEAD: ___
Csound: ___
Mac npm test: pass / fail
Web app A5 (steps 1–8): pass / fail
Cabbage script: pass / fail
VM npm test: pass / fail / skipped
RDP desktop: pass / fail / skipped
Ready for LAC: yes / no
Notes:
```

---

## Optional: CsoundLive Web

```bash
cd ~/Dr.C-WebApps/_CsoundLive/web
./scripts/compile-check.sh
```

**Expected:** `OK: orchestra compiled`
