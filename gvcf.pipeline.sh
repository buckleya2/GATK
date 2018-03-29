#!/bin/bash
#$ -S /bin/bash
#$ -l h_vmem=8G
#$ -l h_rt=20:00:00
#$ -l h_cpu=30:00:00
#$ -j y
#$ -o /nrnb/users/abuckley/regroup_gvcf/out
#$ -pe smp 3

####
# pipeline to jointly genotype mutltiple gVCFs
# takes in a custom genotype gvcf script that specifies each gVCF
# outputs multiple VCFs at different stages of filtering
# short.raw.vcf = unfiltered raw variants
# short.rawsnp.vcf = unfiltered raw variants with SNP VQSR scores
# short.VQSR.vcf = unfiltered raw variants with both SNP and indel VQSR scores
# short.VQSR.PASS.vcf = final filtered VCF
####

# source config file that contains paths to all files, tools used by pipeline
source /nrnb/users/abuckley/scripts/GATK_pipeline/config

# specify the path to the input sorted dedupped BAM,
# a short name for the final VCF,
# and a path to output the final file

short="INS_FILENAME"
outpath="INS_OUTFILE_PATH"
filepath="${outpath}/${short}"

# make folder for final gvcf and output data
mkdir -p ${filepath}

#make tmp storage folder on node
mkdir -p /tmp/abuckley/${short}
export tmp="/tmp/abuckley/${short}"

export filepath=${filepath}
export short=${short}

#################################
### customize this script!!!! ###
#################################

# joint genotyping custom script for your samples
echo "start genotype GVCF"
${scripts_dir}/genotype.gvcf.sh
echo "end genotype GVCF"

#####################
#### hard filters ####

# split raw vCF into SNPs and indels
# outputs two new VCFs
echo "start split VCF"
${scripts_dir}/selectvars.sh
echo "end split VCF"

# apply separate hard filters to SNPs and indels
# outputs new VCFs with filter labels
echo "start hard filtering"
${scripts_dir}/hardfilter.sh
echo "end hard filtering"

# combines SNP and indel VCFs
# outputs combined VCF with SNP and indel filter labels
echo "start VCF combine"
${scripts_dir}/combine.variants.sh
echo "end VCF combine"

# select PASS variants from VCF
# outputs a new VCF with only PASS variants
echo "begin variant filtering"
${scripts_dir}/filter.vars.hard.sh
echo "end variant filtering"


##############
#### VQSR ####

# run SNP VQSR
# outputs a table of VQSR scores for each SNP
# outputs a table with cutoff values
echo "begin SNP VQSR" 
${scripts_dir}/snp.varrecal.sh
echo "end SNP VQSR"

# apply SNP VQSR filter with a specified sensitivity level
# outputs a new VCF with filter labels added
echo "begin apply SNP VQSR"
${scripts_dir}/snp.applyrecal.sh
echo "end apply SNP VQSR"

# run indel VQSR
# outputs a table of VQSR scores for each indel
# outputs a table with cutoff values
echo "begin indel VQSR"
${scripts_dir}/indel.varrecal.sh
echo "end indel VQSR"

# apply indel VQSR filter with a specified sensitivity level
# outputs a new VCF with filter labels added
echo "begin apply indel VQSR"
${scripts_dir}/indel.applyrecal.sh
echo "end apply indel VQSR"

# select PASS variants from VCF
# outputs a new VCF with only PASS variants
echo "begin variant filtering"
${scripts_dir}/filter.vars.sh
echo "end variant filtering"


rm -rf ${tmp}
