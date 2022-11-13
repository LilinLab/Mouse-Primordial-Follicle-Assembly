#!/bin/bash
cd /data/zhangli/GSE136441/
pathfile=$(ls /data/zhangli/GSE136441/ | grep ".fastq")##SRR12102135.fastq    SRR12102136.fastq   SRR12102137.fastq    SRR12102138.fastq
for file in $pathfile
do
	array=${file/.fastq/}
	#echo $array
	
	qsub -cwd -l vf=120G,p=2 -V cellranger.sh $array
done
