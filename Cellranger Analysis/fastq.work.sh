#!/bin/bash
cd /data/zhangli/GSE136441/
pathfile=$(ls /data/zhangli/GSE136441/ | grep 'SRR')
for file in $pathfile
do
	#echo $file
	qsub -cwd -l vf=30G,p=2 -V fastq.sh $file
done
