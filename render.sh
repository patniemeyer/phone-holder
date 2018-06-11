#!/bin/sh

file=cup-holder.scad
noextension=`echo $file | sed 's/\.[^.]*$//'`  # sed doesn't have non-greedy
~/MyApplications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o "${noextension}.stl" $file
