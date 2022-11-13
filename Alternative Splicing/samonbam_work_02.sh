#!/bin/bash
#cd /data/zhangli/Oocyte/GSE152407/
pathfile=$(ls /data/zhangli/Oocyte/GSE152407/| grep "SRR.*fastq")
for file in $pathfile
do
	#echo $file
	array=${file/.fastq/}
	#bam_dir1="/data/zhangli/Oocyte/GSE152407/${file}/${fastq}_1.fastq.gz"
	#echo $bam_dir1
	#echo $fastq
	qsub -cwd -l vf=50G,p=2 -V /data/zhangli/Oocyte/salmon/samonbam_02.sh $file $array
done

