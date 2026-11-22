#!/bin/sh
# make-clip.sh - renders the gta6-clipper-01 entry clip. Run from the build
# directory (the parent of entry/):  sh entry/make-clip.sh
#
# Source: Grand Theft Auto VI Trailer 2, Rockstar Games (official YouTube
# upload VQRLujxTm3c, downloaded in-session with yt-dlp to src/trailer2.mp4).
#
# THE MOMENT (one continuous scene, no montage): Lucia Caminos walks free.
# Source 62.1s -> 69.15s, frame-checked at 0.25s steps: Jason's back at
# the gate ("Let Freedom Reign!") with Lucia approaching behind it
# (62.1-63.0, the "wait for it" build), CUT to Lucia walking straight at
# camera, smile growing, arms spread wide at ~65.75 (63.0-66.25, the
# payoff), CUT to the two-shot as they face each other in the lot
# (66.25-69.15). The scene fades to black at ~69.3 for the "Rockstar
# Games Presents" title, so the cut ends at 69.15. One event in real-time
# continuity - chosen over the 1.6s motorcycle/seaplane beat (too short
# to carry the mandatory readable pitch) and the 8.7s counter dialogue
# (one take, but visually static). Rev 2: v1 ran to 72.3s and swallowed
# 3s of the black title fade; boundaries and text timings fixed from
# frame checks of the v1 render.
#
# Layout: blurred-pad vertical. The 16:9 frame is scaled whole to
# 1080x607 over a blurred copy of itself stretched to 1080x1920, so no
# part of the moment is cropped away and the text bands sit in the blur,
# clear of the action and of YouTube's bottom/right UI.
#
# Text (DejaVu Sans Bold, white with black border):
#   hook   0.2-2.6s  "LUCIA IS FINALLY FREE"            (top band)
#   pitch  4.3-7.05s "Make clips like this with AI"     (lower band)
#                    "and earn money on make.fun"
#   card   7.05-10.45s freeze of Lucia's arms-spread smile (source
#                    65.75s), darkened:
#                    "MAKE CLIPS LIKE THIS WITH AI"
#                    "EARN MONEY ON make.fun"
#                    "make.fun/bounty/gta6-clipper-01"
# Audio: the trailer's own track, faded out at the moment's end.
# Rev 3: the v2 end card crushed to a red silhouette (eq -0.30 on the
# PNG-sourced frame is far stronger than on the trailer's YUV) and its
# first line overflowed the frame at fontsize 62; gentler dimming and
# smaller card type, both verified on test frames before this render.

set -eu
cd "$(dirname "$0")/.."

SRC=src/trailer2.mp4
FONT=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
START=62.1
DUR=7.05
CARD_AT=65.75
CARD_DUR=3.4

# --- segment 1: the moment, blurred-pad, hook + pitch over it -------------
ffmpeg -y -v error -ss $START -i "$SRC" -t $DUR -filter_complex "
[0:v]split=2[bg][fg];
[bg]scale=1080:1920,gblur=sigma=40,eq=brightness=-0.05[bgv];
[fg]scale=1080:607[fgs];
[bgv][fgs]overlay=0:656,
drawtext=fontfile=$FONT:text='LUCIA IS FINALLY FREE':fontsize=66:fontcolor=white:borderw=4:bordercolor=black:x=(w-text_w)/2:y=290:enable='between(t,0.2,2.6)',
drawtext=fontfile=$FONT:text='Make clips like this with AI':fontsize=58:fontcolor=white:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1330:enable='between(t,4.3,7.05)',
drawtext=fontfile=$FONT:text='and earn money on make.fun':fontsize=58:fontcolor=white:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1410:enable='between(t,4.3,7.05)'
[v];
[0:a]atrim=0:$DUR,asetpts=PTS-STARTPTS,afade=t=out:st=6.3:d=0.75[a]
" -map "[v]" -map "[a]" -c:v libx264 -preset medium -crf 19 -pix_fmt yuv420p \
  -c:a aac -b:a 160k -r 30 -video_track_timescale 15360 seg1.mp4

# --- segment 2: end card on the frozen smile frame ------------------------
ffmpeg -y -v error -ss $CARD_AT -i "$SRC" -frames:v 1 card_frame.png
ffmpeg -y -v error -loop 1 -i card_frame.png -f lavfi -i anullsrc=r=44100:cl=stereo \
  -t $CARD_DUR -filter_complex "
[0:v]split=2[bg][fg];
[bg]scale=1080:1920,gblur=sigma=40,eq=brightness=-0.12[bgv];
[fg]scale=1080:607,eq=brightness=-0.05[fgs];
[bgv][fgs]overlay=0:656,
drawtext=fontfile=$FONT:text='MAKE CLIPS LIKE THIS WITH AI':fontsize=52:fontcolor=white:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1240,
drawtext=fontfile=$FONT:text='EARN MONEY ON make.fun':fontsize=56:fontcolor=white:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1330,
drawtext=fontfile=$FONT:text='make.fun/bounty/gta6-clipper-01':fontsize=50:fontcolor=white:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1445
[v]" -map "[v]" -map 1:a -c:v libx264 -preset medium -crf 19 -pix_fmt yuv420p \
  -c:a aac -b:a 160k -r 30 -video_track_timescale 15360 seg2.mp4

# --- join ------------------------------------------------------------------
printf "file 'seg1.mp4'\nfile 'seg2.mp4'\n" > concat.txt
ffmpeg -y -v error -f concat -safe 0 -i concat.txt \
  -c:v libx264 -preset medium -crf 19 -pix_fmt yuv420p -c:a aac -b:a 160k \
  -movflags +faststart gta6-clipper.mp4

echo "wrote gta6-clipper.mp4"
