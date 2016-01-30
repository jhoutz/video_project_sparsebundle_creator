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

create_program_directories() {
   mkdir $1
   cd $1
   # Create renders directory if render == true
   if [ $2 == true ];then
      mkdir renders
      cd ..
   fi
}

create_full_production_directories() {
  mkdir pre_production
  cd pre_production
  mkdir scripts
  mkdir schedules
  mkdir locations
  mkdir talent
  mkdir expenses
  cd ..
  mkdir production
  cd production
  mkdir shot_lists
  cd ..
  mkdir post_production
}

create_raw_directories() {
   
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
}