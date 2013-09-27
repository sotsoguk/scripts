#!/bin/sh

# TODO
# Rename Panorams
# differentiate "normal" panos and spheres


#defines
RAW_FORMAT=ARW #not implemented yet
VIDEO_FORMAT=mp4
PANO_PREFIX=PANO
PANO_DIR=Panorama
VIDEO_DIR=Videos

PROCESS_PANO=false
PROCESS_VIDEO=false
PROCESS_RAW=true
PROCESS_JPG=true

if $PROCESS_PANO; then
    mkdir $PANO_DIR
    mv $PANO_PREFIX* $PANO_DIR/
fi

if $PROCESS_VIDEO; then
    mkdir $VIDEO_DIR
    mv *.$VIDEO_FORMAT $VIDEO_DIR/
fi

#process jpg files (rename according to date stored in exif-data)
if $PROCESS_JPG; then
    exiftool -d JPG/%Y-%m-%d_%H-%M-%S '-filename<${DateTimeOriginal} (${model}).%e' -ext jpg .
fi

#process raw files (add more extensions for other raw formats by adding "-ext EXTENSION")
if $PROCESS_RAW; then
    exiftool -d RAW/%Y-%m-%d_%H-%M-%S '-filename<${DateTimeOriginal} (${model}).%e' -ext RAW -ext ARW . 
fi

