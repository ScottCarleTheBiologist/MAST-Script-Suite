#############Program Smart_UP_MAST (Smart Useful Polymorphic Markers Around Segregating Traits)
########Author: Scott Carle
###Script Language: R

#Code Start
##define the 2 genotypes you're interested in, these names must be consistent with the genotype column names in Sheet2 and Shee3

GenotypeName1<-("Martinez and Jernigan")
GenotypeName2<-("List2")

Genotype1<-make.names(GenotypeName1)
Genotype2<-make.names(GenotypeName2)

########input data
###########Set your working directory to where you have your files for R stored

setwd("E:/")

###Markers along the Y axis, Genotypes along the X axis
####Sheet1 isn't technically essential, but gives a better idea of all the points you know, we used Wang et al. 2014 and Chinese Spring Genome positions

###Important note for if you don't have the data for either Sheet1, Sheet2, or Sheet3, the program can run without all the sheets
##however, you must make sure that you don't define the variable at all. If you don't have the data, skip the line of code that stores the sheet

Sheet1<-read.csv("WangConsensusVIWGSC2.0.csv",header=TRUE)

######Sheet2 is the database of the markers calls on markers you have actually run on the lines you're interested in.
###Columns Needed: | Marker Names | CHR | cM.pos | bp.pos | ......Genotype Names with data below........
####Genotyping data below each column needs to be in a 0/1/2 format, as in, allele AA should be entered in as 0, allele BB should be entered in as 2, and allele AB should be entered in as 1.
##Because we cannot be certain whether the progeny from a cross where a parent had a heterozygote allele will be heterozygous, this algorithm does not identify them as such. 
##For species and crossing schemes with high levels of heterozygosity, a modification of this algorithm may prove useful, however, for wheat and many of other species of self-pollinating crops, low levels of heterozygosity are the norm.

#Sheet2<-read.csv("File2 QAM UP_MAST.csv",header=TRUE)

####Sheet3 is designed to look at specific markers that you have either a linkage map distance, or a physical position for, but not both
###The intent is that these markers represent important known traits, they will be labled.

Sheet3<-read.csv("Martinez and Jernigan Sheet_3.csv",header=TRUE)

##################This section calculates polymorphisms
###for our first attempt, we are going to have the same reference file for both Sheet1 and Sheet2
sub.GenotypeCalc<-Sheet2[,1:4]
sub.GenotypeCalc<-cbind(sub.GenotypeCalc,Sheet2[,Genotype1])
sub.GenotypeCalc<-cbind(sub.GenotypeCalc,Sheet2[,Genotype2])

sub.GenotypeCalcdiff<-sub.GenotypeCalc[,5]-sub.GenotypeCalc[,6]
sub.GenotypeCalcdiff[sub.GenotypeCalcdiff==-2]=2
sub.GenotypeCalc<-cbind(sub.GenotypeCalc,sub.GenotypeCalcdiff)

sub.GenotypeCalc2<-sub.GenotypeCalc[c(sub.GenotypeCalc$sub.GenotypeCalcdiff==2),]

##########here a .csv file is created with the list of all polymorphic markers between your 2 parents.
#This file will be saved to your working directory under the name of "[Parent1] by [Parent2]

write.csv(sub.GenotypeCalc2[,1:7], file=paste(Genotype1," by ",Genotype2," Polymorphic Markers.csv",sep=""))

##expanded plots
#This code starts the creation of the .pdf file, and will finish once all commands in this section have been successfully run. Look for the file in your working directory with the name of "[Parent1] by [Parent2].pdf"

CHRLIST<-sort(unique(c(if(exists("Sheet1")){as.character(Sheet1$CHR)},if(exists("Sheet2")){as.character(Sheet2$CHR)},if(exists("Sheet3")){as.character(Sheet3$CHR)})))
i<-1
pdf(paste(Genotype1," by ",Genotype2,".pdf",sep=""))
for(i in c(1:length(CHRLIST)))
{
  if(exists("Sheet1")){sub.1<-Sheet1[c(Sheet1$CHR==CHRLIST[i]),]}
  if(exists("Sheet2")){sub.2<-sub.GenotypeCalc2[c(sub.GenotypeCalc2$CHR==CHRLIST[i]),]}
  if(exists("Sheet3")){sub.3<-Sheet3[c(Sheet3$CHR==CHRLIST[i]),]}
  
  if(exists("Sheet1")){if(length(sub.1$bp.pos)!=0){plot(sub.1$cM.pos~sub.1$bp.pos,col="grey",xlim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))),ylim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})))),main=CHRLIST[i],ylab="cM",xlab="Basepairs")}}
  if(exists("Sheet1")&exists("Sheet2")){if((length(sub.1$bp.pos)!=0)&(length(sub.2$bp.pos)!=0)){par(new=T)}}
  if(exists("Sheet2")){if(length(sub.2$bp.pos)!=0){plot(sub.2$cM.pos~sub.2$bp.pos,col="red",xlim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))),ylim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})))),main=CHRLIST[i],ylab="cM",xlab="Basepairs")}}
  
  if(exists("Sheet3")){
    if(length(sub.3$bp.pos)!=0){abline(v=sub.3$bp.pos,col=sub.3$Color)}
    if(length(sub.3$bp.pos)!=0){text(sub.3$bp.pos,sub.3$offset,pos=3,labels=sub.3$Markers,cex=.6)}
    
    if(length(sub.3$bp.pos)!=0){if(any(colnames(sub.3)==GenotypeName1)){text(sub.3$bp.pos,y=10,pos=3,labels=sub.3[,GenotypeName1])}}
    if(length(sub.3$bp.pos)!=0){if(any(colnames(sub.3)==GenotypeName2)){text(sub.3$bp.pos,y=10,pos=1,labels=sub.3[,GenotypeName2])}}
    
    if(length(sub.3$bp.pos)!=0){if(any(colnames(sub.3)==Genotype1)&any(colnames(sub.3)==Genotype2)){
      if(any(sub.3[,Genotype1] != sub.3[,Genotype2]))
      {text(0,1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})),pos=4,labels=paste(GenotypeName1," above and ",GenotypeName2," below",sep=""))
      }}}
  }
}
dev.off()
