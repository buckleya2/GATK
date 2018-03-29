#!/bin/bash

#set filepaths
export path="${filepath}/${short}.raw.vcf.gz"
export out="${filepath}/${short}.VQSR.snp.recal"
export out2="${filepath}/${short}.VQSR.snp.tranches"
mkdir /tmp/${short}
tmp="/tmp/${short}"

java -Xmx18g -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T VariantRecalibrator \
-R ${ref} \
-input ${path} \
-recalFile ${out} \
-tranchesFile ${out2} \
-rscriptFile ${filepath}/${short} \
-nt 6 \
--target_titv 3.3 \
-tranche 100.0 -tranche 99.9 -tranche 99.5 -tranche 99.0 -tranche 90.0 \
-resource:1000G,known=false,training=true,truth=false,prior=10.0 ${X1000G} \
-resource:dbsnp,known=true,training=false,truth=false,prior=2.0 ${dbsnp} \
-resource:hapmap,known=false,training=true,truth=true,prior=15.0 ${hapmap} \
-resource:omni,known=false,training=true,truth=true,prior=12.0 ${omni} \
-an QD \
-an MQ \
-an MQRankSum \
-an ReadPosRankSum \
-an FS \
-an SOR \
-an InbreedingCoeff \
--maxGaussians 6 \
-mode SNP \
-L ${exons} \


