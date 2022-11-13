source activate R4.0
python /data/zhangli/software/SUPPA-2.3/suppa.py generateEvents –h
cd /data/zhangli/Oocyte/Suppa
python /data/zhangli/software/SUPPA-2.3/suppa.py generateEvents \
-i  /share/references/reference-genome/mouse/cellranger/refdata-cellranger-mm10-3.0.0/genes/genes.gtf \
-o cellranger-mm10.events -e SE SS MX RI FL -f ioe

cd /data/zhangli/Oocyte/Suppa
awk 'FNR==1 && NR!=1 { while (/^<header>/) getline; } 1 {print}' *.ioe > mm10.all.events.ioe
wc -l mm10.all.events.ioe
