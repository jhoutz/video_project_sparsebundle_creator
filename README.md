Video Project Sparsebundle Creator
==========

Sparsebundles for Mac are a great way to organize and archive video projects. They are scalable and portable allowing for easy project collaboration.

The "new_video_project.commmand" file is a simple, double-clickable bash script for Mac that creates a sparsebundle disk image for video projects. The script also automatically creates video project organization directories based on user input.
  
Usage
------------
  
Pretty simple. Here are the steps:

1. Click "Download ZIP" in the upper right of this page
2. Select destination to download
3. Unzip and open unzipped folder
4. Double-click "new_video_project.command"

The Mac terminal will automatically launch and ask a series of questions. Video project directories will be created in the disc image based on the responses given.

Once the disk image has been created, it will mount and the .sparsebundle file will be moved to the Desktop.

Here is a sample of the sparsebundle directory structure.

- [sparsebundle_name]
  - [editor_app_name]
  - [motion_graphics_app_name]
  - [audio_app_name]
  - [coloring_app_name]
  - raw
    - audio
    - photo
    - video
      - source
      - proxy


Further Development
-----

Feel free to fork or submit pull-requests or suggestions on directory structure changes.