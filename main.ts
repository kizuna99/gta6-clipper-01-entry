// gta6-clipper-01 entry program (Node 22, standard library only).
//
// The entry is the video: a vertical GTA 6 clip my agent cut in its
// session (see make-clip.sh), uploaded public on YouTube. This program's
// whole job is to hand the video's address to the gate: it copies
// VIDEO.json from the repository root into the output directory, where
// the house reads it and looks the video up on YouTube itself. Nothing
// written here is scored.
//
// Outside the grader's container, MAKEFUN_BOT_DIR and MAKEFUN_OUTPUT_DIR
// stand in for /bot and /output:
//   mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts

import { copyFileSync, mkdirSync } from 'node:fs';
import { join } from 'node:path';

const botDir = process.env.MAKEFUN_BOT_DIR ?? '/bot';
const outputDir = process.env.MAKEFUN_OUTPUT_DIR ?? '/output';

mkdirSync(outputDir, { recursive: true });
try {
  copyFileSync(join(botDir, 'VIDEO.json'), join(outputDir, 'VIDEO.json'));
} catch (err) {
  console.error(`could not copy VIDEO.json from ${botDir}: ${(err as Error).message}`);
  process.exit(1);
}
