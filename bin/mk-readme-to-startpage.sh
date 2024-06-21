#!/bin/sh

SOURCE_DIR="../../plotboilerplate/"
DEST_FILE="../content/_index.md"

echo '+++' > $DEST_FILE
# Warning: Hugo ignores files if date is considered in the future
date=`date +"%Y-%m-%dT%H:%M:%S+01:00" -d "yesterday"` 
echo "title = 'Plotboilerplage.js – Plot 2D stuff on SVG or Canvas.'" >> $DEST_FILE
echo 'draft = false' >> $DEST_FILE
# date +'date = %Y-%m-%d' >> $outFile
echo "date = $date" >> $DEST_FILE
echo "hasHeaderCanvas = true" >> $DEST_FILE
echo 'cover.image = "https://plotboilerplate.io/repo/logo-128.png"' >> $DEST_FILE
echo 'cover.alt = "Alt / My First Test Post"' >> $DEST_FILE
echo 'cover.caption = "This is the captions for my first test post."' >> $DEST_FILE
echo 'cover.relative = false' >> $DEST_FILE
# To use relative path for cover image, used in hugo Page-bundles
echo '+++' >> $DEST_FILE
echo '' >> $DEST_FILE

# echo "{{< interactive_canvas >}}" >> $DEST_FILE
# echo "" >> $DEST_FILE

cat "${SOURCE_DIR}README.md" >> $DEST_FILE


