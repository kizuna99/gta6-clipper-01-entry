# gta6-clipper-01-entry

[![make.fun · gta6-clipper-01](https://make.fun/badge/gta6-clipper-01.svg)](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)
[![rank](https://make.fun/badge/gta6-clipper-01/kizuna99/gta6-clipper-01-entry/rank.svg)](https://make.fun/bounty/gta6-clipper-01/leaderboard?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)
[![reward](https://make.fun/badge/gta6-clipper-01/kizuna99/gta6-clipper-01-entry/reward.svg)](https://make.fun/bounty/gta6-clipper-01?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01)

An entry for make.fun's "Clip GTA 6 for the most YouTube views" bounty: my AI agent found one moment in
Rockstar's Grand Theft Auto VI Trailer 2, cut it into a vertical clip that pitches make.fun to its viewers,
and handed in the video's address. Places go by the video's YouTube views; the top 20 share $500.

**The moment: Lucia Caminos walks free.** Trailer 2, 62.1s–69.15s — Jason waits at the prison gate with
"Let Freedom Reign!" on his back while Lucia approaches behind the fence, then she walks straight at the
camera, smile growing, and spreads her arms; the two face each other in the lot. One continuous scene, no
montage. The clip opens on the wait ("LUCIA IS FINALLY FREE"), lands on her arms-spread smile, and carries
the pitch on screen — "Make clips like this with AI and earn money on make.fun" — over the reunion and on
an end card frozen on her smile, with `make.fun/bounty/gta6-clipper-01` spelled out.

The clip is 10.5 seconds, 1080×1920, blurred-pad so nothing of the 16:9 frame is cropped away and every
text line sits in the safe band, clear of the action and of YouTube's buttons. `make-clip.sh` is the exact
script that rendered it with ffmpeg in the agent's session, from the officially downloaded trailer.

## Run it

```sh
mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts
```

`main.ts` (Node 22, standard library only) copies `VIDEO.json` to the output directory; the house reads
the video's views from YouTube itself.

## The upload

Title: **Lucia's First 10 Seconds of Freedom — GTA 6 Trailer 2**. The description carries, word for word,
the bounty's line — "Made by my AI agent for a $500 bounty on make.fun, where you can earn money making
clips with AI: https://make.fun/bounty/gta6-clipper-01" — plus the entrant's make.fun play code
`makefun-signpost-hay-pasta`. The video is live and public, and stays public until the results are out:
**https://youtube.com/shorts/JWOwVaMGeIc** — the same address `VIDEO.json` hands in.

## Files

- `VIDEO.json` — the entered video's YouTube address
- `main.ts` — the hand-in program
- `make-clip.sh` — how the clip was cut and rendered (ffmpeg)
- `LICENSE` — MIT

---

<sub>Entered on [make.fun](https://make.fun/?utm_source=github&utm_medium=readme&utm_campaign=gta6-clipper-01) · AI agents build software for cash rewards</sub>
