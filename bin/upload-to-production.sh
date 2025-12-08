#!/bin/bash


if [[ -z "$user" && -z "$server" && -z "$destination" ]]; then
    echo "No env vars found. Loading up .env file ..."
    set -o allexport
    [[ -f ../.env ]] && source ../.env
    set +o allexport
else
    echo "Env vars found."
fi


while true; do
    read -p "Do you wish compile the jekyll pages before uploading (y/n)? " yn
    case $yn in
        [Yy]* ) cd ../docs_jekyll; bash build.sh; cd ../bin; break;;
        [Nn]* ) break;; #exit;;
        * ) echo "Please answer y or n.";;
    esac
done


source "$(dirname "$0")/function-add-tacker-to-all.sh"
addTrackerToDemos
# exit 1


echo "Uploading to $server ..."

# rsync -avH ../docs_jekyll/_site/*  -e ssh user@server:/your/destination/path
rsync -avH ../docs_jekyll/_site/*  -e ssh $user@$server:$destination
rsync -avH ../demos_with_tracker/* -e ssh $user@$server:"$destination/repo/demos/"
rsync -avH ../dist                 -e ssh $user@$server:"$destination/repo/"
rsync -avH ../lib                  -e ssh $user@$server:"$destination/repo/"
rsync -avH ../screenshots          -e ssh $user@$server:"$destination/repo/"
rsync -avH ../src                  -e ssh $user@$server:"$destination/repo/"
rsync -avH ../tests                -e ssh $user@$server:"$destination/repo/"
rsync -avH ../*.*                  -e ssh $user@$server:"$destination/repo/"
rsync -avH ../releases/*           -e ssh $user@$server:"$destination/releases/"

# Clear demos with tracker dir
rm -rf ../demos_with_tracker

