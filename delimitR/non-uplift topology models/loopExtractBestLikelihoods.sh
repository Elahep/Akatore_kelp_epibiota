#!/bin/bash
##loop to extract best likelihoods from fastsimcoal iterations, by Eli, 28Oct2020
##change XXX according to the name of the model (model1, model2, etc.)

for i in {1..2}
do 
	cd bootstrap${i}
	echo boot${i}
	for j in {1..2}
	do
	cd iteration${j}/XXX
	sed -n 2p XXX.bestlhoods > best_run${j}.txt 
	mv best_run${j}.txt ../../
	cd ../../
	done
	for n in {1..2}
	do
	cat best_run${n}.txt | sort -n -k26 | head -1 > best_boot${i}.txt
	done
cd ../
done
