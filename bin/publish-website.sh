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
    read -p "Do you wish compile the hugo pages before uploading (y/n)? " yn
    case $yn in
        [Yy]* ) cd ../ && npm run build && cd bin; break;;
        [Nn]* ) break;; #exit;;
        * ) echo "Please answer y or n.";;
    esac
done



echo "Uploading to $server ..."

# rsync -avH ../docs_jekyll/_site/*  -e ssh user@server:/your/destination/path
# rsync -avH ../docs_jekyll/_site/*  -e ssh $user@$server:"$destination"
# rsync -avH ../demos_with_tracker/* -e ssh $user@$server:"$destination/repo/demos/"
# rsync -avH ../demos_with_tracker/* -e ssh $user@$server:"$destination/repo/demos/"
# rsync -avH ../dist                 -e ssh $user@$server:"$destination/repo/"
# rsync -avH ../lib                  -e ssh $user@$server:"$destination/repo/"
# rsync -avH ../screenshots          -e ssh $user@$server:"$destination/repo/"
# rsync -avH ../src                  -e ssh $user@$server:"$destination/repo/"
# rsync -avH ../tests                -e ssh $user@$server:"$destination/repo/"
# rsync -avH ../*.*                  -e ssh $user@$server:"$destination/repo/"
# rsync -avH ../releases/*           -e ssh $user@$server:"$destination/releases/"
# rsync -avH ../repo/screenshots/*           -e ssh $user@$server:"$destination/repo/screenshots/"

echo "Current working directory $(pwd)"
echo "destination $destination"
rsync -avH ../public/*  -e ssh $user@$server:"$destination"

