#!/bin/bash

#set filepaths
export path="${filepath}/${short}.rawsnp.vcf.gz"
export recal="${filepath}/${short}.VQSR.indel.recal"
export tranche="${filepath}/${short}.VQSR.indel.tranches"
export out="${tmp}/${short}.VQSR.vcf"

mkdir /tmp/${short}
tmp="/tmp/${short}"

java -Xmx17g -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T ApplyRecalibration \
-nt 3 \
-R $ref \
-input ${path} \
-recalFile ${recal} \
-tranchesFile ${tranche} \
-o ${out} \
-L ${exons} \
# used a more strict cutoff of TS 95 for indels
--ts_filter_level 95.0 \
-mode INDEL

bgzip ${out}
tabix ${out}.gz
mv ${out}*  ${filepath}


