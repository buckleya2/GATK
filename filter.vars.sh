#!/bin/bash

input="${filepath}/${short}.VQSR.vcf.gz"
out="${filepath}/${short}.VQSR.PASS.vcf.gz"

zcat ${input} | grep "#\|PASS" | bgzip > ${out}
tabix ${out}


