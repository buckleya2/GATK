#!/bin/bash
#$ -S /bin/bash
#$ -l h_vmem=8G
#$ -l h_rt=20:00:00
#$ -l h_cpu=30:00:00
#$ -j y
#$ -o /nrnb/users/abuckley/regroup_gvcf/out
#$ -pe smp 3

####
# main pipeline to run GATK on a single WXS sample
# takes in a sorted, dedupped BAM file as input
# writes 2 intermediate BAMs to /tmp:
# short.I.bam = BAM with indels realigned
# short.I.B.bam = BAM with indels realigned and new base quality scores
# both of these files will be deleted during the pipeline
# final output is gVCF for each sample
####
# source config file that contains paths to all files, tools used by pipeline
source /nrnb/users/abuckley/scripts/GATK_pipeline/config

# specify the path to the input sorted dedupped BAM,
# a short name for the sample,
# and a path to output the final file

export short="INS_FILENAME"
export outpath="INS_OUTFILE_PATH"
export bamin="INS_BAM"
export filepath="${outpath}/${short}"

# make folder for final gvcf and output data
mkdir -p ${filepath}

#make tmp storage folder on node
mkdir -p /tmp/abuckley/${short}
export tmp="/tmp/abuckley/${short}"

export filepath=${filepath}
export short=${short}

# find indel regions to realign
# produces a file with indel region coordinates
echo "begin find indels"
${scripts_dir}/find.indels.sh
echo "end find indels"

# realign indel regions
# produces a new BAM file with realigned indel regions
echo "begin indel realignment"
${scripts_dir}/indel.realign.sh
echo "end indel realignment"

# recalibrate base quality scores
# produces a file with new base scores
echo "begin recalibrate bases"
${scripts_dir}/recalibrate.bases.sh
echo "end recalibate bases"

# updates base scores in BAM file
# outputs new BAM file
echo "begin apply recalibration"
${scripts_dir}/apply.recalibration.sh
echo "end apply recalibration"

# genotyper
# outputs gVCF
echo "begin haplotype caller"
${scripts_dir}/haplotypecaller.sh
echo "end haplotype caller"

# delete tmp folder
rm -rf ${tmp}
