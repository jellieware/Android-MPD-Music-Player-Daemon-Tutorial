# Android-MPD-432HZ-Music-Player-Daemon-Tutorial
A very nice music player setup for Android (432HZ) + Binaural + Convolver


![logo](https://github.com/user-attachments/assets/34efb8ec-2197-4a72-9b31-e8d6aef3db1c)


Requirements:

*   Android
*   Internet Connection
*   Termux
*   MPD (Music Player Daemon)
*   MPC (Music Player Client)
*   ffmpeg + ffplay
*   Optional: Revanced Manager Patch (Remove screen capture restriction)
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
*   #Code:<br><br>
    audio_output {<br>
        type            "fifo"<br>
        name            "FFmpeg Convolution Pipe"<br>
        path    "~/mpd.fifo"<br>
        enabled         "yes"<br>
        filters         "432hz"<br>

}<br><br>
filter {<br>
        plugin "ffmpeg"<br>
        name   "432hz"<br>
        graph  "rubberband=pitch=0.981818"<br>
}<br><br>
*   When done editing your "mpd.conf" type "ctrl-x", "y", "ctrl-m" on your virtual keyboard.
<br><br>
*fifo2ffplay uses "dearvr.wav" impulse response (included on this page) and "clubfritz.sofa"
<br><br>
https://sofacoustics.org/data/database/clubfritz/
<br><br>
  
MAFA Setup

*   Open mafa
*   Add your server (After typing: "mpd" in Termux window) IP:0.0.0.0 Port:8600
*   If you have successfuly added the correct directory paths for your playlists/music collection in "mpd.conf" it will show up in the Mafa client. it might take some time to show everything depending on how much music data you have.

* Finally use my bash script (fifo2ffplay.sh) and choose an impulse response (irs)
* The bash script needs to be running at the same time as mafa/mpd
  
Misc/Other

*   You can even stream what you're listening to in real time to other users on your home network with the correct configuration...
  <br>

  
![left](https://github.com/user-attachments/assets/d29c6769-94cc-472c-909f-7c0e75d21b6b)
![right](https://github.com/user-attachments/assets/88810576-c5f5-464a-bf9c-ab585e7aa989)


