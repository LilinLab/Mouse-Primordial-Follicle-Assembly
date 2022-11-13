#!/bin/bash
source activate R4.0
########################(1)samtools-2.10 version
export PATH=/data/zhangli/software/samtools-1.10/bin:$PATH
########################(2)scTE
export PATH=/data/zhangli/software/scTE-master/bin/:$PATH
##parament
cd /data/zhangli/GSE136441/mm10
##zcat mm10.rmsk.txt.gz |  awk -F'\t' '{print $6,$7,$8,$11,$2,$10}' | sed 's/\ /\x09/g' > mm10.bed
scTE_build -te mm10.bed -gene genes.gtf -o mm10 -g mm10
##scTE_build -te Figla.bed -gene genes.gtf -o Figla -g mm10
