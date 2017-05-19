#!/bin/bash

chiffre() {
[[ -z $(which bc) ]] && sudo apt-get install bc

b=`echo "$order" | sed -e "s/,/./g" | sed -e "s/ virgule /./g" | cut -d" " -f2`	# Premier chiffre
c=`echo "$order" | sed -e "s/,/./g" | sed -e "s/ virgule /./g" | cut -d" " -f4`	# Deuxième chiffre
d=`echo $(jv_sanitize "$order")`		# +-*/
# e="$order"
f=" "
test_math "$d"

if [[ $c == "par" ]] ; then
c=`echo "$order"| cut -d" " -f5`
fi

if [[ "$b" =~ "." ]]; then
b1=`echo "$b" | cut -d"." -f1`
test_math $b1
b1a=$conv

b2=`echo "$b" | cut -d"." -f2`
test_math $b2
b="$b1a.$conv"
else
test_math $b
fi


if [[ "$c" =~ "." ]]; then
c1=`echo "$c" | cut -d"." -f1`
test_math $c1
c1a=$conv
c2=`echo "$c" | cut -d"." -f2`
test_math $c2
c="$c1a.$conv"
else
test_math $c
fi

# Test si résultat b et c = numérique:
test_val_mathb=`echo "$b" | sed -e "s/\.//g" |  sed -e "s/,//g" | egrep -o '[[:digit:]]*'`
test_val_mathc=`echo "$c" | sed -e "s/\.//g" | sed -e "s/,//g" | egrep -o '[[:digit:]]*'`
echo "test_val_mathb=$test_val_mathb et test_val_mathc=$test_val_mathc"
if [ "$test_val_mathb" = "" ] || [ "$test_val_mathc" = "" ]; then
say "Oups, je n'ai pas réussi à traduire les valeurs numériques désolé..."
return
fi

if [ "$e" = "" ] ; then
say "Oups, symbole utilisé non reconnu..."
return
fi

# résultat calcul:
if [[ $e =~ "+" ]] ; then
resultatmath="$b $d $c est égale à"
resultatmath1=`echo "$b + $c" | sed -e "s/,/./g" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
resultatmathok=`echo "$resultatmath $resultatmath1" | sed -e "s/\./,/g"`
f="ok"
say "$resultatmathok"
fi

if [[ $e =~ "-" ]] ; then
resultatmath="$b $d $c est égale à"
resultatmath1=`echo "$b - $c" | sed -e "s/,/./g" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
resultatmathok=`echo "$resultatmath $resultatmath1" | sed -e "s/\./,/g"`
f="ok"
say "$resultatmathok"
fi

if [[ $e =~ "*" ]] ; then
resultatmath="$b $e1 par $c est égale à"
resultatmath1=`echo "$b * $c" | sed -e "s/,/./g" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
resultatmathok=`echo "$resultatmath $resultatmath1" | sed -e "s/\./,/g"`
f="ok"
say "$resultatmathok"
fi

if [[ $e =~ "/" ]] ; then
resultatmath="$b $d par $c est égale à"
verifi=$(echo "$b / $c" | sed -e "s/,/./g" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/")
verifi1=$(echo `expr substr $verifi 1 1`)

if [[ $verifi1 == "." ]] ; then 
resultatmathok=`echo "$resultatmath 0$verifi" | sed -e "s/\./,/g"`
f="ok"
say "$resultatmathok"
else
resultatmathok=`echo "$resultatmath $verifi" | sed -e "s/\./,/g"`
f="ok"
say "$resultatmathok"
fi
fi

# echo "b=$b c=$c d=$d e=$e f=$f"

if [[ $f == " " ]]; then
say "commande vocale mathématique non reconnu"
fi


}

test_math () {
conv=" "
if [[ $1 =~ "zéro" ]] ; then
conv=0
fi

if [[ $1 =~ "un" ]] ; then
conv=1
fi

if [[ $1 =~ "de" ]] ; then
conv=2
fi

if [[ $1 =~ "trois" ]] ; then
conv=3
fi

if [[ $1 =~ "quatre" ]] ; then
conv=4
fi

if [[ $1 =~ "cinq" ]] ; then
conv=5
fi

if [[ $1 =~ "six" ]] ; then
conv=6
fi

if [[ $1 =~ "sept" ]] ; then
conv=7
fi

if [[ $1 =~ "huit" ]] ; then
conv=8
fi

if [[ $1 =~ "neuf" ]] ; then
conv=9
fi

if [[ $1 =~ "multiplie" ]] ; then
e="*"
e1="multipié"
fi

if [[ $1 =~ "foi" ]] ; then
e="*"
e1="multipié"
fi

if [[ $1 =~ "CHANGELOG.md" ]] ; then
e="*"
e1="multipié"
fi

if [[ $1 =~ "x" ]] ; then
e="*"
e1="multipié"
fi


if [[ $1 =~ "additionne" ]] ; then
e="+"
fi

if [[ $1 =~ "+" ]] ; then
e="+"
fi

if [[ $1 =~ "plus" ]] ; then
e="+"
fi

if [[ $1 =~ "-" ]] ; then
e="-"
fi

if [[ $1 =~ "moins" ]] ; then
e="-"
fi

if [[ $1 =~ "moin" ]] ; then
e="-"
fi

if [[ $1 =~ "soustrait" ]] ; then
e="-"
fi

if [[ $1 =~ "divise" ]] ; then
e="/"
d="divisé"
fi

if [[ $1 =~ "/" ]] ; then
e="/"
d="divisé"
fi

if [[ $conv == " " ]] ; then
conv=$1
fi
return
}
