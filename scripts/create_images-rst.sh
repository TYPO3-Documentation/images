#!/bin/bash

 ls *.svg | while read i;do echo $i;new=$(echo $i | perl -p -e "s/\.svg/_preview.png/");echo $new;convert $i $new;done
rm Images.rst;for i in *.png;do echo ".. image:: $i" >> Images.rst;echo " " >> Images.rst;done