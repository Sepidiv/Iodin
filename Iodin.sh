#!/bin/bash
NuMsinCls () {
	grep -v '(\|)\|\]\|\[' cls$i  | wc -l #--line-number | sed 's/ *:.*//g'
}
NuMsinSub () {
	for i in $(echo $1 | tr ' ' "\n" | grep '('); do
		echo -ne "\t"
		echo -n $(echo $1 | tr " " "\n" | sed -n "/^$i/,/^)/p" | grep -v '(\|)' --count) | sed 's/\n//g'
		echo -ne "∃$i" | sed 's/(//g'
		echo -ne "\n"
		done
}
arra=$(cat $1 | grep '\[' | sed 's/\[//g')
# ara ara :)
for i in $arra; do
	cat $1 | sed -n "/^\[$i/,/^\]$/p" > cls$i;
	echo -ne "$(NuMsinCls $i)Ɐ$i ";
	Sarra=$(cat cls$i | grep -v '\[\|\]');
	NuMsinSub "$Sarra" > clsArra 
	echo $(cat clsArra | sort --general-numeric-sort --reverse)
	echo -ne "\n"
done | sort --general-numeric-sort --reverse | sed '/^$/d' > $1.stscs
rm cls*