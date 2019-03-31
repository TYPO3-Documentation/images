#!/bin/bash
#
# This is a quick hack, to convert images to png for preview

sourcedir=icons
targetdir=icons_preview
restfile=Images.rst

thisdir=$(pwd)

if [ $# -gt 0 ];then
	sourcedir="$1"
fi

if [ $# -gt 1 ];then
	targetdir="$2"
fi

echo "sourcedir=$sourcedir, targetdir=$targetdir"

if [ ! -d $sourcedir ];then
	echo "$sourcedir does not exist"
	exit 1
fi

if [ ! -d $targetdir ];then
	echo "$targetdir does not exist"
	exit 1
fi

cd $sourcedir || (echo "Error entering $sourcedir";exit 1)
sourcedir=$(pwd)

echo "start"
cd $thisdir
cd $targetdir || (echo "Error entering $targetdir";exit 1)
targetdir=$(pwd)

cd $sourcedir
ls *.svg | while read i;do echo $i;new=$(echo $i | perl -p -e "s/\.svg/_preview.png/");echo $new;convert $i $targetdir/$new;done


# Create .rst file
cd $targetdir
if [ -f $restfile ];then
	rm $restfile
fi
for i in *.png;do echo ".. image:: $i" >> $restfile;echo " " >> $restfile;done

echo "Created $restfile"

