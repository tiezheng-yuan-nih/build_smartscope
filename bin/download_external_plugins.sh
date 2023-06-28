#! /usr/bin/bash

#download external_pluins
mkdir external_plugins
cd external_plugins
git clone https://github.com/JoQCcoz/ptolemy-smartscope.git
echo "Add ${PWD}/external_plugins into environmental varialbe EXTERNAL_PLUGINS_DIRECTORY"