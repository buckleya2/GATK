#!/bin/bash

#set filepaths
input="${tmp}/${short}.I.bam"
out="${filepath}/${short}.recal.table"

#create recal file
java -Xmx17g -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T BaseRecalibrator \
-nct 3 \
-R ${ref}  \
-I ${input} \
-L ${exons} \
-ip 100 \
-knownSites ${mills} \
-knownSites ${dbsnp} \
-o ${out}

