#!/bin/sh
# Select and install a root partition

dialog --inputbox "Enter the name of your root partition"\
        5 60 /dev/ 2>$TEMPNAME
SELECTION=`cat $TEMPNAME`

dialog --yesno \
   "Any data on $SELECTION will be erased!\n
Are you really sure you want to continue?" 18 60 

if [ $? = 0 ]
then
   echo -n $SELECTION >/tmp/rootfs
   #format device as ext4
   sudo mkfs.ext4 $SELECTION
fi
