#!/bin/bash
#SBATCH --account=XXXXX
#SBATCH --job-name=fscsims_p
#SBATCH --partition=large
#SBATCH --time=24:00:00
#SBATCH --mem=5G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/Lim18_Nesmall_Tupwide/delimitR.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXX
#SBATCH --cpus-per-task=10

module load R
srun Rscript fastsimcoalsims.R
