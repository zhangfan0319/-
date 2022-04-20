#!/bin/bash
vcftools --gzvcf rawVariants.SNP.vcf.gz --not-chr Z --recode --out filter
plink --vcf filter.recode.vcf --snps-only --allow-extra-chr --chr-set 40 --geno 0.05 --maf 0.01  --nonfounders --make-bed --set-missing-var-ids @:#  --out QC2 
plink --bfile QC2 --indep-pairwise 50 5 0.2 --allow-extra-chr --chr-set 40 --make-founders --out QC2_Indep_SNP
plink --bfile QC2 --extract QC2_Indep_SNP.prune.in --make-bed --allow-extra-chr --chr-set 40 --out IndepSNP ##提取独立SNP位点
plink --bfile IndepSNP --allow-extra-chr --chr-set 40 --recodeA --out pop
cat pop.raw |awk '{print $1,$2,$3,$4,$5,$6}' > ID.txt
