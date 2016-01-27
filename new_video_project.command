#! /bin/bash

# Creates a Mac sparsebundle with directories for video project organization

parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

BASEDIR=$(dirname $0)
cd $BASEDIR
eval $(parse_yaml settings.yml "config_")

# Reading settings values from settings.yml
if [ -z "$NLE" ];then NLE=$(echo $config_settings_editor | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [ -z "$MG" ];then MG=$(echo $config_settings_motion_graphics | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [ -z "$AUDIO" ];then AUDIO=$(echo $config_settings_audio | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
if [ -z "$COLOR" ];then COLOR=$(echo $config_settings_coloring | tr '[:upper:]' '[:lower:]' | tr ' ' '_');fi
PROXY=$(echo $config_settings_create_proxy_folders | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# A li'l welcome and thank you. :)
printf "\n\n"
echo "Thanks for downloading this script! Hopefully it makes your life a little easier!"
echo "For more information about me, visit http://justinhoutz.com"
echo "Or email me at justin@justinhoutz.com"
printf "\n\n"

read -p "Type the name of your project and press ENTER: " IMAGE
read -p "Type the initial size of your disk image and press ENTER (ex. 200m, 20g): " SIZE

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

# Create directories based on user input
if [ ! -z "$NLE" ]; then
  mkdir $NLE
  cd $NLE
  # Create renders directory in NLE directory
  mkdir render
  cd ..
fi

if [ ! -z "$MG" ]; then
  mkdir $MG
  cd $MG
  # Create renders directory in MG directory
  mkdir render
  cd ..
fi

if [ ! -z "$COLOR" ]; then
  mkdir $COLOR
  cd $COLOR
  # Create renders directory in COLOR directory
  mkdir render
  cd ..
fi

if [ ! -z "$AUDIO" ]; then
  mkdir $AUDIO
fi



# Create raw directory
mkdir raw

# Navigate into raw directory
cd raw

# Create raw subdirectories
mkdir video
mkdir audio
cd audio
mkdir foley
mkdir music
mkdir dual_system
cd ..
mkdir photo

# Create source and proxy folders
if [[ "$PROXY" == true ]];then
  cd video
  mkdir _source
  mkdir _proxy
fi

# Move sparsebundle disk image to the desktop
mv $CURR_LOC/$IMAGE.sparsebundle ~/Desktop