# multidice_implementation.md

This file details the multidice implementation.

The simulation is ran with a folder ```ancesNe_100to1000_taubuff50_to2000ya```. Parameters are detailed in the manuscript, but if unclear feel free to contact the authors or to raise an issue in [https://github.com/Elahep/Akatore_kelp_epibiota/issues](https://github.com/Elahep/Akatore_kelp_epibiota/issues)

```
#/usr/bin/env R
source("Multi-DICE-1.0.1.R")
output = dice.sims(num.sims=100000, num.taxa=4, num.partitions =1 ,num.haploid.samples=38, num.ind.sites=2000, tau.psi.prior=1, tau.zeta.prior=c(1:4)/4, tau.shared.prior=c(400:2000), epsilon.idio.prior=c(10:1000)/100000, NE.idio.prior=100:1000,fsc2path='/home/ludovic.dutoit/bin/fsc26', output.directory='.', gen.times = c(2, 2, 2, 0.4), tau.buffer = 50)
```

We then remove the position with invariant sites from each of the four files with 100,000 simulated SFS and put that in a new directory along with the other input and output files of Multidice.

```
#/usr/bin/sh
cp -r ancesNe_100to1000_taubuff50_to2000ya ancesNe_100to1000_taubuff50_to2000ya_no0
cd ancesNe_100to1000_taubuff50_to2000ya
cut -f 2-39 dice.simulations1 > ../ancesNe_100to1000_taubuff50_to2000ya_no0/dice.simulations1
cut -f 2-39 dice.simulations2 > ../ancesNe_100to1000_taubuff50_to2000ya_no0/dice.simulations2
cut -f 2-39 dice.simulations3 > ../ancesNe_100to1000_taubuff50_to2000ya_no0/dice.simulations3
cut -f 2-39 dice.simulations1 > ../ancesNe_100to1000_taubuff50_to2000ya_no0/dice.simulations4
```

The output is then visualised in [multidice_Rvisualisation.R](multidice_Rvisualisation.R)
