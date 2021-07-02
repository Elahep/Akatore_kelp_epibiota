#!/bin/bash
#SBATCH --account=XXXXX
#SBATCH --job-name=fscsims_p
#SBATCH --partition=large
#SBATCH --time=20:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/XXXXXX/Onito/delimitR/poh18_Nesmall_Tupwide/delimitR.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=8

module load R
srun Rscript fastsimcoalsims.R
