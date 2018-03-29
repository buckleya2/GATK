#!/bin/bash

#set filepaths
input="${tmp}/${short}.I.B.bam"
out="${filepath}/${short}.gvcf"

#run haplotype caller in gvcf mode
java -Xmx17g -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T HaplotypeCaller \
-R ${ref} \
-I ${input} \
-nct 3 \
--dbsnp ${dbsnp}  \
-L ${exons} \
-ip 100 \
--emitRefConfidence GVCF \
--variant_index_type LINEAR \
--variant_index_parameter 128000 \
-o ${out}

bgzip -f ${out}
tabix -f -p vcf ${out}.gz
