#!/bin/bash


# TODO: this is probably not working!!!

function addTrackerToDemos() {
    # Read tracker code into file
    if [ ! -f "../tracking-code.html" ]; then
	    echo "WARN No tracker code found."
	    return
    fi

    mkdir -p ../temp/demos_with_tracker
    cp -r ../static/repo/demos/* ../temp/demos_with_tracker

    # How to replace text in a file with contents of a differnt file using sed
    #    https://stackoverflow.com/questions/6790631/use-the-contents-of-a-file-to-replace-a-string-using-sed
    str="<\/body>"
    fileToInsert=../temp/demos_with_tracker/tracking-code-with-body.html
    cat ../tracking-code.html > ../temp/demos_with_tracker/tracking-code-with-body.html
    echo "</body>" >> ../temp/demos_with_tracker/tracking-code-with-body.html
    
    for d in ../temp/demos_with_tracker/*; do
        if [ -d "$d" ]; then
            for f in "$d"/*.html; do
            if [ -f "$f" ]; then

                dir_name=$(basename ${d})
                file_name=$(basename ${f})
                # echo "dir_name $dir_name"
                # echo "file_name $file_name"
                echo "Processing $dir_name/$file_name"

                cp "$f" ../temp/demos_with_tracker/_tmp.html
                sed -e "/$str/r $fileToInsert" -e "/$str/d" ../temp/demos_with_tracker/_tmp.html > "$f"
                cp "$f" "../static/repo/demos/$dir_name/$file_name"
                rm ../temp/demos_with_tracker/_tmp.html 
            fi
            done
        fi
    done
}

# addTrackerToDemos

