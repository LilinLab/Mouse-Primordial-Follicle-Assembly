setwd("D:/Oocyte/data/GSE136441/")
library(RandomWalkRestartMH)
library(igraph)


##########add triangle parameter in igraph
mytriangle <- function(coords, v=NULL, params) {
  vertex.color <- params("vertex", "color")
  if (length(vertex.color) != 1 && !is.null(v)) {
    vertex.color <- vertex.color[v]
  }
  vertex.size <- 1/200 * params("vertex", "size")
  if (length(vertex.size) != 1 && !is.null(v)) {
    vertex.size <- vertex.size[v]
  }

  symbols(x=coords[,1], y=coords[,2], bg=vertex.color,
          stars=cbind(vertex.size, vertex.size, vertex.size),
          add=TRUE, inches=FALSE)
}
# clips as a circle
add_shape("triangle", clip=shapes("circle")$clip,
                 plot=mytriangle)
##########################################
##RWSFun：input
##（1）TF2gene pairs (data.frame) 
##（2）seed genes (character)
RWSFuc=function(aracne,focus.gene){
	edge.df=aracne
	vertex <- unique(c(as.character(edge.df$Regulator),as.character(edge.df$Target)))
	net <- graph_from_data_frame(d = edge.df, vertices = vertex, directed = T)
	PPI_MultiplexObject <- create.multiplex(net,Layers_Name=c("PPI"))
	AdjMatrix_PPI <- compute.adjacency.matrix(PPI_MultiplexObject)
	AdjMatrixNorm_PPI <- normalize.multiplex.adjacency(AdjMatrix_PPI)
	SeedGene <-intersect(focus.gene,aracne$Target)##seed genes
	#intersect(unique(as.character(germ.aracne)),SeedGene )
	RWR_PPI_Results <- Random.Walk.Restart.Multiplex(AdjMatrixNorm_PPI,
	PPI_MultiplexObject,SeedGene)

	TopResults_PPI <-
		create.multiplexNetwork.topResults(RWR_PPI_Results,PPI_MultiplexObject,
		k=15)
	V(TopResults_PPI)$name

	#par(mar=c(0.1,0.1,0.1,0.1))
	col.p=rep(0,length(V(TopResults_PPI)$name))
	col.p[match(SeedGene, V(TopResults_PPI)$name)]="yellow"
	col.p[-match(SeedGene, V(TopResults_PPI)$name)]= "#FA8072"

	#plot(TopResults_PPI, vertex.label.color="black",vertex.frame.color="#ffffff",
	#vertex.size= 20, edge.curved=.2,
	#vertex.color = col.p, edge.color="blue",edge.width=0.8)


	compg.edges <- as.data.frame(get.edgelist(TopResults_PPI))
	compg.edges.network <- graph_from_data_frame(compg.edges, directed=T) 
	plot(compg.edges.network )
	par(mar=c(0.1,0.1,0.1,0.1))
	shape=rep(0,length(V(compg.edges.network)$name))
	shape[-match(SeedGene, V(compg.edges.network)$name)]="triangle"
	shape[match(SeedGene, V(compg.edges.network)$name)]= "circle"

	plot(compg.edges.network, vertex.label.color="black",vertex.frame.color="#ffffff",
     		vertex.size= rep(15,length(unique(c(as.matrix(compg.edges)[,1],as.matrix(compg.edges)[,2])))), edge.curved=.2,
     		vertex.color = col.p, edge.color="blue",edge.width=0.8, vertex.shape=shape)
}

#RWSFuc(aracne.list[[1]],c("Prdm9","Dmc1","Rad51ap2","Meioc","Spdya","Meiob","Msh5"))
#RWSFuc(aracne.list[[2]],c("Prdm9","Dmc1","Rad51ap2","Meioc","Spdya","Meiob","Msh5"))
#RWSFuc(aracne.list[[4]],c("Ybx2","Pdk1","Mcm8","Pten"))

All.aracne=read.table("network.txt",sep="\t",header=T)##TF-gene pairs from aracne analysis
dim(All.aracne)
All.aracne=All.aracne[,1:2]

focus.gene=c("Atg5","Becn1","Atg12","Atg14","Ulk2","Atg101")
RWSFuc(All.aracne,focus.gene)