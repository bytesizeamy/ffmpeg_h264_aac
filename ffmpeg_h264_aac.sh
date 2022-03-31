#!/bin/bash

input=$1
output=${input//mkv/mp4}
SECONDS=0

args=(
    -hide_banner        #minimal output
    -loglevel 0
    -stats
    -i "$input"
    -c:v libx264        #video settings
    -level 4.1
    -preset veryslow
    -crf 24
    -vsync vfr
    -tune grain
    -c:a aac            #audio settings
    -b:a 192k           
    # -c:s vobsub         #ffmpeg doesn't like bitmap subtitle files apparently
    "$output"
)

echo -e "Input file: $input\nOutput file: $output\n"

ffmpeg "${args[@]}"

HH=$(( SECONDS/3600 )); MM=$(( (SECONDS-HH*3600)/60 )); SS=$(( SECONDS-HH*3600-MM*60 ))
printf "Total processing time: %d:%02d:%02d\n" $HH $MM $SS