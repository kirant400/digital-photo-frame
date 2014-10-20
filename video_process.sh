#!/bin/bash
x=$( mplayer -really-quiet -vo dummy -ao dummy -identify $1 | grep ID_LENGTH | sed 's:ID_LENGTH=::')
if [[ -n "$x" ]]; then
  y=${x%.*}
  z=$((y / 2))
  za=$((z + 1))
  a=$1
  xpath=${a%/*} 
  xbase=${a##*/}
  xfext=${xbase##*.}
  xpref=${xbase%.*}
  xout='dsnap_'"$xpref"'.'"$xfext"'___'
  xoutpath="$xpath"'/'"$xout"'.png'
  vlc $1 --rate=1 --video-filter=scene --vout=dummy --aout=dummy --start-time=${z} --stop-time=${za} --scene-replace --scene-format=png --scene-ratio=20 --scene-prefix=${xout} --scene-path=${xpath} vlc://quit
  composite \( /home/lubuntu/Dropbox/play.png -resize 50% \) ${xoutpath}   -gravity center   ${xoutpath}
  width=`identify -format %w ${xoutpath}`; 
  convert -background '#0008' -fill white -gravity center -size ${width}x30 caption:"${xpref}" ${xoutpath} +swap -gravity south -composite  ${xoutpath}
fi
