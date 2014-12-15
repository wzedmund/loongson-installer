#!/bin/sh
# This installs the Linux system onto the hard disk.

dialog --inputbox "Select root partition" 18 60\
       $ROOTFS 2>$TEMPNAME

ROOTFS=`cat $TEMPNAME`

if [ "$ROOTFS" = "" ]
then
   exit 1
fi


echo -n $ROOTFS >/tmp/rootfs
sudo mount -t ext4 $ROOTFS $TARGETDIR
if [ $? != 0 ]
then
   dialog --msgbox "Mount failed!" 18 60
   exit 1
fi
#uncompress the image file, make sure the file name is "root"
sudo tar zxf $SOURCEDIR/deepiniso.tar.gz -C $TARGETDIR
sudo mv $TARGETDIR/usb/* $TARGETDIR
sudo mount /dev/sda1 $TARGETDIR/boot
sudo cp -r /boot/*  $TARGETDIR/boot
sudo cp ./config/boot.cfg $TARGETDIR/boot
sudo cp ./config/grub.cfg $TARGETDIR/boot
sudo umount $TARGETDIR/boot
sudo umount $TARGETDIR
