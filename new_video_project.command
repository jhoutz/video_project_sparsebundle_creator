#! /bin/bash

# Creates a Mac sparsebundle with directories for video project organization

read -p "Type the name of your project and press ENTER: " IMAGE
read -p "Type the initial size of your disk image and press ENTER (ex. 200m, 20g): " SIZE
read -p "Type the name of your video editor and press ENTER (Premiere, FCPX, etc.): " NLE
read -p "Type the name of your motion graphics application and press ENTER (After Effects, Motion, etc): " MG
read -p "Type the name of your audio application and press ENTER (Audition, etc): " AUDIO
read -p "Type the name of your coloring application and press ENTER (Resolve, Speed Grade, etc): " COLOR
read -p "Are you using proxy footage? (y or n) Press ENTER: " PROXY

# Lowercase sparsebundle disk image name and replace spaces with underscores
# Default name = "video_project"
[ -n "$IMAGE" ] || IMAGE="video_project"
IMAGE=$(echo $IMAGE | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# Create the sparsebundle disk image
# Default size = "1g"
if [ -z "$SIZE" ]; then SIZE="1g";fi
hdiutil create -type SPARSEBUNDLE -size $SIZE -fs HFS+ -volname $IMAGE $IMAGE

# Mount the sparsebundle disk image
hdiutil attach $IMAGE.sparsebundle

# Set current directory to var
CURR_LOC="$(pwd)"

# Navigate to sparsebundle disk image
cd /Volumes/$IMAGE

# Set defaults
[ -n "$NLE" ] || NLE="premiere" #default NLE is premiere
[ -n "$MG" ] || MG="after_effects" #default motion graphics is after_effects
[ -n "$AUDIO" ] || AUDIO="audition" #default audio application is audition
[ -n "$COLOR" ] || COLOR="resolve" #default coloring application is resolve


# Create directories based on user input
mkdir $(echo $NLE | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
mkdir $(echo $MG | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
mkdir $(echo $AUDIO | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
mkdir $(echo $COLOR | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# Create renders directory in NLE directory
cd $NLE
mkdir renders
cd ..

# Create renders directory in motion graphics directory
cd $MG
mkdir renders
cd ..

# Create renders directory in audio applicaiton directory
cd $AUDIO
mkdir foley
mkdir music
mkdir dual_system
cd ..

# Create renders directory in color applicaiton directory
cd $COLOR
mkdir renders
cd ..

# Create raw directory
mkdir raw

# Navigate into raw directory
cd raw

# Create raw subdirectories
mkdir video
mkdir audio
mkdir photo

# Navigate into video directory if proxy media is used 
# Default is "n"
if [[ "$PROXY" == "y" ]];then
  cd video
  mkdir source
  mkdir proxy
fi

# Move sparsebundle disk image to the desktop
mv $CURR_LOC/$IMAGE.sparsebundle $CURR_LOC/Desktop