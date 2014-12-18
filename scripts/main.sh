#!/bin/bash
#Partition a hard disk
export TEMPNAME=./choice
export SCRIPTDIR=./scripts
export SOURCEDIR=./data
export TARGETDIR=/mnt
export FLAG=./flag


#initialize the loop flag
FLAG=1

#main menu
dialog --clear --msgbox  \
"Welcome to the Deepin Installer\n
Please make sure that all your disks are backed up\n
before you start installation" 18 60

while [ $FLAG -gt 0 ]
do
dialog --clear --menu "Deepin Installer Disk Menu" \
        18 60 6 \
        partition "Partition a disk with cfdisk" \
        swap "Select a swap partition" \
        filesystem "Choose a file system to format" \
        install "Install Linux " \
        exit "Exit " \
        reboot "Reboot" 2>$TEMPNAME
SELECTION=`cat $TEMPNAME`

#check if select cancel
if [ "$SELECTION" = "" ]
then
break
fi
#check if select exit
if [ "$SELECTION" = "exit" ]
then
break
fi
echo "$SCRIPTDIR"
$SCRIPTDIR/$SELECTION.sh
done

#clean redundant files
rm choice