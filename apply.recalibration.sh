
#!/bin/bash

#set filepaths
path="${tmp}/${short}.I.bam"
path2="${filepath}/${short}.recal.table"
out="${tmp}/${short}.I.B.bam"

#print reads with recalibrated scores
java -Xmx17g -Djava.io.tmpdir=${tmp} -jar ${GATK} \
-T PrintReads \
-nct 3 \
-R ${ref}  \
-I ${path} \
-BQSR ${path2} \
-o ${out}



