#!/bin/bash
#PBS -q hotel
#PBS -l nodes=2:ppn=2
#PBS -l walltime=:00:20:00
#PBS -N tf_binding.sh

cd ~/code/biom262-hw1/data
module load biotools

#Exercise 1
# Filter the tf.bed file for only the NFKB\n
awk '{if($4=="NFKB") print}' tf.bed > tf.nfkb.bed

#Exercise 2
# Filter only the rows of the gtf file that contain the features of type "transcript"\n
awk '{if($3=="transcript") print}' gencode.v19.annotation.chr22.gtf > gencode.v19.annotation.chr22.transcript.gtf

#Exercise 3
# Use bedtools to find promoters (2000 bases upstream of gene)\n
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome -l 2000 -r 0 -s > gencode.v19.annotation.chr22.transcript.promoter.gtf

#Exercise 4
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf -b tf.nfkb.bed >gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

#Exercise 5
bedtools getfasta -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -s -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta

<<<<<<< HEAD

#Excercise 6
echo 'NFKB promoters matching canonical sequence'
grep GG[AG][AG][AGCT][AGCT][CT][CT]CC gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | wc -l
echo 'total NFKB promoters'
grep ^[ACGT] gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | wc -l


echo "Hello I am a message in standard out (stout)"
echo "Hello I am a message in standard error (stderr)" >&2
