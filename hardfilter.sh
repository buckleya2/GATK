#!/bin/bash

java -Xmx17g -jar ${GATK} \
    -T VariantFiltration \
    -R ${ref} \
    -V ${filepath}/${short}.raw.snp.vcf \
    --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \
    --filterName "my_snp_filter" \
    -o ${filepath}/${short}.filtered_snps.vcf


java -Xmx17g -jar ${GATK} \
    -T VariantFiltration \
    -R ${ref} \
    -V ${filepath}/${short}.raw.indel.vcf \
    -L ${exons} \
    --filterExpression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" \
    --filterName "my_indel_filter" \
    -o ${filepath}/${short}.filtered_indels.vcf

