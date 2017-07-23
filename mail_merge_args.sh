#!/bin/bash
#printf "$0\n $1\n $2\n $*\n $#\n $?\n"
if [ $# -eq 2 ]
then
	printf "template-file:$1\n"
	printf "data-file:$2\n"
	if [ -d "out" ]; then
		printf "Directory out exists.\n"	
	else
		mkdir out
	fi
else
	printf "usage: ./mail_merge_args.sh template-file data-file\n"
fi
template="$(cat $1)"
data="$(cat $2)"
#echo "$template"
#echo "$data"
IFS=","
echo "$data" | while read a b c d e f; do
message="$(echo "$template" | sed "\
s/--first--/$a/;\
s/--last--/$b/;\
s/--item--/$c/;\
s/--location--/$d/;\
s/--date--/$e/")" 
echo "$message";
echo "$message" > out/"$a-$b.txt";
done
