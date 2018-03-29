#!/bin/bash

#set filepaths
export input1="${bamin}"
export input2="${filepath}/${short}.indel.list"
export out="${tmp}/${short}.I.bam"

#realign indel sites
java -Xmx18g  -Djava.io.tmpdir=${tmp}  -jar ${GATK} \
-T IndelRealigner \
-R ${ref} \
-I ${input1} \
-targetIntervals ${input2} \
-known ${mills} \
-o ${out}


