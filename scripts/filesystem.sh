#!/bin/sh
# format partition

dialog --inputbox "Enter the name of your partition"\
        5 60 /dev/ 2>$TEMPNAME
SELECTION=`cat $TEMPNAME`

dialog --inputbox "Enter extension type(ext2,3,4,vfat etc.)"\
        5 60 2>$TEMPNAME
EXT=`cat $TEMPNAME`

dialog --yesno \
   "Any data on $SELECTION will be erased!\n
Are you really sure you want to continue?" 18 60 

if [ $? = 0 ]
then
   #echo -n $SELECTION >/tmp/rootfs
   #format device
    sudo mkfs.$EXT $SELECTION
    if [ $? != 0 ]
    then
        dialog --msgbox "Unable to format $SELECTION with $EXT!" 18 60
        exit 1
    fi
fi
