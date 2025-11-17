#!/bin/bash
#
# Generate a markdown document containing an overview of all
# available demo pages.
#
# The source files are located in the directories ../demos/*
#  * only directories are accepted
#  * directories starting with _* will be ignored
#  * directories starting with basic-* will be ignored
#
# Follwing header tags should be contained in each */index.html file
#  * <title>...</title>
#  * <meta property="og:image" content="..." >
#  * <meta property="og:description" content="..." >
#  * <meta property="og:title" content="..." >
#
# @date    2020-05-13
# @author  Ikaros Kappler
# @version 1.0.0

# Import colors
source "`dirname $0`"/colors.sh

echo -e "${_PURPLE} *** Creating temp directory '$TEMP_DIR'${_NC}"

 
# Trailing slashes will be ensured later again.
# Use the root directory from your plotboilerplate installation.
SOURCE_DIR="../../plotboilerplate/"
DEST_DIR="../content/demos/"
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

echo -e "${_GREY} Cleaning up temp directory $TEMP_DIR.${_NC}"
pwd
rm -rf "${TEMP_DIR}"*


function mkDemoPage() {
	demoDir="${SOURCE_DIR}demos/"
    # Read tracker code into file
    if [ ! -d "$demoDir" ]; then
		echo "WARN No ../demo/ directory found."
		return
    fi

    # With trailing slash
    outFile="${DEST_DIR}_index.md"
	basicOutFileName="basic-demos.html"
	basicOutFile="${TEMP_DIR}/$basicOutFileName"
	demosOutFileName="demos.html"
	demosOutFile="${TEMP_DIR}/$demosOutFileName"
    echo "Building demo page from '$demoDir' directory ..."


	echo '' > $basicOutFile    
	echo '<h3>Basics</h3>' >> $basicOutFile
	echo '<div class="full-width align-center">' >> $basicOutFile

	# echo "   {% include $basicOutFileName %}" >> $basicOutFile
	# echo "   {{ partial \"$basicOutFileName\" . }}" >> $basicOutFile
	# echo '</div>' > $basicOutFile

	echo '<h3>Enhanced</h3>' > $demosOutFile
    echo '<div class="full-width align-center">' >> $demosOutFile
    for d in "$demoDir"*; do
		if [ -d "$d" ]; then
			if [ ! -f "$d/index.html" ]; then
				echo "WARN No '$d/index.html' file found."
			else
				echo "Processing file $d/index.html ..."

				# /^\t#/N;
				# imgSrc=$(cat "$d/index.html" | sed -rn "/<meta .*property=.og:image./ s/.*content=.([^\"]+).*/\1/p")
				# imgSrc=$(cat "$d/index.html" | sed -rn "/<meta (\s.)*property=.og:image.(\s.)*/ s/.*content=.([^\"]+).*/\1/p")
				# imgSrc=$(cat "$d/index.html" | sed -rn "/^\t#/N;/<meta (\s\n\t)*property=.og:image./ s/(\s\b\t)*content=.([^\"]+).*/\2/p")
				# imgSrc_raw=$(cat "$d/index.html" | sed -rn "/<meta (\s\n\t)*property=.og:image./ s/(\s\b\t)*content=.([^\"]+).*/\2/p")
				# imgSrc=$(echo "$imgSrc_raw" | sed -rn "/<meta .*property=.og:image./ s/.*content=.([^\"]+).*/\1/p")
				imgSrc=$(cat "$d/index.html" | grep -Eo "(content=\"http|https)://plotboilerplate.io/repo/screenshots/[a-zA-Z0-9./?=_%:-]*" | sort -u)
				descr=$(cat "$d/index.html" | sed -rn "/<meta .*property=.og:description./ s/.*content=.([^\"]+).*/\1/p")
				title=$(cat "$d/index.html" | sed -rn "/<meta .*property=.og:title./ s/.*content=.([^\"]+).*/\1/p")
				htmlTitle=$(cat "$d/index.html" | sed -n 's/<title>\(.*\)<\/title>/\1/Ip')
				# echo "    Source (raw): $imgSrc_raw"
				echo "    Source:       $imgSrc"
				echo "    Descr:        $descr"
				echo "    title:        $title"
				echo "    htmlTitle:    $htmlTitle"

				baseName=$(basename $d);
				echo "baseName=$baseName"
				if [[ $baseName == _* ]]; then
					echo "Ignoring underscore directory $d"
				elif [[ $baseName == basic-* ]]; then
					echo "Processing the 'basics' directory $d"
					echo "   <div class=\"demo-box-basic\">" >> $basicOutFile
					echo "      <a class=\"no-decoration\" href=\"/repo/demos/$baseName/index.html\">" >> $basicOutFile
					echo "         <div style=\"background-image: url('$imgSrc');\"></div>" >> $basicOutFile
					echo "      </a>" >> $basicOutFile
					echo "   </div>" >> $basicOutFile
				else
					# href="{{ my_page.url | prepend: site.baseurl }}"
					echo "   <div class=\"demo-box\">" >> $demosOutFile
					echo "      <a class=\"no-decoration\" href=\"/repo/demos/$baseName/index.html\">" >> $demosOutFile
					echo "         <div style=\"background-image: url('$imgSrc');\"></div>" >> $demosOutFile
					echo "      </a>" >> $demosOutFile
					echo "   </div>" >> $demosOutFile
				fi
			
			fi
		fi
    done
    echo '</div>' >> $demosOutFile
	echo '</div>' >> $basicOutFile


	# Clear output file with new content
    echo '+++' > $outFile
    # echo 'layout = "demos"' >> $outFile
    # echo 'permalink = "/demos/"' >> $outFile
	# 2024-04-17T00:06:07+01:00
	# Warning: Hugo ignores files if date is considered in the future
	date=`date +"%Y-%m-%dT%H:%M:%S+01:00" -d "yesterday"` 
    echo "title = 'PlotBoilerplate | Demos'" >> $outFile
    echo 'draft = false' >> $outFile
    # date +'date = %Y-%m-%d' >> $outFile
	echo "date = $date" >> $outFile
    echo '+++' >> $outFile
    echo '' >> $outFile

	# Finally concatenate both temp files into the final file
	echo '{{< rawhtml >}}' >> $outFile
	echo "<!-- Note: this document is generated by a bash script. Do not modify manually. -->" >> $outFile
	# echo "<b>TEST 3 $date</b>" >> $outFile

	cat "$basicOutFile" >> $outFile
	cat "$demosOutFile" >> $outFile
	echo '{{< /rawhtml >}}' >> $outFile

}

mkDemoPage


