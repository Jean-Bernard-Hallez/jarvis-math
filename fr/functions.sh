#!/bin/bash

chiffre() {
#echo "$order"
#echo ${order##* }
#echo ${order### }
b=`echo "$order"| cut -d" " -f2`
c=`echo "$order"| cut -d" " -f4`
d=`echo $(jv_sanitize "$order")| cut -d" " -f3`

if [[ $c == "par" ]] ; then
c=`echo "$order"| cut -d" " -f5`
fi


e=" "

test $b
b=$conv
test $c
c=$conv
test $d


if [[ $e == "+" ]] ; then
echo "$b $d $c est �gale �"
echo "$b + $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"
fi

if [[ $e == "-" ]] ; then
echo "$b $d $c est �gale �"
echo "$b - $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"
fi

if [[ $e == "*" ]] ; then
echo "$b $d par $c est �gale � "
echo "$b * $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"
fi

if [[ $e == "/" ]] ; then
echo "$b $d par $c est �gale �"
verifi=$(echo "$b / $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/")
verifi1=$( echo `expr substr $verifi 1 1`)
echo $verifi1

if [[ $verifi1 == "." ]] ; then 
echo "0$verifi"
else
echo "$verifi"
fi
fi

}

test () {
conv=" "

if [[ $1 == "un" ]] ; then
conv=1
fi

if [[ $1 == "deux" ]] ; then
conv=2
fi

if [[ $1 == "trois" ]] ; then
conv=3
fi

if [[ $1 == "quatre" ]] ; then
conv=4
fi

if [[ $1 == "cinq" ]] ; then
conv=5
fi

if [[ $1 == "six" ]] ; then
conv=6
fi

if [[ $1 == "sept" ]] ; then
conv=7
fi

if [[ $1 == "huit" ]] ; then
conv=8
fi

if [[ $1 == "neuf" ]] ; then
conv=9
fi

if [[ $1 == "multiplie" ]] ; then
e="*"
fi

if [[ $1 == "foi" ]] ; then
e="*"
fi

if [[ $1 == "foie" ]] ; then
e="*"
fi

if [[ $1 == "fois" ]] ; then
e="*"
fi

if [[ $1 == "additionne" ]] ; then
e="+"
fi

if [[ $1 == "plus" ]] ; then
e="+"
fi

if [[ $1 == "moins" ]] ; then
e="-"
fi

if [[ $1 == "moin" ]] ; then
e="-"
fi

if [[ $1 == "soustrait" ]] ; then
e="-"
fi

if [[ $1 == "divise" ]] ; then
e="/"
d="divis�"
fi

if [[ $conv == " " ]] ; then
conv=$1
fi


return
}
