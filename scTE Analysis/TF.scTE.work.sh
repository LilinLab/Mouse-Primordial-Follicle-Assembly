#!/bin/bash
pathfile=$(ls /data/zhangli/GSE136441/ | grep ".fastq")
for file in $pathfile
do
	array=${file/.fastq/}
	#echo $array
	#echo $file
	qsub -cwd -l vf=0G,p=1 -V TF.scTE.sh $file $array Sohlh2
done
