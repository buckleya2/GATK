#!/bin/bash

export path="${filepath}/${short}.rawsnp.vcf.gz"
export out="${filepath}/${short}.VQSR.indel.recal"
export out2="${filepath}/${short}.VQSR.indel.tranches"

java -Xmx18g -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T VariantRecalibrator \
-R ${ref} \
-nt 6 \
-input ${path} \
-recalFile ${out} \
-tranchesFile ${out2} \
--maxGaussians 4 \
-tranche 99.5 -tranche 99.0 -tranche 95.0 -tranche 90.0 \
-resource:mills,known=false,training=true,truth=true,prior=12.0 ${mills} \
-resource:dbsnp,known=true,training=false,truth=false,prior=2.0 ${dbsnp} \
-an QD \
-an SOR \
-an ReadPosRankSum \
-an MQRankSum \
-an InbreedingCoeff \
-mode INDEL \
-L ${exons} \


