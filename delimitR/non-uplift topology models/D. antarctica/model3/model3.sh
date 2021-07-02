#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=model3_antarctica
#SBATCH --partition=large
#SBATCH --time=25:00:00
#SBATCH --mem=10G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXX
#SBATCH --cpus-per-task=8


./fsc26 -t model3.tpl -e model3.est -m -n500000 -L40 -c8 -B12 --removeZeroSFS -M --multiSFS
