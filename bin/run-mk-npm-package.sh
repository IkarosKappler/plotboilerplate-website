#!/bin/bash

# Define some colors
_RED='\033[0;31m'
_GREEN='\033[0;32m'
_PURPLE='\033[0;35m'
_GREY="\033[0;37m"
_YELLOW="\033[0;33m"
_NC='\033[0m'

SOURCE_DIR="../../plotboilerplate/"
TARGET_DIR="../npm-package/"

echo -e "Working dir:"
pwd

echo -e "${_PURPLE} *** Purging target directory '$TARGET_DIR'${_NC}"
rm -rf "${TARGET_DIR}"


# Copy all required files to the target package
# (I do not want to publish my whole compiler setup to npmjs, only the production files)
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${_PURPLE} *** Creating target directory '$TARGET_DIR'${_NC}"
    mkdir "$TARGET_DIR"
else
    echo -e "${_PURPLE} *** Target directory '$TARGET_DIR' already exists, no need to create it.${_NC}"
fi;


# Check git repository
if [ ! -d "$TARGET_DIR.git" ]; then
    echo -e "${_PURPLE} *** Creating git repository"
    cd "$TARGET_DIR" && git init && cd ../bin/
    [ $? -eq 0 ]  || exit 1
else
    echo -e "${_PURPLE} *** git repository already exists, no need to create it.${_NC}"
fi

if [ ! -f ".gitignore" ]; then
    # git config --global init.defaultBranch <name>
    git config --global init.defaultBranch main
    echo -e "${_PURPLE} *** Creating .gitignore file${_NC}"
    echo "*~" >> "$TARGET_DIR.gitignore"
    echo "_*" > "$TARGET_DIR.gitignore"
fi

echo -e "${_PURPLE} *** Copying files for minimal package ... ${_NC}"
# Force delete the old src and dist folders to get rid of deprecated/deleted/renamed stuff.
# rm -rf "$TARGET_DIR"src
# rm -rf "$TARGET_DIR"dist
# (no docs, no demos, no jekyll, no config files, no screenshots)
ls "$SOURCE_DIR"
cp "$SOURCE_DIR"README.md "$TARGET_DIR"README.md
cp "$SOURCE_DIR"changelog.md "$TARGET_DIR"changelog.md
cp "$SOURCE_DIR"basics.md "$TARGET_DIR"basics.md
cp "$SOURCE_DIR"package.json "$TARGET_DIR"package.json
cp -r "$SOURCE_DIR"src/ "$TARGET_DIR"
cp -r "$SOURCE_DIR"dist/ "$TARGET_DIR"
cp "$SOURCE_DIR"main-dist.html "$TARGET_DIR"main-dist.html
cp "$SOURCE_DIR"main.html "$TARGET_DIR"main.html
cp "$SOURCE_DIR"main-svg.html "$TARGET_DIR"main-svg.html
cp "$SOURCE_DIR"style.css "$TARGET_DIR"style.css
cp "$SOURCE_DIR"example-image.png "$TARGET_DIR"example-image.png
cp "$SOURCE_DIR"LICENSE "$TARGET_DIR"LICENSE

BUILDDATE=$(date)
touch "$TARGET_DIR"builddate
echo -e "$BUILDDATE" > "$TARGET_DIR"builddate


echo -e "${_PURPLE} *** Commiting the files to the new package${_NC}"
cd "$TARGET_DIR" && git add .gitignore * && git commit -m "Auto-commit $BUILDDATE"
cd ..
