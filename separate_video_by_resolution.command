#! /bin/bash

# Separates footage into folders based on resolution size

read -p "Drag folder containing videos and press ENTER: " FILES

# Make sure a directory is provided
if [ -z "$FILES" ]; then
  echo "No folder provided. Please close and try again."
  exit
# Make sure it's a directory and not a single file
elif [ -f "$FILES" ]; then
  echo "Please use a directory, not a single file"
  exit
else
  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")

  for f in $FILES/*
  do
    # Using mediainfo to get Height of video
    MED_INFO_HEIGHT=$(mediainfo $f | grep "Height")

    # Make sure it's a video file
    if [ -f "$f" ] && [ ! -z "$MED_INFO_HEIGHT" ]; then
      echo "Processing $f"

      # Rename file and replace spaces with underscores
      FILE=$(echo $f | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
      mv $f $FILE

      # Setting Height value to var
      HEIGHT=$(echo $MED_INFO_HEIGHT | tr -d '[[:space:]]' | egrep -o '[[:digit:]]' | tr -d '[[:space:]]')

      # Create directory based on Height value if it doesn't exist yet
      if [ ! -d "$FILES/$HEIGHT" ]; then
        mkdir $FILES/$HEIGHT
      fi

      # Move file into directory with its Height
      mv $FILE $FILES/$HEIGHT
    fi
  done
  IFS=$SAVEIFS
fi

