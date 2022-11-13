#!/bin/bash
#$ -N zl
#$ -o /data/zhangli/PBS-out
#$ -e /data/zhangli/PBS-out
#$ -j yes
#$ -cwd
#$ -S /bin/bash
SRR=$1
cd /data/zhangli/GSE136441/
export PATH=/data/zhangli/software/sratoolkit.2.11.0-centos_linux64/bin:$PATH
fastq-dump --gzip --split-files ${SRR} -O /data/zhangli/GSE136441/${SRR}.fastq/
