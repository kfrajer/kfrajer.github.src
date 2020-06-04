#!/bin/bash

# ./crlf-cleanup.sh ".sh" ".md" ".html" ".htm" ".css" ".js" ".xml" ".json" ".txt" 

if [ "$#" = 0 ]; then
    echo "ERROR: You need to provide at least one extension. Aborting..."
    exit 1
fi

echo Number of arguments: $#
for ext in "$@"
do
    echo "Extension to clean up: $ext"
    find -type f -name "*.$ext" -not -path "./themes/*" -print0 | xargs -0 dos2unix
done

# find -type f -name "*.sh"   -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.md"   -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.html" -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.htm"  -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.css"  -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.js"   -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.txt"  -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.xml"  -not -path "./themes/*" -print0 | xargs -0 dos2unix
# find -type f -name "*.json" -not -path "./themes/*" -print0 | xargs -0 dos2unix

#for i in `find -type f -name "*.sh"  -o -name "*.md" -o -name "*.html" -o -name "*.htm" -o -name "*.xml" -o -name "*.css" -o -name "*.js" -o -name "*.txt" -o -name "*.json"`; do sed -i 's/\r//g' $i; echo "Removing Windows end of line for : $i"; done

#find -type f -name "*.sh" -o -name "*.md" -o -name "*.html" -o -name "*.htm" -o -name "*.css" -o -name "*.js" -o -name "*.txt" -o -name "*.xml" -o -name "*.json" -print0 | xargs -0 dos2unix

