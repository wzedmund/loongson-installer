#!/bin/sh
# This installs the Linux system onto the hard disk.

dialog --inputbox "Select boot partition" 18 60\
       $BOOTFS /dev/ 2>$TEMPNAME

BOOTFS=`cat $TEMPNAME`

if [ "$BOOTFS" = "" ]
then
    exit 1
fi

#dialog --inputbox "Select swap partiton" 18 60\
#       $SWAPFS /dev/ 2>$TEMPNAME

#SWAPFS=`cat $TEMPNAME`
#if [ "$SWAPFS" = ""  ]
#then
#  exit 1
#fi

dialog --inputbox "Select root partition" 18 60\
       $ROOTFS /dev/ 2>$TEMPNAME

ROOTFS=`cat $TEMPNAME`

if [ "$ROOTFS" = "" ]
then
   exit 1
fi

#echo -n $ROOTFS >/tmp/rootfs
sudo mount -t ext4 $ROOTFS $TARGETDIR
if [ $? != 0 ]
then
   dialog --msgbox "Mount failed!" 18 60
   exit 1
fi
#uncompress the image file, make sure the file name is "root"
#DISK=`cat $SWAPDEV`
#sudo mount $SWAPFS $SWAPDISK
#if [ $? != 0 ]
#then
#   dialog --msgbox "Mount swap disk failed!" 18 60
#   sudo umount $TARGETDIR
#   exit 1
#fi
#copy image into swap partition
#echo "start copying image to hard drive"
#sudo cp $SOURCEDIR/deepiniso.tar $SWAPDISK
#unzip image file on system partition
echo "start extracting image"
sudo tar xf $SOURCEDIR/deepiniso.tar -C $TARGETDIR

sudo cp ./config/boot.cfg $TARGETDIR/boot
sudo cp ./config/grub.cfg $TARGETDIR/boot
sudo cp ./config/vmlinuz $TARGETDIR/boot
sudo cp ./config/grub.efi $TARGETDIR/boot
sudo cp ./config/initrd.lzma $TARGETDIR/boot
#set sda1 as boot partition
sudo mount $BOOTFS $TARGETDIR/boot
#copy boot configs 
if [ ! -d $TARGETDIR/boot/boot ]
then
echo "make a boot directory in sda1"
sudo mkdir $TARGETDIR/boot/boot
fi

sudo cp ./config/boot.cfg $TARGETDIR/boot/boot
sudo cp ./config/grub.cfg $TARGETDIR/boot/boot
sudo cp ./config/vmlinuz $TARGETDIR/boot/boot
sudo cp ./config/grub.efi $TARGETDIR/boot/boot
sudo cp ./config/initrd.lzma $TARGETDIR/boot/boot

sudo cp -r /boot/*  $TARGETDIR/boot
sudo cp ./config/boot.cfg $TARGETDIR/boot
sudo cp ./config/grub.cfg $TARGETDIR/boot
sudo cp ./config/vmlinuz $TARGETDIR/boot
sudo cp ./config/grub.efi $TARGETDIR/boot
sudo cp ./config/initrd.lzma $TARGETDIR/boot
#umount all
sudo umount $TARGETDIR/boot
sudo umount $TARGETDIR
sudo umount $SWAPDISK

dialog --msgbox "Installation Completed!" 18 60
