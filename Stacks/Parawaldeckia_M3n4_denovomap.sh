#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=PM3n4
#SBATCH --partition=large
#SBATCH --time=34:00:00
#SBATCH --mem=20G
#SBATCH --output=/nesi/project/XXXX/Durv/EP3/Para/m3M3n4/M3n4.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=8

#=======Load the module/software Environment
module load Stacks
module load VCFtools

##======My_Commands================

denovo_map.pl --samples /nesi/project/XXXX/Durv/EP3/Para --popmap /nesi/project/XXXXX/Durv/EP3/Para/m3M3n4/Parapopmap3.txt -o /nesi/project/XXXXX/Durv/EP3/Para/m3M3n4/ -M 3 -n 4 -m 3 -r 0.7 -X "populations: --max-obs-het 0.6 --write-random-snp --vcf"

vcftools --vcf populations.snps.vcf --min-meanDP 5 --max-meanDP 70 --recode --recode-INFO-all
mv out.recode.vcf depth_filtered.vcf
vcftools --vcf depth_filtered.vcf --max-missing 0.39 --recode --recode-INFO-all
mv out.recode.vcf depth_maxmiss39.vcf

