#!/bin/bash
#
# This is a quick hack, to convert images to png for preview
# Call script with -h to show help
#
# This takes all images in directory icons

# configuration
sourcedir=icons
targetdir=icons_preview
restfile=Images.rst

# automatic variables
thisdir=$(pwd)
progname=`basename $0`

function usage()
{
   echo "Usage: $progname [sourcedir] [targetdir] [restfile]"
   echo "  sourcedir: "
   echo "     (default: $sourcedir)"
   echo "  targetdir: "
   echo "     (default: $targetdir)"
   exit 0
}


# check for arguments
if [ $# -gt 0 ];then
   if [[ $1 == -h ]];then
      usage
   fi
	sourcedir="$1"
fi
if [ $# -gt 1 ];then
	targetdir="$2"
fi

if [ $# -gt 2 ];then
	restfile="$3"
fi


echo "sourcedir=$sourcedir, targetdir=$targetdir"

# check for errors
if [ ! -d $sourcedir ];then
	echo "ERROR: sourcedir $sourcedir does not exist"
	usage
fi

if [ ! -d $targetdir ];then
	echo "ERROR: targetdir $targetdir does not exist"
	usage
fi

cd $sourcedir || (echo "Error entering $sourcedir";exit 1)
sourcedir=$(pwd)

echo "start"
cd $thisdir
cd $targetdir || (echo "Error entering $targetdir";exit 1)
targetdir=$(pwd)

echo "preview image files in $targetdir"
cd $sourcedir
ls *.svg | while read i;do echo $i;new=$(echo $i | perl -p -e "s/\.svg/_preview.png/");echo $new;convert $i $targetdir/$new;done
echo "Created $targetdir/*_preview.png"


# Create .rst file
echo "-----------------------------------------"
echo "Create .rst file in $targetdir: $restfile"
cd $targetdir
if [ -f $restfile ];then
	rm $restfile
fi
for i in *.png;do echo ".. image:: $i" >> $restfile;echo " " >> $restfile;done

echo "Created $restfile"

