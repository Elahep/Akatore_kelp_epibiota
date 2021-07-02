#!/bin/bash
##loop to extract best likelihoods from fastsimcoal iterations, by Eli, 28Oct2020
##change XXX according to the name of the tested model (model1, model2, etc.)
for i in {1..40}
do 
cd iteration${i}/XXX
sed -n 2p XXX.bestlhoods > bestlhood${i}.txt
mv bestlhood${i}.txt ../../
cd ../../
done

for i in {1..40}
do
cat bestlhood${i}.txt >> allbestLhoods.txt
rm bestlhood${i}.txt
done
