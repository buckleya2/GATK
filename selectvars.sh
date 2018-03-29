#!/bin/bash

input="${filepath}/${short}.raw.vcf.gz"
out="${filepath}/${short}.raw.snp.vcf"

java -Xmx17g -jar ${GATK} \
    -T SelectVariants \
    -R ${ref} \
    -V ${input} \
    -L ${exons} \
    -selectType SNP \
    -o ${out}


input="${filepath}/${short}.raw.vcf.gz"
out="${filepath}/${short}.raw.indel.vcf"

java -Xmx17g -jar ${GATK} \
    -T SelectVariants \
    -R ${ref} \
    -V ${input} \
    -L ${exons} \
    -selectType INDEL \
    -o ${out}

