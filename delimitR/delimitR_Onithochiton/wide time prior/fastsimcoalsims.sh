#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=simulation_O
#SBATCH --partition=large
#SBATCH --time=50:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/XXXX/Onito/delimitR/Onit12_Nesmall_Tupwide/delimitR.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=8

module load R
srun Rscript fastsimcoalsims.R
