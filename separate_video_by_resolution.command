#! /bin/bash

# Separates footage into folders based on resolution size

read -p "Drag folder containing videos: " FILES

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for f in $FILES/*
do
  echo "Processing $f"
  FILE=$(echo $f | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
  mv $f $FILE
  MED_INFO_HEIGHT=$(mediainfo $FILE | grep "Height")
  HEIGHT=$(echo $MED_INFO_HEIGHT | tr -d '[[:space:]]' | egrep -o '[[:digit:]]' | tr -d '[[:space:]]')
  if [ ! -d "$FILES/$HEIGHT" ]; then
    mkdir $FILES/$HEIGHT
  fi
  mv $FILE $FILES/$HEIGHT
done
IFS=$SAVEIFS