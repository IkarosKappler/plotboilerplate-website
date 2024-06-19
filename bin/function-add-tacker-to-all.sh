#!/bin/bash


// TODO: this is probably not working!!!

function addTrackerToDemos() {
    # Read tracker code into file
    if [ ! -f ../docs_jekyll/_tracker.js ]; then
	    echo "WARN No tracker code found."
	return
    fi

    mkdir -p ../demos_with_tracker
    cp -r ../demos/* ../demos_with_tracker

    # How to replace text in a file with contents of a differnt file using sed
    #    https://stackoverflow.com/questions/6790631/use-the-contents-of-a-file-to-replace-a-string-using-sed
    str="<\/body>"
    fileToInsert=../demos_with_tracker/_tmp_tracker.js
    cat ../docs_jekyll/_tracker.js > ../demos_with_tracker/_tmp_tracker.js
    echo "</body>" >> ../demos_with_tracker/_tmp_tracker.js
    
    for d in ../demos_with_tracker/*; do
	if [ -d "$d" ]; then
	    for f in "$d"/*.html; do
		if [ -f "$f" ]; then
		    cp "$f" ../demos_with_tracker/_tmp.html
		    sed -e "/$str/r $fileToInsert" -e "/$str/d" ../demos_with_tracker/_tmp.html > "$f"
		    rm ../demos_with_tracker/_tmp.html 
		fi
	    done
	fi
    done
}


