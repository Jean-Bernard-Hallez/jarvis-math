#!/bin/bash

chiffre() {

[[ -z $(which bc) ]] && sudo apt-get install bc

b=`echo "$order"| cut -d" " -f2`
c=`echo "$order"| cut -d" " -f4`
d=`echo $(jv_sanitize "$order")| cut -d" " -f3`
e=" "

test $d

if [[ $test2 == "1" ]] ; then
d=`echo $order | cut -d" " -f3`
test $d
fi

if [[ $c == "par" ]] ; then
c=`echo "$order"| cut -d" " -f5`
fi


test $b
b=$conv
test $c
c=$conv

if [[ $e == "+" ]] ; then
resultatmath="$b $d $c est égale à "
resultatmath1=`echo "$b + $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
say "$resultatmath $resultatmath1"
fi

if [[ $e == "-" ]] ; then
resultatmath="$b $d $c est égale à "
resultatmath1=`echo "$b - $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
say "$resultatmath $resultatmath1"
fi

if [[ $e == "*" ]] ; then
resultatmath="$b $d par $c est égale à "
resultatmath1=`echo "$b * $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
say "$resultatmath $resultatmath1"
fi

if [[ $e == "/" ]] ; then
resultatmath="$b $d par $c est égale à "
verifi=$(echo "$b / $c" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/")
verifi1=$(echo `expr substr $verifi 1 1`)

if [[ $verifi1 == "." ]] ; then 
say "$resultatmath 0$verifi"
else
say "$resultatmath $verifi"
fi
fi

if [[ $e == "-" ]] || [[ $e == "+" ]] || [[ $e == "*" ]] || [[ $e == "/" ]] ; then
echo ""
else 
say "commande vocale mathématique non reconnu"
fi


}

test () {
conv=" "

if [[ $1 == "zéro" ]] ; then
conv=0
fi

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

if [[ $1 == "CHANGELOG.md" ]] ; then
e="*"
d="multipié"
fi

if [[ $1 == "x" ]] ; then
e="*"
d="multipié"
fi


if [[ $1 == "additionne" ]] ; then
e="+"
fi

if [[ $1 == "+" ]] ; then
e="+"
fi

if [[ $1 == "plus" ]] ; then
e="+"
fi

if [[ $1 == "-" ]] ; then
e="-"
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
d="divisé"
fi

if [[ $1 == "/" ]] ; then
e="/"
d="divisé"
fi


if [[ $conv == " " ]] ; then
conv=$1
fi

if [[ $e == " " ]] ; then
test2="1"
else 
test2="0"
fi

return
}
