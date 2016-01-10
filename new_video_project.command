#! /bin/bash

# Creates a Mac sparsebundle with directories for video project organization

read -p "Enter name of sparsebundle image: " IMAGE
read -p "Enter the initial size of sparsebundle (ex. 200m, 20g): " SIZE
read -p "Enter name of your editor (Premiere, FCPX, etc.): " NLE
read -p "Enter motion graphics application (After Effects, Motion, etc): " MG
read -p "Enter audio application (Audition, etc): " AUDIO
read -p "Enter coloring application (Resolve, Speed Grade, etc): " COLOR
read -p "Are you using proxy footage? (y or n): " PROXY

hdiutil create -type SPARSEBUNDLE -size $SIZE -fs HFS+ -volname $IMAGE $IMAGE
hdiutil attach $IMAGE.sparsebundle

CURR_LOC="$(pwd)"

cd /Volumes/$IMAGE
if [[ -z "$NLE" ]];then mkdir premiere; else mkdir $(echo $NLE | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [[ -z "$MG" ]];then mkdir after_effects; else mkdir $(echo $MG | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [[ -z "$COLOR" ]];then mkdir resolve; else mkdir $(echo $COLOR | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [[ -z "$AUDIO" ]];then mkdir audition; else mkdir $(echo $AUDIO | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
mkdir raw
cd raw
mkdir video
mkdir audio
mkdir photo
if [[ "$PROXY" == "y" ]];then
cd video
mkdir source
mkdir proxy
fi
mv $CURR_LOC/$IMAGE.sparsebundle $CURR_LOC/Desktop