#!/bin/bash

#set filepaths
infile="${bamin}"
out="${filepath}/${short}.indel.list"


java -Xmx17g  -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T RealignerTargetCreator \
-R ${ref} \
-I ${infile} \
-known ${mills} \
-L ${exons} \
-ip 100 \
-o ${out}

