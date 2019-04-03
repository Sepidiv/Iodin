#!/bin/bash
NuMsinCls () {
	grep -v '(\|)\|\]\|\[' cls$i  | wc -l #--line-number | sed 's/ *:.*//g'
}
NuMsinSub () {
	for i in $(echo $1 | tr ' ' "\n" | grep '('); do
		i=$(echo -ne $i | sed 's/(//g')
		echo -ne "$(cat $fNam.stscs | sed -n '/STAGE1/,/STAGE2/p' | grep $i --count)∃$i "
	done | sed 's/ /\n/g' | sort --general-numeric-sort --reverse |sed 's/\n/ /g'
}
arra=$(cat $1 | grep '\[' | sed 's/\[//g')
# ara ara :)
fNam=$1
echo "--------STAGE1--------" > $1.stscs
for i in $(cat $1 | sort --general-numeric-sort | grep -v "(\|)\|\[\|\]" | sed 's/\t//g'); do $(cat ~/.SepiDiv)/Argon/Argon.sh -f $1 -w $i; done >> $1.stscs
echo "--------STAGE2--------" >> $1.stscs
for i in $arra; do
	cat $1 | sed -n "/^\[$i/,/^\]$/p" > cls$i;
	echo -ne "$(NuMsinCls $i)Ɐ$i ";
	Sarra=$(cat cls$i | grep -v '\[\|\]');
	NuMsinSub "$Sarra" > clsArra
	echo $(cat clsArra | sort --general-numeric-sort --reverse)
	echo -ne "\n"
done | sort --general-numeric-sort --reverse | sed '/^$/d' >> $1.stscs
echo "--------STAGE3--------" >> $1.stscs
rm cls*