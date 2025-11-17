#!/bin/bash

# Always add trailing slash
PLOTBOILERPLATE_REPO_PATH="../../plotboilerplate/"

rm -R "../static/repo/demos" 
cp -R "${PLOTBOILERPLATE_REPO_PATH}demos/" "../static/repo/demos" 

cp -R "${PLOTBOILERPLATE_REPO_PATH}lib/" "../static/repo" 
cp -R "${PLOTBOILERPLATE_REPO_PATH}src/" "../static/repo" 
cp -R "${PLOTBOILERPLATE_REPO_PATH}dist/" "../static/repo" 
# cp -R "${PLOTBOILERPLATE_REPO_PATH}screenshots/" "../static/screenshots" 


source "$(dirname "$0")/function-add-tacker-to-demos.sh"

addTrackerToDemos
