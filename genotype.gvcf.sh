#!/bin/bash

### to customize, insert paths to your gVCFs ###

#run genotype gvcfs
java -Xmx17g -jar ${GATK} \
-T GenotypeGVCFs \
-R ${ref} \
-nt 3 \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.0.gvcf.gz \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.1.gvcf.gz \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.2.gvcf.gz \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.3.gvcf.gz \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.4.gvcf.gz \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.5.gvcf.gz \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.6.gvcf.gz \
--variant /nrnb/users/abuckley/regroup_gvcf/REGROUP.7.gvcf.gz \
-o ${filepath}/${short}.raw.vcf

bgzip ${filepath}/${short}.raw.vcf
tabix ${filepath}/${short}.raw.vcf.gz
