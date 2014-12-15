#!/bin/sh
# Select and install a swap partition

dialog --inputbox "Enter the name of your swap partition"\
        5 60 /dev/ 2>$TEMPNAME
SELECTION=`cat $TEMPNAME`

if [ "$SELECTION" = "" ]
then
   exit 1
fi

dialog --yesno \
   "Any data on $SELECTION will be erased!\n
Are you really sure you want to continue?" 18 60 

if [ $? = 0 ]
then
   echo -n $SELECTION >/tmp/swappart
   mkswap $SELECTION
   swapon $SELCTION
fi