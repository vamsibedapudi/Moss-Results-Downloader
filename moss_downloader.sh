#!/usr/bin/env bash

# saner programming env: these switches turn some bugs into errors
# set -e
# set -u
# set -o pipefail

! hash wget > /dev/null
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
	echo 'wget is required for this script'
	exit 1
fi

! getopt --test > /dev/null 
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
	echo 'I’m sorry, `getopt --test` failed in this environment.'
	exit 1
fi

OPTIONS=ho:u:n:q
LONGOPTS=help,output-dir:,url:,number:,quiet

# -use ! and PIPESTATUS to get exit code with errexit set
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
	# e.g. return value is 1
	#  then getopt has complained about wrong arguments to stdout
	exit 2
fi

function display_help {
		   echo '''
Moss Downloader: moss_downloader [-hq] [-d output-dir] [-n number] [-u url]
	Script to download the top n, number of matched results, from the moss site

	Options:
		-u, --url link for the moss results, required
		-q, --quiet do not display any wget logs, default no
		-o, --output-dir output directory to store the downloaded webpages from moss website, default moss_results
		-n, --number number of moss matches to download, default top 10
		-h, --help display this help and exit

	Usage Example: 
'''
}
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

quiet='' output_dir=moss_results url=- number=10
# now enjoy the options in order and nicely split until we see --
while true; do
	case "$1" in
		-h|--help)
			display_help
			exit 3
			;;
		-q|--quiet)
			quiet="-q "
			shift
			;;
		-o|--output-dir)
			output_dir=$(realpath "$2")
			echo $output_dir
			shift 2
			;;
		-u|--url)
			url="$2"
			shift 2
			;;
		-n|--number)
			number="$2"
			shift 2
			;;
		--)
			shift
			if [ "$url" == "-" ]; then
				display_help
				exit 4; 				
			fi
			break
			;;
		*)
			echo "Programming error"
			exit 5
			;;
	esac
done

file="moss_downloaded_results.html"
wget "$quiet"-np -e robots=off "$url" -O "$file"

./remove_extra_results.py "$file" "$number"
wget "$quiet" -k -F -r -p -np -e robots=off -i "$file"
mkdir  -p "$output_dir"
mv moss.stanford.edu "$output_dir"
sed -i -e 's/https:\/\///g' $file
sed -i -e 's/http:\/\///g' $file
cp README "$output_dir"
mv "$file" "$output_dir/index.html"

# echo "verbose: $v, force: $f, debug: $d, in: $1, out: $outFile"