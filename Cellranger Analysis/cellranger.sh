#!/bin/bash
SRR=$1
cd /data/zhangli/GSE136441/${SRR}.fastq
export PATH=/share/wangjunhao/scseq/cellranger/cellranger-3.1.0:$PATH
cellranger count --id=${SRR}cellranger --fastqs=./ --sample=${SRR} --transcriptome=/share/references/reference-genome/mouse/cellranger/refdata-cellranger-mm10-3.0.0 --nosecondary
