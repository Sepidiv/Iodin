#!/bin/bash
touch clsmrk
for line in $(cat clstmpr); do
	if [ $(cat clsmrk | grep $line | wc -l) = 0 ]; then
		echo $line >> clsmrk
		sort clsmrk | tee clsmrk &> /dev/null
	fi;
done
