+++
title = "Nushell script for opening Youtube videos with MPV"
date = 2024-03-05
authors = ["Soc Virnyl Estela"]
+++

```nu
#!/usr/bin/nu
alias MENU = fuzzel -d

let subbed_channels = [ 
  
 chrisbiscardi
 Coderized
 CodeAesthetic
 dreamsofcode
 fasterthanlime
 fireship
 fknight
 freecodecamp
 LearnLinuxTV
 LowLevelLearning
 niccoloveslinux 
 NoBoilerplate
 _noisecode
 RustVideos
 VideosByDefault
 ThePrimeTimeagen
 TraversyMedia

]

let channel = ($subbed_channels | to text | MENU -p "choose channel>" | str trim)
if ($channel | is-empty) {
 exit 0
}
if $channel not-in $subbed_channels {
  notify-send --icon dialog-error --app-name Error -u critical "Not in the list" $"($channel) channel is not in the list of your subs!"
  exit 1
}
let titles = (http get $"(http get $"https://www.youtube.com/@($channel | to text | str trim)" | query web -q 'link' -a href | find feeds | get 0 | ansi strip)" --raw | query web -q 'title')
let channel_title = ($titles | get 0)
let video_titles = ($titles | skip 1)
let chosen_video_title = ($titles | to text | MENU -p 'open link to>' | str trim)
if ($chosen_video_title | is-empty) {
 exit 0
}
let video_hashes = (http get $"(http get $"https://www.youtube.com/@($channel | str trim)" | query web -q 'link' -a href | find feeds | get 0 | ansi strip)" --raw | query web -q 'yt\:videoId')
for $video_title in $video_titles --numbered {
 if $chosen_video_title == $channel_title {
  notify-send --icon firefox --app-name firefox $"Opening Youtube channel - ($channel_title) - in default browser"
  setsid /bin/sh -c $"xdg-open 'https://youtube.com/@($channel)'"
  sleep 0.3sec
  exit 0
 }
 if ($chosen_video_title in $video_titles) and ($chosen_video_title in $video_title.item) {
  notify-send --icon mpv --app-name mpv $"Opening '($video_title.item)' in mpv"
  let ytflags = "(mp4,webm)[height<?1080]+bestaudio/best"  
  setsid /bin/sh -c $'mpv --slang=en --ytdl-raw-options=ignore-config=,sub-lang=en,write-auto-sub= --ytdl-format="($ytflags)" --no-fs "https://youtube.com/watch?v=($video_hashes | get $video_title.index)"'
  sleep 0.3sec
  exit 0
 }
}
```
