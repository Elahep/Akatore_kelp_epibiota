#!/bin/bash
#SBATCH --account=uoo02782
#SBATCH --job-name=4-recolnth
#SBATCH --partition=large
#SBATCH --time=25:00:00
#SBATCH --mem=10G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=elahe.parvizi91@yahoo.com
#SBATCH --cpus-per-task=8


./fsc26 -t model1.tpl -e model1.est -m -n500000 -L40 -c8 -B12 --removeZeroSFS -M --multiSFS
