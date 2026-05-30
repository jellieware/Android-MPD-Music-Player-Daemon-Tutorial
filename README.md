# Android-MPD-Music-Player-Daemon-Tutorial
A very nice music player setup for Android (432HZ) + Binaural + Convolver


![logo](https://github.com/user-attachments/assets/34efb8ec-2197-4a72-9b31-e8d6aef3db1c)


Requirements:

*   Android
*   Internet Connection
*   Termux
*   MPD (Music Player Daemon)
*   MPC (Music Player Client)
*   ffmpeg + ffplay
*   Optional: Revanced Manager Patch (Remove screen capture restriction) to make it compatible with "rootlessjamesdsp"
*   A virtual keyboard: "HackersKB" or "UnexpectedKB"
*   Mafa GUI/Client (free) (No Longer Available at the PlayStore) https://mafa.indi.software/
*   Some easy code editing necessary...

  
Steps:

*   Install Termux Latest on Android from "Fdroid" or "Github"
*   Open Termux App (Allow all permissions)

  
Commands (Without Quotes):

*   "apt-get update"
*   "termux-setup-storage"
*   "apt-get install mpd"
*   "apt-get install mpc"
*   "apt-get install ffmpeg"
*   "apt-get install ffplay"
*   "cd ~/"
*   "cd .."
*   "cd usr"
*   "cd etc"
*   "nano mpd.conf"

  
Editing "mpd.conf"

*   Download my edited version (but dont forget to change dir paths to match those of your phone), Change as necessary. Mine has 432HZ enabled for fifo and access to all networks...
*   mpd.conf (some settings example):<br><br>
```
# For network
bind_to_address		"0.0.0.0"

# This setting is the TCP port that is desired for the daemon to get assigned
# to. Normally this is 6600 but for termux this port needs to be above 8000.

port				"8600"

audio_output {
  type            "fifo"
  name            "FFmpeg Convolution Pipe"
  path            "~/mpd.fifo"
  enabled         "yes"
  filters         "432hz"
}
filter {
  plugin "ffmpeg"
  name   "432hz"
  graph  "rubberband=pitch=0.981818"
}
```
<br><br>
*   When done editing your "mpd.conf" type "ctrl-x", "y", "ctrl-m" on your virtual keyboard.
<br><br>
  
MAFA Setup

*   Open mafa
*   Add your server (After typing: "mpd" in Termux window) IP:0.0.0.0 Port:8600
*   If you have successfuly added the correct directory paths for your playlists/music collection in "mpd.conf" it will show up in the Mafa client. it might take some time to show everything depending on how much music data you have.

* Finally use my bash script (fifo2ffplay.sh) and choose an impulse response (irs/wav) and sofa hrtf (sofa) file
* fifo2ffplay.sh uses "dearvr.wav" impulse response (included on this page) and "clubfritz.sofa"
* https://sofacoustics.org/data/database/clubfritz/
* Dont forget to change dir paths to match those of the location of "dearvr.wav" and "sofa" file
* The bash script needs to be running at the same time as mafa/mpd: "bash /yourpath/fifo2ffplay.sh"

```bash
#!/data/data/com.termux/files/usr/bin/bash
#Run FFmpeg (run in background or separate termux session
ffmpeg -hide_banner -loglevel error -f s16le -ar 44100 -ac 2 -i ~/mpd.fifo \
       -i /storage/emulated/0/dearvr.wav \
       -filter_complex "[0:a][1:a]afir=dry=1:wet=1[out]" \
       -map "[out]" -f wav - | \
ffplay -nodisp -af "bs2b=fcut=650:feed=9.5,volume=45.0,sofalizer=sofa='/storage/emulated/0/ClubFritz1.sofa'" -fflags nobuffer -flags low_delay -i - >/dev/null 2>&1 &

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
```
<br><br>
Misc/Other

*   You can even stream what you're listening to in real time to other users on your home network with the correct configuration...
  <br>

  
![left](https://github.com/user-attachments/assets/d29c6769-94cc-472c-909f-7c0e75d21b6b)
![right](https://github.com/user-attachments/assets/88810576-c5f5-464a-bf9c-ab585e7aa989)


