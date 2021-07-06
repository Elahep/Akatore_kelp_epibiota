#/usr/bin/env R

source("Multi-DICE-1.0.1.R")
library("bigmemory")
library("EnvStats")
library("abc")
library(ggplot2)

multidice_inference<-function(analysis_name ,path_multidice_files=".", num.haploid.samples=38 ,num.partitions =1 ,output_folder = "/home/ludovic.dutoit/repos/softwares/MultiDICE/",tol=0.05,vector_original_files=c("~/repos/mahuika/earthquake_multidice/original_SFS/antarctica_MAFpop0.obs","~/repos/mahuika/earthquake_multidice/original_SFS/Chiton_MAFpop0.obs","~/repos/mahuika/earthquake_multidice/original_SFS/Limnoria_MAFpop0.obs","~/repos/mahuika/earthquake_multidice/original_SFS/poha_MAFpop0.obs"),species= c("antarctica","Chiton_MAF","Limnoria_MAF","poha")) { 
  ###PARAMETERS EXPLANATION
  
  #analysis_name<-c("allnomaffiltering") ###PREFIX FOR OUTPUT, no need to be present in input
  #path_multidice_files<-"/home/ludovic.dutoit/repos/softwares/MultiDICE/R"# PATH TO THE MULTIDICE FOLDER WITH THE MULTIDICE SIMULATION FILES (i.e. dice.simulation1 etc...)
  #vector_original_files<-c("~/repos/mahuika/earthquake_multidice/original_SFS/antarctica_MAFpop0.obs","~/repos/mahuika/earthquake_multidice/original_SFS/Chiton_MAFpop0.obs","~/repos/mahuika/earthquake_multidice/original_SFS/Limnoria_MAFpop0.obs","~/repos/mahuika/earthquake_multidice/original_SFS/poha_MAFpop0.obs") # ABSOLUTE PATH OR RELATIVE FROM WITHIN PATH PATH_MULTIDICE_FILES
  #num.haploid.samples=38 #NUM HAPLOID SAMPLES FOR dice.aSFS()
  #num.partitions =1#NUM PRTITIONS FOR dice.aSFS()
  #output_folder = "/home/ludovic.dutoit/repos/softwares/MultiDICE/" # ONLY ABSOLUTE PATH TO OUTPUT FOL;DER FOR THIS ANALYSIS
  #tol=0.05 # percentage of simulations to be retaines in abc object
  #species= c("antarctica","Chiton_MAF","Limnoria_MAF"","poha")# the target species in the order their SFS are passed to vector_original_files for plotting legends purposes only
  

  setwd(path_multidice_files)
  num.taxa = length(vector_original_files)
  
  #Convert the data
  print("Read data...")
  sumstat = dice.aSFS(num.sims=100000, num.taxa=num.taxa, num.haploid.samples=num.haploid.samples, num.partitions =num.partitions)
  target  = dice.aSFS(num.sims=1, num.taxa=num.taxa, num.haploid.samples=num.haploid.samples,  num.partitions =num.partitions,input.files=vector_original_files)
  ##Read the parameter matrix
  psi.tau<-as.vector(read.table("dice.sims.hyper.draws.psi.tau",h=F,col.names=c("psi.tau")))
  pulse.values.tau<-as.vector(read.table("dice.sims.hyper.draws.pulse.values.tau",h=F,col.names=c("pulse.values.tau")))
  zeta.tau.1<-as.vector(read.table("dice.sims.hyper.draws.zeta.tau.1",h=F,col.names=c("zeta.tau.1")))
  print("EXPECTED WARNING:")
  abc.object = abc(target=target, sumstat=sumstat,tol=0.05,method="rejection",param=cbind(psi.tau,pulse.values.tau,zeta.tau.1)) ##THINK ABOUT THIS, ONLY THOSE 3
  summary(abc.object)
  print("... DONE Reading data")
  print("Creating outputs...")
  
  #########Quick plotting for two stats
  correct = data.frame(values=pulse.values.tau[which(abc.object$region==T),1])
  correct$type="top 5 percent"
  hyperprior = data.frame(values=pulse.values.tau[,1])
  hyperprior$type="hyperprior"
  toplot<-rbind(correct,hyperprior)
  
  ##STAT1 pulse.values.tau
  
  ggplot(toplot, aes(values, fill = type)) + geom_density(alpha = 0.2) + theme( # Remove panel border
    panel.border = element_blank(),  
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_blank())+xlab("Time of expansion")+ylab("Density")
  
  ggsave(paste(output_folder,"/",analysis_name,"_pulse.values.tau.pdf",sep=""),
         plot = last_plot())  
  
  ##STAT2 zeta.tau
  correct = data.frame(values=zeta.tau.1[which(abc.object$region==T),1])
  correct$type="top 5 percent"
  correct_table<-as.matrix(cbind(rownames(as.matrix(unlist(table(correct)))),unlist(table(correct))[,1]),          rep("top 5 percent",4))
  hyperprior = data.frame(values=zeta.tau.1[,1])
  hyperprior$type="hyperprior"
  hyperprior_table<-as.matrix(cbind(rownames(as.matrix(unlist(table(hyperprior)))),unlist(table(hyperprior))[,1]),          rep("hyperprior",4))
  correct_table[,2]<-as.numeric(correct_table[,2])/sum(as.numeric(correct_table[,2]))
  hyperprior_table[,2]<-as.numeric(hyperprior_table[,2])/sum(as.numeric(hyperprior_table[,2]))
  
  toplot_table<-rbind(correct_table,hyperprior_table)
  toplot_table<-cbind(toplot_table,rep(c("top 5 percent","hyperprior"),each=4))
  colnames(toplot_table)<-c("zeta.tau","value","type")
  toplot_table<-as.data.frame(toplot_table)
  toplot_table$value<-as.numeric(as.character(toplot_table$value))
  ggplot(toplot_table, aes(x=zeta.tau,y=value ,fill = type)) +  geom_bar(position="dodge", stat="identity",alpha=0.2,color="black")+ylim(0,0.5) +theme( 
    panel.border = element_blank(),  
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_blank()) +xlab("Fraction of co-expanding taxa")+ylab("Proportion")
  ggsave(paste(output_folder,"/",analysis_name,"_pulse.zeta.tau_hist.1.pdf",sep=""),
         plot = last_plot())  
  
  ###########Make two dataframes, one prior and one hyperprior, with 3 stats values.
  top5percent<-cbind(zeta.tau.1[which(abc.object$region==T),1],pulse.values.tau[which(abc.object$region==T),1])
  colnames(top5percent)<-c("zeta.tau.1","pulse.values.tau")
  hyperprior<-cbind(zeta.tau.1,pulse.values.tau)
  colnames(hyperprior)<-c("zeta.tau.1","pulse.values.tau")
  sum_analysis<-summary(abc.object)
  #Write the output
  write.table(as.matrix(sum_analysis),paste(output_folder,"/",analysis_name,"_table_summary_distrib.txt",sep=""),sep="\t",quote=F,row.names=T)
  write.table(top5percent,paste(output_folder,"/",analysis_name,"__table top_",tol*100,"percent.txt",sep=""),sep="\t",quote=F,row.names=F)
  write.table(hyperprior,paste(output_folder,"/",analysis_name,"_table_hyperprior.txt",sep=""),sep="\t",quote=F,row.names=F)
  print(paste("all output in", output_folder,"with prefix",analysis_name))
  
  ###PCA 
  pdf(paste(output_folder,"/",analysis_name,"PCA_combinedSFS.pdf",sep=""))
  PCA=princomp(rbind(abc.object[[2]],target),scores=T)
  plot(PCA$scores[,1],PCA$scores[,2],pch=19,cex=0.05,xlab="PC Axis 1",ylab="PC Axis 2")
  points(PCA$scores[dim(PCA$scores)[1],1],PCA$scores[dim(PCA$scores)[1],2],col="red",pch=19,cex=0.4)
  dev.off()
  
  #PCA on individual SFS
  
  
  sumstat_sfs = c()
  for (file in grep("dice.simulations",dir(path_multidice_files),value=T)
  ){
    sumstat_sfs<-rbind(sumstat_sfs,read.table(paste(path_multidice_files,file,sep="/"))[which(abc.object$region==T),])
    
  }
  target_sfs<- c()
  for (file in vector_original_files){
    target_sfs<-rbind(target_sfs,read.table(file,skip=2))
  }
  print(head(target_sfs))
  print(dim(target_sfs))
  print(head(sumstat_sfs))
  print(dim(sumstat_sfs))
  
  pdf(paste(output_folder,"/",analysis_name,"PCA_individualSFS.pdf",sep=""))
  PCA=princomp(rbind(target_sfs,sumstat_sfs),scores=T)
  plot(PCA$scores[,1],PCA$scores[,2],pch=19,cex=0.01,xlab="PC Axis 1",ylab="PC Axis 2")
  points(PCA$scores[1:dim(target_sfs)[1],1],PCA$scores[1:dim(target_sfs)[1],2],col="red",pch=19,cex=0.4)
  dev.off()
  
  pdf(paste(output_folder,"/",analysis_name,"PCA_individualSFS_tracing_species.pdf",sep=""))
  PCA=princomp(rbind(target_sfs,sumstat_sfs),scores=T)
  plot(PCA$scores[,1],PCA$scores[,2],pch=19,cex=0.01,xlab="PC Axis 1",ylab="PC Axis 2")
  points(PCA$scores[1:dim(target_sfs)[1],1],PCA$scores[1:dim(target_sfs)[1],2],col=rainbow(dim(target_sfs)[1]),pch=19,cex=0.4)
  legend("bottomright",col=rainbow(dim(target_sfs)[1]),species,pch=19)
  dev.off()
  
}

## Main program
#Original SFS files available on request to ellie.parvizi@gmail.com or dutoit.ludovic@gmail.com
dir.create("ancesNe_100to1000_taubuff50_to2000yano0INFERENCE")
multidice_inference("ancesNe_100to1000_taubuff50_to2000yano0" ,path_multidice_files="ancesNe_100to1000_taubuff50_to2000yano0INFERENCE/",tol=0.05,vector_original_files=c("original_SFS/SFSprop/antarctica_MAFpop0no0.obs_prop","~/repos/mahuika/earthquake_multidice/original_SFS/SFSprop/Chiton_MAFpop0no0.obs_prop","~/repos/mahuika/earthquake_multidice/original_SFS/SFSprop/Limnoria_MAFpop0no0.obs_prop","~/repos/mahuika/earthquake_multidice/original_SFS/SFSprop/poha_MAFpop0no0.obs_prop"),species= c("antarctica","Chiton","Limnoria","poha") )
