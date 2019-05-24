#!/bin/bash
NuMsinCls () {
	grep -v '(\|)\|\]\|\[' cls$i  | wc -l #--line-number | sed 's/ *:.*//g'
}
NuMsinSub () {
	for i in $(echo $1 | tr ' ' "\n" | grep '('); do
		i=$(echo -ne $i | sed 's/(//g')
		echo -ne "$(cat $fNam.stscs | sed -n '/-零-/,/-弌-/p' | grep $i --count)∃$i "
	done | sed 's/ /\n/g' | sort --general-numeric-sort --reverse |sed 's/\n/ /g'
}
arra=$(cat $1 | grep '\[' | sed 's/\[//g')
# ara ara :)
fNam=$1
echo "--------零--------" > $1.stscs
for i in $(cat $1 | sort --general-numeric-sort | grep -v "(\|)\|\[\|\]" | sed 's/\t//g'); do $(cat ~/.SepiDiv)/Argon/Argon.sh -f $1 -w $i; done >> $1.stscs
echo "--------弌--------" >> $1.stscs
for i in $arra; do
	cat $1 | sed -n "/^\[$i/,/^\]$/p" > cls$i;
	echo -ne "$(NuMsinCls $i)Ɐ$i ";
	Sarra=$(cat cls$i | grep -v '\[\|\]');
	NuMsinSub "$Sarra" > clsArra
	echo $(cat clsArra | sort --general-numeric-sort --reverse)
	echo -ne "\n"
done | sort --general-numeric-sort --reverse | sed '/^$/d' >> $1.stscs
echo "--------弐--------" >> $1.stscs
chek1=$(cat $fNam.stscs | sed -n '/-零-/,/-弌-/p' | sed '/^--------/d' | sed 's/.*=>//g' | sort | uniq --count | wc -l)
chek2=$(cat $fNam.stscs | sed -n '/-零-/,/-弌-/p' | sed '/^--------/d' | wc -l)
if [ $chek1 = $chek2 ]; then
	echo "開"
else
	echo "閉"
fi >> $1.stscs
echo "--------酸--------" >> $1.stscs
cat $fNam.stscs | sed -n '/-零-/,/-弌-/p' | sed '/^--------/d' | awk -F'=>' '{NF-=1}1' | sed 's/ /=>/g' > clstmpr
touch clsmrk
for line in $(cat clstmpr); do
	if [ $(cat clsmrk | grep $line | wc -l) = 0 ]; then
		echo $line | tee -a clsmrk &> /dev/null
	fi;
done
for i in $(cat clsmrk); do
	for j in $(cat clsmrk); do
		echo $i,$j;
	done;
done | sort >> clsMarkov
for i in $(seq 1 $(($(cat clstmpr | wc -l) - 1))); do
	line=$(echo $(sed "${i}q;d" clstmpr),$(sed "$(($i+1))q;d" clstmpr))
	cat clsMarkov | grep "$line" --line-number | sed 's/ *:.*//g'
done | sort > clsNums
for i in $(seq 1 $(($(cat clsMarkov | wc -l)))); do
	line=$(cat clsNums | grep --count $i)
	echo $iが$line
done >> $1.stscs
echo '--------死--------' >> $1.stscs
echo "--------弎--------" >> $1.stscs
res=0
for line in $(cat $fNam.stscs | sed -n '/-酸-/,/-死-/p' | sed '/^--------/d' | awk -F'が' '{print $2}');do
	res=$(($res + $line))
done
lnCount=1
for line in $(cat $fNam.stscs | sed -n '/-酸-/,/-死-/p' | sed '/^--------/d' | awk -F'が' '{print $2}');do
	mrk=$(sed "${lnCount}q;d" clsMarkov); lnCount=$(($lnCount + 1))
	echo \[$mrk\]:\%$(echo "scale=2;$line / $res * 100" | bc)
done | sort -t'%' -k2 --general-numeric-sort --reverse | sed 's/.00//g'>> $1.stscs
sed -i '/-酸-/,/-死-/d' $1.stscs
echo '--------肆--------' >> $1.stscs
zaLasto () {
	zaLina=$(cat clstmpr | tail -n 1)
	laSum=0
	for line in $(cat $fNam.stscs | sed -n '/-弎-/,/-肆-/p' | sed '/^--------/d' | grep --regexp "^\[$zaLina"); do
		zaCount=$(echo $line | awk -F'%' '{print $2}')
		yes "$(echo $line | awk -F':' '{print $1}')" | head -n $zaCount >> clsNext
	done
	rand=$(echo $(($(date +%s%N) % $(cat clsNext | wc -l) + 1)))
	cat clsNext | sed "${rand}q;d" | awk -F',' '{print $2}' | sed 's/\]//g' >> clstmpr
}
if [ ! $2 = '' ]; then
	for i in $(seq 1 $2); do
		zaLasto
	done
fi
#cat clstmpr
echo '--------伍--------' >> $1.stscs
cat $fNam.stscs | sed -n '/-零-/,/-弌-/p' | sed '/^--------/d' | awk -F'=>' '{print $NF}' > clsItems
$(cat ~/.SepiDiv)/Iodin/nth $2 $(echo $(cat clsItems))
echo '--------陸--------' >> $1.stscs
rm cls*
