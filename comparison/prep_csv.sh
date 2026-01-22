ROOTDIR="$(dirname "$(realpath "$0")")"

DIR=.

if [ $# -eq 2 ]; then
    INFILE="$1"
    OUTFILE="$2"
else
    echo "Usage: $0 infile outfile"
    exit 1
fi

strip=$(cat $INFILE | sed "s|\([0-9]\)s|\1 ;|" | sed "s|\([0-9]\)MB|\1 ;|")

strip=$(echo "$strip" | sed "s|-maxT0*|-maxT|" | sed "s|-maxT\([0-9]*\)|; \1 ;|")
strip=$(echo "$strip" | sed "s|-E\([0-9]*\)|; \1 ;|")

echo "NAME ; PARAM ; T [s] ; M [MB] ; RES" > $OUTFILE
echo "$strip"    | grep "PASS\|TIMEO\|FAIL" | sed "s|^.-||" >> $OUTFILE