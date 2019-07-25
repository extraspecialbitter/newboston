#!/usr/local/bin/ksh

export HARPDIR=/usr/home/mena/public_html/newboston/harpers
export NEWFILE=$HARPDIR/fan_list
export OLDFILE=$HARPDIR/Fan_list
export INFILE=/usr/home/mena/.addressbook

cp -p $NEWFILE $OLDFILE
grep ^f $INFILE | awk '{print $2}' | grep "@" | grep -v "hold@" | sort -u > $NEWFILE
