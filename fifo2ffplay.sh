#!/data/data/com.termux/files/usr/bin/bash
# 2. Run FFmpeg (run in background or separate termux session
ffmpeg -hide_banner -loglevel error -f s16le -ar 44100 -ac 2 -i ~/mpd.fifo \
       -i /storage/emulated/0/dearvr.wav \
       -filter_complex "[0:a][1:a]afir=dry=1:wet=1[out]" \
       -map "[out]" -f wav - | \
ffplay -nodisp -af "aresample,aformat=channel_layouts=stereo,equalizer=f=100:width_type=h:width=50:g=8,bs2b=fcut=650:feed=9.5,volume=25.0,sofalizer=sofa='/storage/emulated/0/ClubFritz1.sofa'" -fflags nobuffer -flags low_delay -i - >/dev/null 2>&1 &
#!/bin/bash
# Script to monitor mpd and resume playback if it stops

while true; do
    # Check if mpd is running
check_mpd_state() {
    # Get the full status and check for 'paused' or 'stopped'
    STATUS=$(mpc status 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "Error: Could not connect to MPD. Is it running?"
        exit 1
    fi

    if echo "$STATUS" | grep -q "paused"; then
        # echo "MPD is paused."
        mpc play
    elif echo "$STATUS" | grep -q "stopped"; then
        # echo "MPD is stopped."
        mpd &
        mpc play
        # Add your commands here for the playing state
    fi
}

# Execute the function
check_mpd_state
    # Wait for 5 seconds
    sleep 5
done







