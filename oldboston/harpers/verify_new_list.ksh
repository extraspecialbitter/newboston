#!/usr/local/bin/ksh

export INFILE=$1
export OUTFILE=/tmp/new_list
export FANLIST=./fan_list
export PRESSLIST=./press_list
export REMLIST=./remove_list

rm -f $OUTFILE

for i in `cat $INFILE`
do
  grep -i $i $PRESSLIST
  if [ $? == 1 ]; then
    grep -i $i $FANLIST
    if [ $? == 1 ]; then
      grep -i $i $REMLIST
      if [ $? == 1 ]; then
         echo $i >> $OUTFILE
      fi
    fi
  fi
done
