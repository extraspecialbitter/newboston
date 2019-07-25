#!/usr/local/bin/ksh

export HARPDIR=/usr/home/mena/public_html/newboston/harpers
export NEWFILE=$HARPDIR/press_list
export OLDFILE=$HARPDIR/Press_list
export INFILE=/usr/home/mena/.addressbook

cp -p $NEWFILE $OLDFILE
grep ^p $INFILE | awk '{print $2}' | grep "@" | grep -v "hold@" | sort -u > $NEWFILE
