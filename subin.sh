for i in *.mp4 ; do  ep=" $(echo $i|cut -d "." -f 1)";ffmpeg -i "$ep.mp4" -i "$ep.enUS.ass" -c copy -c:s mov_text "$ep.subs.mp4"; done
