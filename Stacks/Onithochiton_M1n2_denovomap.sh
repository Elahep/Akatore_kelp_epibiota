#!/bin/bash
#SBATCH --account=XXXX
#SBATCH --job-name=OM3n4
#SBATCH --partition=large
#SBATCH --time=35:00:00
#SBATCH --mem=10G
#SBATCH --output=/nesi/project/XXXXX/Durv/EP4/M1n2/M1n2.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=XXXXX
#SBATCH --cpus-per-task=8

#=======Load the module/software Environment
module load Stacks
module load VCFtools

##======My_Commands================

denovo_map.pl --samples /nesi/project/XXXX/Durv/EP4/M1n2 --popmap /nesi/project/XXXXX/Durv/EP3/EP4/M1n2/Onpopmap_noCamp4.txt -o /nesi/project/XXXXX/Durv/EP4/M1n2 -M 1 -n 2 -m 3 -r 0.7 -X "populations: --max-obs-het 0.6 --write-random-snp --vcf"

vcftools --vcf populations.snps.vcf --min-meanDP 5 --max-meanDP 70 --recode --recode-INFO-all
mv out.recode.vcf depth_filtered.vcf
vcftools --vcf depth_filtered.vcf --max-missing 0.39 --recode --recode-INFO-all
mv out.recode.vcf depth_maxmiss39.vcf

