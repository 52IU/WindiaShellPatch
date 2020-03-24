#!/bin/bash
# init
function pause(){
   read -p "$*"
}

inputFile="info"
wget --quiet https://ac.windia.me/patch_info -O $inputFile
nb_lines=$(wc -l $inputFile)
lineCt=${nb_lines%% *}
currentLine=0
while read p; do
	x=1
	fname=""
	fsize=""
	furl=""
	parts=$(echo $p | tr " " "\n")
	for i in $parts
	do
	  if [ $x -eq 1 ]
	  then
		fname="$i"
	  fi
	  
	  if [ $x -eq 2 ]
	  then
		fsize="$i"
	  fi
	   
	  if [ $x -eq 3 ]
	  then
		furl="$i"
	  fi
	  
	let "x++"
	done
	wget --quiet -N $furl
	#echo "wget --quiet -N $furl"
	let "currentLine++"
	echo "[$currentLine/$lineCt] $fname"
	
done <"$inputFile"
rm ./info
pause 'Press [Enter] to exit...'
