# Agent brief — paste into fresh Cursor chat

Copy the block below (edit `[user priorities]`):

---

```
Read ~/Dr.C-Workshop-Demo/handoff.md, University-resume.md, FINAL-TEST-PLAN.md. Execute FINAL-TEST-PLAN in order. Focus: [user priorities — e.g. web app clobber regression on Mac, then VM npm test]. Do not re-provision VM unless broken (multipass list / xrdp dead). On-stage GUI is Dr.C Mac Standalone only — not RDP on projector.

Environment: Mac with ~/Dr.C-Standalone (lac-2026-csound7 @ 0cd5d22+), Multipass VM lac-2026-linux (ubuntu/ubuntu, ~192.168.252.7). VM tests need NODE_OPTIONS=--max-old-space-size=4096. Never run Dr.C from /mnt in VM — use ~/Dr.C-Standalone with Linux npm install.
```

---

## Default priorities (if unspecified)

1. Web app convert regression (FINAL-TEST-PLAN §A5) after `git pull`
2. Mac `npm test`
3. `node scripts/test-cabbage-export.mjs`
4. VM `npm test` + `DRC_DRY_RUN=1` via `multipass shell`
5. RDP desktop icon only if time

## Do not

- Re-run `linux-vm-provision.sh` unless CS7/Node missing
- Commit Workshop-Demo files unless Richard asks
- Treat apt `csound` 6.17 as workshop pass on Ubuntu 22.04
