#!/bin/bash

#set filepaths
export input="${filepath}/${short}.raw.vcf.gz"
export recal="${filepath}/${short}.VQSR.snp.recal"
export tranche="${filepath}/${short}.VQSR.snp.tranches"
export out="${tmp}/${short}.rawsnp.vcf.gz"


java -Xmx18g -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T ApplyRecalibration \
-R ${ref} \
-input ${input} \
-recalFile ${recal} \
-tranchesFile ${tranche} \
-o ${out} \
-L ${exons} \
# I used TS filter level 99.5 ( reccomended )
--ts_filter_level 99.5 \
-nt 3 \
-mode SNP

bgzip -f  ${out}
tabix -f ${out}.gz
mv ${out}*  ${filepath}


