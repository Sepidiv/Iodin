#!/bin/bash
NuMsinCls () {
	grep -v '(\|)\|\]\|\[' cls$i  | wc -l #--line-number | sed 's/ *:.*//g'
}
NuMsinSub () {
	for i in $(echo $1 | tr ' ' "\n" | grep '('); do
		i=$(echo -ne $i | sed 's/(//g')
		echo -ne "$(cat $fNam.stscs | sed -n '/-零-/,/-壱-/p' | grep $i --count)∃$i "
	done | sed 's/ /\n/g' | sort --general-numeric-sort --reverse |sed 's/\n/ /g'
}
arra=$(cat $1 | grep '\[' | sed 's/\[//g')
# ara ara :)
fNam=$1
echo "--------零--------" > $1.stscs
for i in $(cat $1 | sort --general-numeric-sort | grep -v "(\|)\|\[\|\]" | sed 's/\t//g'); do $(cat ~/.SepiDiv)/Argon/Argon.sh -f $1 -w $i; done >> $1.stscs
echo "--------壱--------" >> $1.stscs
for i in $arra; do
	cat $1 | sed -n "/^\[$i/,/^\]$/p" > cls$i;
	echo -ne "$(NuMsinCls $i)Ɐ$i ";
	Sarra=$(cat cls$i | grep -v '\[\|\]');
	NuMsinSub "$Sarra" > clsArra
	echo $(cat clsArra | sort --general-numeric-sort --reverse)
	echo -ne "\n"
done | sort --general-numeric-sort --reverse | sed '/^$/d' >> $1.stscs
echo "--------弐--------" >> $1.stscs
chek1=$(cat $fNam.stscs | sed -n '/-零-/,/-壱-/p' | sed '/^--------/d' | sed 's/.*=>//g' | sort | uniq --count | wc -l)
chek2=$(cat $fNam.stscs | sed -n '/-零-/,/-壱-/p' | sed '/^--------/d' | wc -l)
if [ $chek1 = $chek2 ]; then
	echo "開"
else
	echo "閉"
fi >> $1.stscs
echo "--------参--------" >> $1.stscs
cat $fNam.stscs | sed -n '/-零-/,/-壱-/p' | sed '/^--------/d' | awk -F'=>' '{NF-=1}1' | sed 's/ /=>/g' > clstmpr
touch clsmrk
for line in $(cat clstmpr); do
	if [ $(cat clsmrk | grep $line | wc -l) = 0 ]; then
		echo $line | tee -a clsmrk &> /dev/null
	fi;
done
for i in $(cat clsmrk); do
	for j in $(cat clsmrk); do
		echo \"$i\",\"$j\";
	done;
done | sort >> $1.stscs
echo '--------肆--------' >> $1.stscs
rm cls*
