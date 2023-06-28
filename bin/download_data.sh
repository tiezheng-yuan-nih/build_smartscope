#! /usr/bin/bash

# download image data to the local
# pass server name from command
data_server=$1

# make current user is in sudo group and can access mri20-cn01
if [ ! -d "data" ]; then
    mkdir data
fi

DIR=data/smartscope
if [ ! -d "$DIR" ]; then
    mkdir $DIR
fi
if [ -d "$DIR" ]; then
    echo "$DIR exists."
    echo "$USER try to download image data into $DIR"
    sudo scp -r $USER@$data_server:/datastaging/data/smartscope/BaiY $DIR/
    echo "Add ${PWD}/${DIR} into your environmental variable AUTOSCREENDIR."
else
    echo "ERROR: Make sure $DIR exists."
fi
