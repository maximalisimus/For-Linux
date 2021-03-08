#!/bin/bash
rm -rf ./test/MD5
rm -rf ./test/error-md5
echo ""
echo "------------"
find ./test -type f | grep -v "MD5" | grep -v "error-md5"
echo "------------"
_files=$(find ./test -type f | grep -v "MD5" | grep -v "error-md5")
for i in ${_files[*]}; do
	md5sum $i 1>>./test/MD5 2>>./test/error-md5
done
md5sum -c ./test/MD5
echo "------------"
[[ $(cat ./test/error-md5) == "" ]] && echo "Good" || echo "Error"
echo "------------"
exit 0
