Video Scripts
==========

Just some handy scripts for video post-production for Mac users.

Usage
------------

All .command files are double-clickable and will open a terminal and prompt user input options.

1. Click "Download ZIP" in the upper right of this page
2. Unzip and open unzipped folder
3. Double-click the .command file of your choice

Be sure to check out the [settings.yml](#settings.yml) file for general script settings
  
new_video_project.command
------------

Creates a scalable .sparsebundle disk image with video project folders.

Once the disk image has been created, it will mount and the .sparsebundle file will be moved to the Desktop.

Here is a sample of the video project disk image directory structure.

- [sparsebundle_name]
  - [editor_app_name]
    - render
  - [motion_graphics_app_name]
    - render
  - [audio_app_name]
  - [coloring_app_name]
    - render
  - raw
    - audio
      - dual_system
      - foley
      - music
    - photo
    - video
      - source
      - proxy

video_ingestion.command
------------

Script to automate video footage ingestion process

Options include:

- Moving or copying footage
- Renaming and numbering footage with date and camera name
- Separating footage into folders based on video resolution

(#settings.yml)
------------

The settings.yml file contains settings that will likely remain unchanged each time you use a script. I put them here instead of requiring the user to answer a ton of questions each time.

Settings are fully commented and you can change any of the values to the right of the ":".

For instance, you can change the name of your video editor by changing `editor: Premiere` to `editor: FCPX`...

```yaml
# What is the name of your video editor?
# Options: Premiere, FCPX, Sony Vegas, etc.
editor: Premiere
```

...becomes...

```yaml
# What is the name of your video editor?
# Options: Premiere, FCPX, Sony Vegas, etc.
editor: FCPX
```

System Requirements
-----

**Scripts Require Homebrew and MediaInfo CLI**

[Click here](http://coolestguidesontheplanet.com/installing-homebrew-os-x-yosemite-10-10-package-manager-unix-apps/) and follow the steps to install Homebrew

Next, install MediaInfo by pasting `brew install media-info` in a terminal window and hitting ENTER

Disclaimer
-----

These scripts are an aid to help filmmakers speed up their video project organization process. However, they are in development and therefore need to be used with caution. No guarantee against data loss or corruption is either expressed or implied.

Further Development
-----

Feel free to fork or submit pull-requests or suggestions on directory structure changes.