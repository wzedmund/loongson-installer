#!/bin/sh
#Partition a hard disk.

dialog --clear --menu "Select a storage device to partition"\
     18 60  6 \
     hda "Primary IDE master" \
     hdb "Primary IDE slave" \
     hdc "Secondary IDE master" \
     hdd "Secondary IDE slave" \
     sda "First SCSI" \
     sdb "Second SCSI" 2>$TEMPNAME
SELECTION=`cat $TEMPNAME`
#check if cancelled
if [ "$SELECTION" = "" ]
then
exit 1
fi
#partition the chosen device
sudo cfdisk /dev/$SELECTION
