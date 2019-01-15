#!/bin/sh -e

outfile=${PWD}/${2}

expectdir=
tarflags=
case $1 in
  *.tar.xz) tarflags="-J"; expectdir=${1%%.tar.xz};;
  *.tar.gz) tarflags="-z"; expectdir=${1%%.tar.gz};;
  *.tgz) tarflags="-z"; expectdir=${1%%.tgz};;
  *.tar) expectdir=${1%%.tar};;
esac

[ -z $expectdir ] && {
	echo "bad input file $1"
	exit 1
}
[ -d "$expectdir" ] && rm -rf "$expectdir"

echo "extracting..."
tar $tarflags -xf $1
[ -d "$expectdir" ] || {
	echo "expected to create $expectdir and didn't..."
	exit 1
}
echo "done"

[ -f "$outfile" ] && rm "$outfile"

echo "creating archive..."
cd $expectdir
find . \( -type f -name 'Kconfig*' -o -name 'Makefile*' -o -name 'streamline_config.pl' \) -print0 | tar -czf $outfile --null -T -
echo "done"

