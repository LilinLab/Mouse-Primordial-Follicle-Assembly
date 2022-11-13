#!/bin/bash
dir_aracnejar=/data/zhangli/TFtest/ARACNe-AP-master/dist/
input=/data/zhangli/Oocyte/GSE136441/aracne/input
output=/data/zhangli/Oocyte/GSE136441/aracne/output
##1: MI threshold
java -Xmx5G -jar $dir_aracnejar/aracne.jar -e $input/GSE136441.data.txt  -o $output --tfs $input/mousetf.txt --pvalue 1E-8 --seed 1 --calculateThreshold

##2.cycle 100
for i in {1..100}
do
java -Xmx5G -jar $dir_aracnejar/aracne.jar -e $input/GSE136441.data.txt  -o $output --tfs $input/mousetf.txt --pvalue 1E-8 --seed $i
done

##3.consolidate bootstraps in the output folder
java -Xmx5G -jar $dir_aracnejar/aracne.jar -o $output --consolidate

##4.downstream analysis: R  viper analysis