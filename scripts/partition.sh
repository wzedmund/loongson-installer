#!/bin/sh
#Partition a hard disk.
#simply detect possible existing storage devices
echo "" > $TEMPNAME
ls /dev/sda
if [ $? = 0 ]
then
    echo "sda " >> $TEMPNAME
fi
ls /dev/sdb
if [ $? = 0 ] 
then
    echo "sdb " >> $TEMPNAME
fi
ls /dev/hda
if [ $? = 0 ] 
then
    echo "hda " >> $TEMPNAME
fi
ls /dev/hdb
if [ $? = 0 ] 
then
    echo "hdb " >> $TEMPNAME
fi
ONLINEDEV=`cat $TEMPNAME`
dialog --clear --menu "Select a storage device to partition\n
Following devices have been detected online:\n
$ONLINEDEV"\
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
