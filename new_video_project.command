#! /bin/bash

# Creates a Mac sparsebundle with directories for video project organization

read -p "Enter name of sparsebundle image: " IMAGE
read -p "Enter the initial size of sparsebundle (ex. 200m, 20g): " SIZE
read -p "Enter name of your editor (Premiere, FCPX, etc.): " NLE
read -p "Enter motion graphics application (After Effects, Motion, etc): " MG
read -p "Enter audio application (Audition, etc): " AUDIO
read -p "Enter coloring application (Resolve, Speed Grade, etc): " COLOR
read -p "Are you using proxy footage? (y or n): " PROXY

# Lowercase sparsebundle disk image name and replace spaces with underscores
# Default name = "video_project"
if [ -z "$SIZE" ]; then SIZE="video_project";fi
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

# Make directories based on user input
if [[ -z "$NLE" ]];then mkdir premiere; else mkdir $(echo $NLE | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [[ -z "$MG" ]];then mkdir after_effects; else mkdir $(echo $MG | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [[ -z "$COLOR" ]];then mkdir resolve; else mkdir $(echo $COLOR | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [[ -z "$AUDIO" ]];then mkdir audition; else mkdir $(echo $AUDIO | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi

# Make raw directory
mkdir raw

# Navigate into raw directory
cd raw

# Make raw subdirectories
mkdir video
mkdir audio
mkdir photo

# Navigate into video directory if proxy media is used 
if [[ "$PROXY" == "y" ]];then
  cd video
  mkdir source
  mkdir proxy
fi

# Move sparsebundle disk image to the desktop
mv $CURR_LOC/$IMAGE.sparsebundle $CURR_LOC/Desktop