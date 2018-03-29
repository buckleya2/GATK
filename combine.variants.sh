#!/bin/bash

input1="${filepath}/${short}.filtered_indels.vcf"
input2="${filepath}/${short}.filtered_snps.vcf"
out="${filepath}/${short}.hardfilter.vcf"

java -Xmx17g -jar ${GATK} \
   -R ${ref} \
   -T CombineVariants \
   -V ${input1} \
   -V ${input2} \
   --genotypemergeoption UNSORTED \
   -o ${out}

bgzip ${out}
