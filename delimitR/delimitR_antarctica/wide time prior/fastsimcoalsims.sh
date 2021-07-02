#!/bin/bash
#SBATCH --account=uoo02782
#SBATCH --job-name=fscsims
#SBATCH --partition=large
#SBATCH --time=55:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/uoo02782/Onito/delimitR/ant12_Nesmall_Tupwide/Nesmall_Tupwideb12.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ellie.parvizi@gmail.com
#SBATCH --cpus-per-task=8

cd /nesi/nobackup/uoo02782/Onito/delimitR/ant12_Nesmall_Tupwide

module load R
srun Rscript fastsimcoalsims.R
