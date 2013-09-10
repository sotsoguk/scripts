#!/bin/bash

# set path to blender binary (different for OSX and Linux)
# OSX
BLENDER_PATH=/Applications/blender.app/Contents/MacOS/blender

# Linux
#BLENDER_PATH=blender

# which files should be rendered
BLEND_FILES=*.blend
FILES_LIST=blendFiles.list
SCRIPT_NAME=renderMovies.sh
RENDER_FORMAT=MOVIE
RENDER_OPTIONS="--engine CYCLES -F $RENDER_FORMAT -x"

if [ $# -ge 1 ]
	then BLEND_FILES="$1"
fi
if [ $# -ge 2 ]
	then SCRIPT_NAME="$2"
fi

echo "Blender Path: $BLENDER_PATH"
echo "Looking for $BLEND_FILES"
ls -a $BLEND_FILES  | cat >& $FILES_LIST
echo "Files found to render"
cat $FILES_LIST
NUM_FILES=$(cat $FILES_LIST | wc -l)

#echo $NUM_FILES
#Create renderScript

echo "#!/bin/sh" > $SCRIPT_NAME

cat $FILES_LIST | while read line
do
	
	echo "$BLENDER_PATH -b $line -a $RENDER_OPTIONS">> $SCRIPT_NAME
done
chmod +x $SCRIPT_NAME

echo "Render script $SCRIPT_NAME created!"
