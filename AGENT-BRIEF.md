# Agent brief — paste into fresh Cursor chat

Copy the block below (edit `[user priorities]`):

---

```
Read ~/Dr.C-Workshop-Demo/DAY-1-HANDOFF.md, handoff.md, University-resume.md, FINAL-TEST-PLAN.md. Execute FINAL-TEST-PLAN in order. Focus: [user priorities — e.g. §A5 web app clobber regression, §A2 GUI smoke, then VM npm test]. Do not re-provision VM unless broken (multipass list / xrdp dead). On-stage GUI is Dr.C Mac Standalone only — not RDP on projector.

Environment: Mac with ~/Dr.C-Standalone (lac-2026-csound7 @ 68e0373+), Multipass VM lac-2026-linux (ubuntu/ubuntu, ~192.168.252.7, DISPLAY :10 over RDP). VM tests need NODE_OPTIONS=--max-old-space-size=4096. Never run Dr.C from /mnt in VM — use ~/Dr.C-Standalone with Linux npm install. Linux RDP: prefer Mac-side Launch.command over VM desktop icons.
```

---

## Default priorities (if unspecified)

See `DAY-1-HANDOFF.md` §8 for full pending list. Default order:

1. `git pull` all repos; confirm Standalone ≥ `68e0373`
2. Mac `npm test` (automated gate)
3. Manual GUI: FINAL-TEST-PLAN **§A2** (FM bell, Player) and **§A5** (web app clobber regression)
4. Mac Terminal verify after `68e0373` (stale mount fix)
5. `node scripts/test-cabbage-export.mjs` on Mac (CsoundQt/Cabbage not on VM aarch64)
6. VM `npm test` + `DRC_DRY_RUN=1` via `multipass shell`
7. RDP sound test + Mac-side Launch.command only if time

## Do not

- Re-run `linux-vm-provision.sh` unless CS7/Node missing
- Commit Workshop-Demo files unless Richard asks
- Treat apt `csound` 6.17 as workshop pass on Ubuntu 22.04
