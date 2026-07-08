#  🪩 FIRST_PARTY.md hold the first block party

Nobody has done this yet as a community act. This checklist gets you there
in one evening.

## Before (the host, ~1 hour, alone)

- [ ] Pick the host machine (most RAM/GPU in the room) and run
      `scripts/host.sh` once **in advance** the first model download is
      several GB and guests shouldn't watch a progress bar.
- [ ] Confirm the console loads at `http://localhost:3131`.
- [ ] Run `mesh-llm doctor` and clear anything its fussy about.
- [ ] Whiteboard + marker for the invite token. Good eats.

## During (everyone, ~1 hour)

- [ ] Host starts `scripts/host.sh`; write the invite token on the board.
- [ ] Each guest runs `scripts/join.sh <TOKEN>` (low-spec laptops can join
      as clients: `mesh-llm client --join <TOKEN>`).
- [ ] Open the console on any machine and watch the peers appear.
      **Photograph the screen and the room.** This is the artifact.
- [ ] Run `scripts/librarian.sh` on one machine. Have the youngest person
      present ask it the first question.
- [ ] Ambitious rooms: try a split model (`--split`) that no single machine
      could hold. If it works, you've done something collectively that was
      individually impossible. Say that out loud at the party for good measure.

## After (10 minutes)

- [ ] Open an issue on this repo titled **"Party report: <your town>"**:
      how many machines, what hardware, what model, what broke, one photo
      if you're comfortable sharing.
- [ ] Report any Mesh bugs upstream with the command you ran, your
      platform, and `/api/status` output the maintainers ask for exactly
      that.
- [ ] Tell one other community about it. A library. A school. A co-op.

## House rules

The invite token is the key to your village so share it in the room, not
online. Keep the mesh private unless everyone agrees to `--publish`. Don't
put secrets on the blackboard feature in public meshes. Be kind to the
upstream maintainers; this is young software being used for something new.
