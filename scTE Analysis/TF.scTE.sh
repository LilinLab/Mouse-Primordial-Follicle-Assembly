#!/bin/bash
source activate R4.0
########################(1)samtools-2.10 version
export PATH=/data/zhangli/software/samtools-1.10/bin:$PATH
########################(2)scTE
export PATH=/data/zhangli/software/scTE-master/bin/:$PATH
##parament
SRR=$1
Cellranger=$2
TF=$3
#mkdir /data/zhangli/GSE136441/${TF}scTE
cd /data/zhangli/GSE136441/${TF}scTE
scTE -i /data/zhangli/GSE136441/${SRR}/${Cellranger}cellranger/outs/possorted_genome_bam.bam \
-o ${TF}.$Cellranger \
-x /data/zhangli/GSE136441/mm10/${TF}.exclusive.idx \
-CB CR -UMI UR \
--hdf5 True
