#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=fscsims
#SBATCH --partition=large
#SBATCH --time=55:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/ant12_Nesmall_Tupwide/Nesmall_Tupwideb12.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXXXX
#SBATCH --cpus-per-task=8

module load R
srun Rscript fastsimcoalsims.R
