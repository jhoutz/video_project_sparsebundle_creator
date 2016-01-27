#! /bin/bash

# Automated script for video ingestion and organization

BASEDIR=$(dirname $0)
cd $BASEDIR

. functions.sh

eval $(parse_yaml settings.yml "config_")

# Reading settings values from settings.yml
MOVE_TYPE=$(echo $config_settings_move_type)
# If source volume is /Volumes/* (a.k.a. an SD card) force MOVE_TYPE to "cp"
if [[ $FILES == *"Volumes"* ]]; then MOVE_TYPE="cp";fi

CAMERA_DIR=$(echo $config_settings_move_footage_to_camera_folder)
RES_DIR=$(echo $config_settings_split_footage_by_resolution)
RENAME=$(echo $config_settings_split_footage_by_resolution)
RENAME_PREVIEW=$(echo $config_settings_show_rename_preview)

# A li'l welcome and thank you. :)
printf "\n\n"
echo "Thanks for downloading this script! Hopefully it makes your life a little easier!"
echo "For more information about me, visit http://justinhoutz.com"
echo "Or email me at justin@justinhoutz.com"
printf "\n\n"

read -p "Drag folder containing videos here and press ENTER: " FILES
read -p "Drag destination directory here and press ENTER: " DEST_DIR
read -p "Type in the type camera and ('GH4', 'MarkIII', etc) and press ENTER: " CAMERA
if [ $RENAME == true ];then read -p "Type in datestamp and press ENTER: " DATE; fi;

CAMERA=$(echo $CAMERA | tr ' ' '_')
DATE=$(echo $DATE | tr ' ' '_')

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
  ARR=($FILES/*)

  for ((i=0; i<${#ARR[@]}; i++))
  do
    # Using mediainfo CLI library to get Height of video
    MED_INFO_HEIGHT=$(mediainfo ${ARR[$i]} | grep "Height")

    # Make sure it's a video file
    if [ -f "${ARR[$i]}" ] && [ ! -z "$MED_INFO_HEIGHT" ]; then

      # Accounting for files with spaces
      FILE=$(echo ${ARR[$i]} | tr ' ' '\ ')
      FULL_FILENAME=${ARR[$i]##*/}
      EXT=${FULL_FILENAME#*.}

      # It will rename the file if date and camera are entered
      if [ -n "$DATE" ]; then
        NEW_FILENAME=${DATE}_${CAMERA}_${i}.${EXT}
      else
        NEW_FILENAME=${FILE}
      fi

      # If renaming files, confirm format of filename
      if [ $i == 0 ] && [ "$RENAME" == true ] && [ "$RENAME_PREVIEW" == true ]; then
        read -p "A sample renaming will be \"${NEW_FILENAME}\". Do you wish to continue? (if yes, type 'y' and press ENTER): " CONTINUE
        if [ "$CONTINUE" != "y" ];then echo "Sorry it didn't work out!";exit; fi;
      fi
      
      # Report the file being processed
      echo "Processing ${NEW_FILENAME}..."

      # Setting whether we are moving or copying media (default is "cp")
      if [ $MOVE_TYPE == "move" ];then
        MOVE_TYPE="mv"
      else
        MOVE_TYPE="cp"
      fi

      # If user wants to create folders based on resolution (default is true)
      if [ "$RES_DIR" != false ] && [ "$CAMERA_DIR" != false ] && [ ! -z "$CAMERA" ];then

        # Make camera directory
        if [ ! -d "$DEST_DIR/$CAMERA" ]; then
          mkdir $DEST_DIR/$CAMERA
        fi

        # Setting Height value to var
        HEIGHT=$(echo $MED_INFO_HEIGHT | tr -d '[[:space:]]' | egrep -o '[[:digit:]]' | tr -d '[[:space:]]')

        # If destination directory entered by user, or, default to current directory with video files
        [ -n "$DEST_DIR" ] || DEST_DIR=$FILES

        # Create directory based on Height value if it doesn't exist yet
        if [ "$CAMERA_DIR" != false ] && [ ! -d "$DEST_DIR/$CAMERA/$HEIGHT" ]; then
          mkdir $DEST_DIR/$CAMERA/$HEIGHT
        fi
      elif [ "$RES_DIR" != false ];then

        # Setting Height value to var
        HEIGHT=$(echo $MED_INFO_HEIGHT | tr -d '[[:space:]]' | egrep -o '[[:digit:]]' | tr -d '[[:space:]]')

        # If destination directory entered by user, or, default to current directory with video files
        [ -n "$DEST_DIR" ] || DEST_DIR=$FILES

        # Create directory based on Height value if it doesn't exist yet
        if [ ! -d "$DEST_DIR/$HEIGHT" ]; then
          mkdir $DEST_DIR/$HEIGHT
        fi
      fi

      # If data and camera entered, move or copy renamed files to destination directory
      # otherwise move files but keep original name
      if [ ! -z "$DATE" ] && [ ! -z "$CAMERA" ] && [ "$CAMERA_DIR" != false ];then
        $MOVE_TYPE $FILE ${DEST_DIR}/${CAMERA}/${HEIGHT}/${DATE}_${CAMERA}_${i}.${EXT}
      elif [ ! -z "$DATE" ] && [ ! -z "$CAMERA" ];then
        $MOVE_TYPE $FILE ${DEST_DIR}/${HEIGHT}/${DATE}_${CAMERA}_${i}.${EXT}
      else
        $MOVE_TYPE $FILE $DEST_DIR/$HEIGHT
      fi
    fi
  done
  IFS=$SAVEIFS
fi
