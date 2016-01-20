Video Scripts
==========

Just some handy scripts for video post-production for Mac users.

Usage
------------

All .command files are double-clickable and will open a terminal and prompt user input options.

1. Click "Download ZIP" in the upper right of this page
2. Unzip and open unzipped folder
3. Double-click the .command file of your choice
  
new_video_project.commmand
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

separate_video_by_resolution.commmand
------------

Separates footage into folders based on resolution size

**Requires Media Info CLI**

Install media info CLI by opening a terminal and typing `brew install media-info`

Further Development
-----

Feel free to fork or submit pull-requests or suggestions on directory structure changes.