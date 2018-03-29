#!/bin/bash

input="${filepath}/${short}.hardfilter.vcf.gz"
out="${filepath}/${short}.hardfilter.PASS.vcf.gz"

zcat ${input} | grep "#\|PASS" | bgzip > ${out}
tabix ${out}


