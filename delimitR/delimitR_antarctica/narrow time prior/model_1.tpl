//Number of population samples (demes)
4 populations to simulate
//Population effective sizes (number of genes)
N_POP0
N_POP1
N_POP2
N_POP3
//Sample sizes
28 
28 
32
18
//Growth rates
0
0
0
0
//Number of migration matrices
2
//Migration matrix 0
0.000 MIG01 MIG02 MIG03
MIG10 0.000 MIG12 MIG13
MIG20 MIG21 0.000 MIG23
MIG30 MIG31 MIG32 0.000
//Migration matrix 1
0.000 0.000 0.000 0.000
0.000 0.000 0.000 0.000
0.000 0.000 0.000 0.000
0.000 0.000 0.000 0.000
//historical event: time, source, sink, migrants, new deme size, growth rate, migr mat index 
4 historical event
TBOT2 2 2 0 RESBOT2 0 1
TDIV 2 0 1 1 0 1
TANC1 1 0 1 1 0 1 
TANC2 3 0 1 RESPOPAnc 0 1
//Number of independent loci [chromosomes]
9710
//Per chromosome: Number of linkage blocks
1
//per block: Datatype, numm loci, rec rate and mut rate + optional parameters
SNP 1 0 0
