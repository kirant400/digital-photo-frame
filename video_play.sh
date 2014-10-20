#!/bin/bash
echo $1
a=$1
xpath=${a%/*} 
xbase=${a##*/}
xfext=${xbase##*.}
xpref=${xbase%.*}
if [[ $xpref == dsnap_*___ ]]
then
xfilename=${xpref#dsnap_}
xfilename=${xfilename%___}
vlc ${xpath}/${xfilename} -f vlc://quit
fi
