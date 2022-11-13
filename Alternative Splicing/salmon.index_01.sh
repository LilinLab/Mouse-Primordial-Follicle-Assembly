#!/bin/bash
export PATH=/data/zhangli/software/salmon-1.9.0_linux_x86_64/bin:$PATH
ref_fastq="/data/zhangli/Oocyte/salmon/ref/mm10_trans_genome.fa"
cd /data/zhangli/Oocyte/salmon
salmon index -t ${ref_fastq} -i Mouse.mm10.samlon.index
