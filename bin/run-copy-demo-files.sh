#!/bin/bash

# Always add trailing slash
PLOTBOILERPLATE_REPO_PATH="../../plotboilerplate/"

rm -R "../static/repo/demos" 
cp -R "${PLOTBOILERPLATE_REPO_PATH}demos/" "../static/repo/demos" 

cp -R "${PLOTBOILERPLATE_REPO_PATH}lib/" "../static/repo/lib" 
cp -R "${PLOTBOILERPLATE_REPO_PATH}src/" "../static/repo/src" 
cp -R "${PLOTBOILERPLATE_REPO_PATH}dist/" "../static/repo/dist" 


source "$(dirname "$0")/function-add-tacker-to-demos.sh"

addTrackerToDemos