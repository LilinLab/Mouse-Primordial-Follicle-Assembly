#!/bin/bash
file=$1
array=$2

export PATH=/data/zhangli/software/salmon-1.9.0_linux_x86_64/bin:$PATH
cd /data/zhangli/Oocyte/salmon/bam
bamdir="/data/zhangli/Oocyte/GSE152407"
bam_dir1="/data/zhangli/Oocyte/GSE152407/${file}/${fastq}_1.fastq.gz"##SRR12005864_1.fastq.gz
bam_dir2="/data/zhangli/Oocyte/GSE152407/${file}/${fastq}_2.fastq.gz"
index="/data/zhangli/Oocyte/salmon/Mouse.mm10.samlon.index"

salmon quant -i ${index} -l IU -1 ${bamdir}/${file}/${array}_1.fastq.gz -2 ${bamdir}/${file}/${array}_2.fastq.gz --validateMappings -o $array.samlon