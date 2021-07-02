#!/bin/bash
#SBATCH --account=XXXXX
#SBATCH --job-name=fscsims_p
#SBATCH --partition=large
#SBATCH --time=25:00:00
#SBATCH --mem=8G
#SBATCH --output=/nesi/nobackup/XXXXX/Onito/delimitR/poh18_Nesmall/delimitR.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXXXXXXXXX
#SBATCH --cpus-per-task=8

module load R
srun Rscript fastsimcoalsims.R
