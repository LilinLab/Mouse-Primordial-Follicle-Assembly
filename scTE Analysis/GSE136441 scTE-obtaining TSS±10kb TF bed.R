###Id1、Figla、Sohlh1、Lhx8、Wt1、Prdm9、Egr1
setwd("D:/Oocyte/data/GSE136441/scTE")
mm.bed=read.table("mm.bed.txt",sep="\t",header=F)

######load gtf file
library("rtracklayer")
gtf1 <- rtracklayer::import('genes.gtf')
gtf_df <- as.data.frame(gtf1)
dim(gtf_df )# 1771112      25
gene.lo=which(gtf_df[,7]=="gene")
gene.gtf=gtf_df[gene.lo,]
dim(gene.gtf)
gene.gtf[grep("Figla",gene.gtf[,12]),c(1:3,5)]


TEbedFun=function(focus.gene){
	focus.start=gene.gtf[grep(focus.gene,gene.gtf[,12]),c(1:3,5)][,2]-10000
	focus.end=gene.gtf[grep(focus.gene,gene.gtf[,12]),c(1:3,5)][,3]+10000
	focus.chr=paste0("chr",gene.gtf[grep(focus.gene,gene.gtf[,12]),c(1:3,5)][,1])
	temp.bed=mm.bed[which(mm.bed[,1]==intersect(focus.chr,mm.bed[,1])),]
	lo1=which(as.numeric(temp.bed[,2])>=focus.start)
	lo2=which(as.numeric(temp.bed[,3])<=focus.end)
	keep.lo=intersect(lo1,lo2)
	temp.bed=as.matrix(temp.bed[keep.lo,])
	focus.lo=rownames(temp.bed)
	lo=c()
	for (i in 1:nrow(temp.bed)){
		temp.lo=which(mm.bed[,4]==temp.bed[i,4])
		lo=c(lo,temp.lo)	
	}
	lo=unique(lo)
	other.lo=setdiff(lo,focus.lo)
	new.name=paste0("OTHER.",as.character(mm.bed[other.lo,4]))
	result.bed=as.matrix(mm.bed)[,-c(7:8)]
	result.bed[other.lo,4]=new.name
	return(result.bed)
}

table(as.character(mm.bed[,4]))[grep("AT_rich",names(table(as.character(mm.bed[,4]))))]
table(as.character(mm.bed[,4]))[grep("B1_Mur1",names(table(as.character(mm.bed[,4]))))]


Figla=TEbedFun("Figla")
Lhx8=TEbedFun("Lhx8")
Sohlh1=TEbedFun("Sohlh1")
Setdb1=TEbedFun("Setdb1")
Hes1=TEbedFun("Hes1")
Hmgb3=TEbedFun("Hmgb3")

###output
write.table(Figla,"Figla.bed.txt",sep="\t",col.names=F,row.names=F,quote=F)
write.table(Lhx8,"Lhx8.bed.txt",sep="\t",col.names=F,row.names=F,quote=F)
write.table(Sohlh1,"Sohlh1.bed.txt",sep="\t",col.names=F,row.names=F,quote=F)
write.table(Setdb1,"Setdb1.bed.txt",sep="\t",col.names=F,row.names=F,quote=F)
write.table(Hes1,"Hes1.bed.txt",sep="\t",col.names=F,row.names=F,quote=F)
write.table(Hmgb3,"Hmgb3.bed.txt",sep="\t",col.names=F,row.names=F,quote=F)
######

