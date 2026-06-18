# University Resume — LAC 2026 Csound 7 Workshop

**Richard Boulanger · start here · ~5 minutes to green**

Full context: `handoff.md` · Tests: `FINAL-TEST-PLAN.md`

---

## 5-minute setup checklist

```bash
# 1. VM running?
multipass start lac-2026-linux 2>/dev/null; multipass list

# 2. Pull latest (test against 0cd5d22+ on Standalone)
cd ~/Dr.C-Standalone && git fetch && git checkout lac-2026-csound7 && git pull
cd ~/Dr.C && git pull
cd ~/Dr.C-URLS && git pull

# 3. Mac PATH + versions
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
csound --version | head -1
node -v

# 4. Mac automated gate
cd ~/Dr.C-Standalone && npm test

# 5. Windows App installed? (for Linux desktop demo only)
ls "/Applications/Windows App.app" "/Applications/Microsoft Remote Desktop.app" 2>/dev/null
# If Windows App crashes on open:
# ~/Dr.C-Standalone/scripts/reset-windows-app-rdp-state.sh --execute
```

| Check | Pass? |
|-------|-------|
| `multipass list` → `lac-2026-linux` **Running** | ☐ |
| `git -C ~/Dr.C-Standalone rev-parse --short HEAD` ≥ `0cd5d22` | ☐ |
| Mac `npm test` → 126 smoke + build OK | ☐ |
| **Dr.C Mac Standalone** opens from Desktop | ☐ |

---

## Priority test order (this session)

1. **Mac Standalone** — FM bell, Player, **web app convert regression** (highest risk)
2. **Mac `npm test`** — already in checklist
3. **Cabbage export** — `node scripts/test-cabbage-export.mjs`
4. **Mac Terminal** — quick TUI smoke
5. **Linux VM shell** — `npm test` + `DRC_DRY_RUN=1`
6. **Linux RDP desktop** — icon launch (if time)

---

## Copy-paste commands

### Mac Standalone (on-stage)

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
~/Dr.C-Standalone/scripts/launch-drc.sh
# or double-click: Dr.C Mac Standalone
```

### Mac Terminal

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$HOME/.bun/bin:$PATH"
cd ~/Dr.C/opencode && bun run dev -- ~/Dr.C-Workshop-Demo
# or double-click: Dr.C Mac Terminal
```

### Linux VM shell

```bash
~/Dr.C-Standalone/scripts/launch-linux-vm.sh
# inside VM:
export PATH="$HOME/bin:$HOME/Applications/Csound/bin:$HOME/.bun/bin:$PATH"
export NODE_OPTIONS=--max-old-space-size=4096
cd ~/Dr.C-Standalone && npm test
DRC_DRY_RUN=1 ./scripts/launch-drc.sh
```

### Linux RDP desktop

```bash
~/Dr.C-Standalone/scripts/open-linux-desktop.sh
# Windows App → Add PC → 192.168.252.7:3389 → ubuntu / ubuntu
# Double-click "Dr.C Standalone" on VM desktop
# Fallback in VM terminal:
~/bin/drc-standalone-gui.sh
```

### Attendee mode (no API key)

```bash
~/Dr.C-Standalone/scripts/launch-workshop-attendee.sh
```

### Cabbage headless test

```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
cd ~/Dr.C-Standalone && node scripts/test-cabbage-export.mjs
```

---

## Presenter cheat sheet

| Demo | Action | No key? |
|------|--------|---------|
| FM bell | Agent → **Load workshop FM bell (no key)** | Yes |
| Player keyboard | Player → Demos → **FM-Bell** | Yes |
| Golden prompt | See `WORKSHOP.md` shimmer bell text | API optional |
| Web app | Artifact → **Convert → Web App** → Preview → **Open in Browser** | CDN needs network |
| Cabbage | Plain CSD → **Convert → Cabbage** | — |
| CsoundQt | Artifact → **Open in CsoundQt** | — |
| Linux story | Mac: explain VM; optional RDP on side screen | — |
| Attendees | Point to `PARTICIPANTS.md` + **Dr.C-Attendee** launcher | Yes |

**Workshop prompts (paste in Agent):**

```
make a plain Csound CSD only — no Cabbage. Shimmering FM bell like the workshop golden model: two inharmonic oscili modulators into a carrier, expsegr decay, global reverb bus (instr 99). Score: descending bell melody, harmonic cluster, final low bell (~15 s).
```

**If Agent throttled:** wait for countdown, or use Ollama, or attendee/offline path.

**If web app silent in browser:** click **Start Audio**; check network for WASM CDN.

**If RDP drops:** `multipass shell lac-2026-linux` — Mac Standalone still works on stage.

---

## What "done" looks like before workshop

| Gate | Criterion |
|------|-----------|
| Mac automated | `cd ~/Dr.C-Standalone && npm test` — **pass** |
| Mac manual A | Attendee path: FM bell load, Player demo, Web Apps tab — **pass** |
| Mac manual B | Web app convert **stays** on Preview 5–10 s; follow-up does not revert to CSD — **pass** |
| Cabbage | `test-cabbage-export.mjs` — **pass** (or Cabbage installed + manual open) |
| VM automated | Inside VM: `NODE_OPTIONS=--max-old-space-size=4096 npm test` — **pass** |
| Stage plan | Projector = **Dr.C Mac Standalone**; Linux = backup/demo |
| USB / links | `~/Dr.C-Workshop-Demo` + `~/Dr.C-URLS/INSTALL-*.md` ready |

Fill test log in `FINAL-TEST-PLAN.md` §E before leaving for venue.
