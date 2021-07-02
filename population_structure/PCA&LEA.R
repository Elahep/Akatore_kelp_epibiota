rm(list=ls())
setwd("D:/chapters/epibiota")

library(vcfR)
library(poppr)
library(ggplot2)

##import the vcf file and convert it to a genelight object to be used by adegenet

data_vcf = read.vcfR("./*.vcf")
data_vcf  ##use to see the number of SNPs and missing data
popmap = read.table("./*_popmap.txt", header = F)

data_gl <- vcfR2genlight(data_vcf)
pop(data_gl) <- rep(popmap$V2)

##run PCA
data_pca <- glPca(data_gl, nf = 10)

##export list of eigen values and percentage variances for each PC-thanks to Felix Vaux for sharing this!

#eigen values for PCs
eig.val<-data_pca$eig
eig.val
#percentages of variance for each PC
eig.perc <- 100*data_pca$eig/sum(data_pca$eig)
eig.perc
eigen<-data.frame(eig.val,eig.perc)
eigen
#writing file with both
write.csv(eigen,file="./PCA/eigen-summary.csv",row.names=TRUE,quote=FALSE)

##retrieve the 10 PC scores to be used for plotting later
pca_scores <- as.data.frame(data_pca$scores)
pca_scores$pop <- pop(data_gl)
write.table(pca_scores, "./PCA/10PCs.txt")

##PCA plotting
ggplot(pca_scores, aes(PC1, PC2)) +
  geom_point(size=3, aes(colour=pca_scores$pop), alpha = 0.7, shape=19) +
    scale_color_manual(values = c("#3c4d0b", "#658114", "#e2be3d", "#ed5537","#90d796", "#5310f0")) +
  theme_classic()
##colors used in the manuscript for different clusters
#North Otago #3c4d0b
#Far North #658114
#Nearby North #e2be3d
#Uplift #ed5537
#South #90d796
#Catlins #5310f0

##running LEA to estimate individual ancestry coefficients and ancestral allele frequencies (snmf structure plots)

library(LEA)

##create LEA input file (.geno) from the vcf file. Using the function bellow, the .geno file will be created 
##and saved in the working directory.
data_LEA <- vcf2geno(input.file = "*.vcf", output.file = "data_LEA.geno")

##snmf clustering
projectalpha = NULL
projectalpha = snmf("data_LEA.geno", K = 1:10, repetitions = 50, entropy = T, CPU = 8, project = "new")

# plot cross-entropy criterion for all runs in the snmf project
plot(projectalpha, col = "maroon4", pch = 19, cex = 1.2)

##test alpha=1,10,100,1000 to check the stability of the minimal estimates of
##the cross-enthropy criterion. In general, smaller values of the criterion indicates
##indicates better algorithm output and estimates.

## select the best run for each K to be later used for plotting (best run = the run with the lowest cross enthropy among all repetitions)
best = which.min(cross.entropy(projectalpha, K = 4))

##I wanted to use pophelper to visaulize the structure bar plots, so I saved each "best" run and used them for plotting.
##All best runs (*.Q files from K=2 to K=10) should be saved in the same directory.

library(pophelper)


sfiles <- list.files(path=("./LEA/Qfiles"), full.names=T)
slist <- readQ(files=sfiles)

##By changing the value for "slist" and the number of colors in "clustercol" in this code, I plotted K=2 to K=10 and later 
##put all the K plots + the cross-enthropy plot together using the open-source vector graphics editor, Inkscape.
plotQ(qlist=slist[4],imgtype = "pdf",
       height = 1.5, clustercol = c("#90d796","#e2be3d","#658114","#3c4d0b","#ed5537"), dpi = 1200)






