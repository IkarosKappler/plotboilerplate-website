#!/bin/bash

# This command creates markdown code which can be translated by Jekyll. Unfortunately my CSS is
# much uglier than that shiny default CSS theme from the typedoc generator.
# npx typedoc --out ../docs_jekyll/docs_typedoc_md --mode file ../src/ts --plugin typedoc-plugin-markdown --hideProjectName=false --hideBreadcrumbs=false --publicPath=https:\/\/plotboilerplate.io\/ --namedAnchors=false

# Refatored from old code.
# @date 2024-04-11
# @author Ikaros Kappler


# Import colors
source "`dirname $0`"/colors.sh
 
# Trailing slashes will be ensured later again.
# Use the root directory from your plotboilerplate installation.
# SOURCE_DIR="../node_modules/plotboilerplate/"
SOURCE_DIR="../../plotboilerplate/"
DEST_DIR="../content/docs/"
TEMP_DIR="../temp/"

source "$(dirname "$0")/function-ensureTrailingSlash.sh"

if [ $# -eq 0 ]
  then
    echo "[mkTypedocs] No arguments given. Using default directories (input=$SOURCE_DIR, output=$DEST_DIR)"
elif [ $# -le 2 ]
    then
    echo "[mkTypedocs] Please pass 0 (zero) or two arguments: input- and output-directory"
    exit 1
else
    SOURCE_DIR=$(ensureTrailingSlash "$1")
    DEST_DIR=$(ensureTrailingSlash "$2");
    echo "[mkTypedocs] Using directories (input=$SOURCE_DIR, output=$DEST_DIR)"
fi

# Copy all required files to the target package
# (I do not want to publish my whole compiler setup to npmjs, only the production files)
if [ ! -d "$TEMP_DIR" ]; then
    echo -e "${_PURPLE} *** Creating temp directory '$TEMP_DIR'${_NC}"
    mkdir "$TEMP_DIR"
else
    echo -e "${_PURPLE} *** Temp directory '$TEMP_DIR' already exists, no need to create it.${_NC}"
fi


echo -e "${_GREY} Cleaning up temp directory $TEMP_DIR.${_NC}"
rm -rf "${TEMP_DIR}"*


# So just generate HTML output and display it in an iframe (see ../docs_jekyll/_layouts/docs.html)
echo -e "${_PURPLE} *** Generating raw typedoc in temp directory ${TEMP_DIR}.${_NC}"
# npx typedoc --options typedoc-config.json ../src/ts/*.ts ../src/ts/**/*.ts ../src/ts/**/**/*.ts
# npx typedoc --options ../typedoc-config.json --tsconfig "$SOURCE_DIR/tsconfig.module.json" --plugin typedoc-plugin-markdown --entryDocument "_index.md" "$SOURCE_DIR"/src/ts/*.ts "$SOURCE_DIR"/src/ts/**/*.ts "$SOURCE_DIR"/src/ts/**/**/*.ts
# npx typedoc --options ../typedoc-config.json --plugin typedoc-theme-hierarchy --theme hierarchy --tsconfig "$SOURCE_DIR/tsconfig.module.json" "$SOURCE_DIR"/src/ts/*.ts "$SOURCE_DIR"/src/ts/**/*.ts "$SOURCE_DIR"/src/ts/**/**/*.ts
npx typedoc --options ../typedoc-config.json --plugin @mxssfd/typedoc-theme --theme my-theme --tsconfig "$SOURCE_DIR/tsconfig.module.json" -out "$TEMP_DIR" "$SOURCE_DIR"/src/ts/*.ts "$SOURCE_DIR"/src/ts/**/*.ts "$SOURCE_DIR"/src/ts/**/**/*.ts

echo -e "${_GREY} Cleaning up target directory $DEST_DIR.${_NC}"
rm -rf "${DEST_DIR}*"

# Attach my markdown header to all files
function addMarkdownHeader() {
    d="$1"
    echo "Dir=$d"
    if [ -d "$d" ]; then

		for file in "$d"*; do

			echo -e "${_PURPLE} *** Processing entry $file ...${_NC}"
			if [ -d "$file" ]; then
				echo "Recursion ..."
				addMarkdownHeader "$file/"
			elif [ -f "$file" ]; then
				baseName=$(basename $file);
				outFile="$DEST_DIR/$baseName"
				curDate=$(date +"%Y-%m-%d")
				echo -e "${_GREEN} *** Handing file $file and printing to $outFile ...${_NC}"
				# +++
				# title = 'Download | Plotboilerplage.js – Plot 2D stuff on SVG or Canvas.'
				# date = 2024-04-17T00:06:07+01:00
				# draft = false
				# +++
				echo '+++' > "$outFile"
				echo 'title = "Plotboilerplate Docs"' >> "$outFile"
				echo 'layout = "docs"' >> "$outFile"
				echo "date = \"$curDate\"" >> "$outFile"
				echo '+++' >> "$outFile"
				echo '' >> "$outFile"
				cat "$file" >> "$outFile"

			fi
		done
    else
		echo "Warning: file $d is not a directory! Skipping"
    fi
}
# addMarkdownHeader "$TEMP_DIR" 
