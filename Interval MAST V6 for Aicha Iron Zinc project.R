#############Program Smart_UP_MAST (Smart Useful Polymorphic Markers Around Segregating Traits)
########Author: Scott Carle
###Script Language: R

#Code Start
##define the 2 genotypes you're interested in, these names must be consistent with the genotype column names in Sheet2 and Shee3

GenotypeName1<-("9.30.24 Changed 1 variable")
GenotypeName2<-("looking at a bromeliad")

Genotype1<-make.names(GenotypeName1)
Genotype2<-make.names(GenotypeName2)

########input data
###########Set your working directory to where you have your files for R stoRed

#setwd("C:\\Users\\a.djibowaziri\\Documents")
setwd("C:/Users/scott.carle/Downloads/Help with MAST/")
#setwd("C:\\Users\\a.djibowaziri\\Documents")
#setwd("E:/")

###Markers along the Y axis, Genotypes along the X axis
####Sheet1 isn't technically essential, but gives a better idea of all the points you know, we used Wang et al. 2014 and Chinese Spring Genome positions

###Important note for if you don't have the data for either Sheet1, Sheet2, or Sheet3, the program can run without all the sheets
##however, you must make sure that you don't define the variable at all. If you don't have the data, skip the line of code that stores the sheet

Sheet1<-read.csv("WangIWGSC2.0 Filter Final.csv",header=TRUE)
#Sheet1<-read.csv("WangIWGSC2.0.Filter.Final.csv",header=TRUE)

######Sheet2 is the database of the markers calls on markers you have actually run on the lines you're interested in.
###Columns Needed: | Marker Names | CHR | cM.pos | bp.pos | ......Genotype Names with data below........
####Genotyping data below each column needs to be in a 0/1/2 format, as in, allele AA should be enteRed in as 0, allele BB should be enteRed in as 2, and allele AB should be enteRed in as 1.
##Because we cannot be certain whether the progeny from a cross where a parent had a heterozygote allele will be heterozygous, this algorithm does not identify them as such. 
##For species and crossing schemes with high levels of heterozygosity, a modification of this algorithm may prove useful, however, for wheat and many of other species of self-pollinating crops, low levels of heterozygosity are the norm.

#Sheet2<-read.csv("TCAP Sheet 2 for MAST Paper Minimal Version.csv",header=TRUE)

####Sheet3 is designed to look at specific markers that you have either a linkage map distance, or a physical position for, but not both
###The intent is that these markers represent important known traits, they will be labled.

Sheet3<-read.csv("Sheet3.csv",header=TRUE)

Sheet4<-read.csv("Sheet4.csv",header=TRUE)

##################This section calculates polymorphisms
###for our first attempt, we are going to have the same reference file for both Sheet1 and Sheet2
#if(exists("Sheet2")){
#sub.GenotypeCalc<-Sheet2[,1:4]
#sub.GenotypeCalc<-cbind(sub.GenotypeCalc,Sheet2[,Genotype1])
#sub.GenotypeCalc<-cbind(sub.GenotypeCalc,Sheet2[,Genotype2])
#sub.GenotypeCalcdiff<-sub.GenotypeCalc[,5]-sub.GenotypeCalc[,6]
#sub.GenotypeCalcdiff[sub.GenotypeCalcdiff==-2]=2
#sub.GenotypeCalc<-cbind(sub.GenotypeCalc,sub.GenotypeCalcdiff)
#sub.GenotypeCalc2<-sub.GenotypeCalc[c(sub.GenotypeCalc$sub.GenotypeCalcdiff==2),]
##########here a .csv file is created with the list of all polymorphic markers between your 2 parents.
#This file will be saved to your working directory under the name of "[Parent1] by [Parent2]
#write.csv(sub.GenotypeCalc2[,1:7], file=paste(Genotype1," by ",Genotype2," Polymorphic Markers.csv",sep=""))
#}
##expanded plots
#This code starts the creation of the .pdf file, and will finish once all commands in this section have been successfully run. Look for the file in your working directory with the name of "[Parent1] by [Parent2].pdf"
Cexing<-2
linewidth<-4
CHRLIST<-sort(unique(c(if(exists("Sheet1")){as.character(Sheet1$CHR)},if(exists("Sheet2")){as.character(Sheet2$CHR)},if(exists("Sheet3")){as.character(Sheet3$CHR)})))
#CHRLIST<-c("1A",)
pdf(paste(Genotype1," by ",Genotype2,".pdf",sep=""),width=10,height=12)
i<-1
par(mfrow=c(1,1))
par(mar=c(5.1, 5.1, 4.1, 2.1))
#par(mfrow=c(1,1))
for(i in c(1:length(CHRLIST)))
{
  if(exists("Sheet1")){sub.1<-Sheet1[c(Sheet1$CHR==CHRLIST[i]),]}
  if(exists("Sheet2")){sub.2<-Sheet2[c(Sheet2$CHR==CHRLIST[i]),]}
  if(exists("Sheet3")){sub.3<-Sheet3[c(Sheet3$CHR==CHRLIST[i]),]}
  if(exists("Sheet4")){sub.4<-Sheet4[c(Sheet4$CHR==CHRLIST[i]),]}
if(exists("Sheet3")){sub.3effect<-sub.3$Effect}
if(exists("Sheet4")){sub.4effect<-sub.4$Effect}
miny<-0
if(exists("Sheet4")&length(na.omit(sub.4$bp.pos1))!=0){miny<-miny-20}
###might need additional contingency right below here, to specify if they exist
if(length(na.omit(sub.4effect))!=0|length(na.omit(sub.3effect))!=0){miny<-miny-20}  
  
  if(exists("Sheet1")){if(length(sub.1$bp.pos)!=0){
    plot(sub.1$cM.pos~sub.1$bp.pos,col="grey",xlim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))),ylim=c(miny,(1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})))),main=CHRLIST[i],ylab="cM",xlab="Basepairs",cex=Cexing,cex.axis=Cexing,cex.lab=Cexing,cex.main=Cexing,axes=FALSE)
    axis(side=1,cex.axis=Cexing)
    axis(side=2,tick=TRUE,at=c(0,50,100,150,200,250,300,350),labels=c(0,50,100,150,200,250,300,350),cex.axis=Cexing)
    }}
  
  if(exists("Sheet1")&exists("Sheet2")){if((length(sub.1$bp.pos)!=0)&(length(sub.2$bp.pos)!=0)){par(new=T)}}
  if(exists("Sheet2")){if(length(sub.2$bp.pos)!=0){plot(sub.2$cM.pos~sub.2$bp.pos,col="red",xlim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))),ylim=c(miny,(1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})))),main=CHRLIST[i],ylab="cM",xlab="Basepairs",cex=Cexing,cex.axis=Cexing,cex.lab=Cexing,cex.main=Cexing,axes=FALSE)}}
  
  if(exists("Sheet3")){
    if(length(sub.3$bp.pos)!=0){abline(v=sub.3$bp.pos,col = rgb(sub.3$Red,sub.3$Green,sub.3$Blue,1),lwd=linewidth)}
    if(length(sub.3$bp.pos)!=0){text(sub.3$bp.pos,sub.3$Offset,pos=3,labels=sub.3$Index,cex=0.5*Cexing,cex.axis=Cexing,cex.lab=Cexing,cex.main=Cexing)}
    
    if(length(sub.3$bp.pos)!=0){if(any(colnames(sub.3)==GenotypeName1)){text(sub.3$bp.pos,y=10,pos=3,labels=sub.3[,GenotypeName1])}}
    if(length(sub.3$bp.pos)!=0){if(any(colnames(sub.3)==GenotypeName2)){text(sub.3$bp.pos,y=10,pos=1,labels=sub.3[,GenotypeName2])}}
  }
   box(lwd=.5*linewidth,col="black")
    ##adding sheet 4 labels back in
    if(exists("Sheet4")){
      rect(-100000,-100,c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))),0,angle = 45,col = rgb(1,1,1,.8),border=NA)
      abline(h=0,col="black",lwd=linewidth)
      box(lwd=.5*linewidth,col="black")
    }
    if(exists("Sheet4")){
      if(length(sub.4$bp.pos1)!=0){rect(sub.4$bp.pos1,sub.4$Offset-1,sub.4$bp.pos2,sub.4$Offset+1,angle = 45,col = rgb(sub.4$Red,sub.4$Green,sub.4$Blue,.3),border=NA)}
    }
    if(exists("Sheet4")){
    #right below this is the plotting for sheet 4 text, with math to try to offset it correctly, could use tinkering
      #
    if(length(sub.4$bp.pos1)!=0){text(((rowSums(cbind(sub.4$bp.pos1,sub.4$bp.pos2))/2)-((1.2*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))*.02)),sub.4$Offset,pos=4,labels=sub.4$Index,cex=0.5*Cexing)}
    mtext("Flanking",at=-10,side=2,cex=.4*Cexing,line=2.6)
    mtext("Marker",at=-10,side=2,cex=.4*Cexing,line=2)
    mtext("Interval",at=-10,side=2,cex=.4*Cexing,line=1.4)
    }
    ###
    if(length(sub.3$bp.pos)!=0){if(any(colnames(sub.3)==Genotype1)&any(colnames(sub.3)==Genotype2)){
      if(any(sub.3[,Genotype1] != sub.3[,Genotype2]))
      {text(0,1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})),pos=4,labels=paste(GenotypeName1," above and ",GenotypeName2," below",sep=""))
      }}}
##3rd graph in the same graph, rescaling attempt 1 implemented
    if(na.omit(length(sub.4effect))!=0|length(na.omit(sub.3effect))!=0){
    abline(h=-20,col="black",lwd=.5*linewidth)
    abline(h=-40,col="black",lwd=.5*linewidth)

#effect graph code
    if(length(na.omit(sub.3$Effect))!=0){
    if(sum(is.na(sub.3$Effect))>0){sub.3<-sub.3[-is.na(sub.3$Effect),]}
    sub.3$Effect<-abs(as.numeric((sub.3$Effect))/(max(abs(as.numeric(na.omit(c(sub.4effect,sub.3effect)))))))
    sub.3$Effect<-(sub.3$Effect*17)+miny+1.5
    par(new=T)
    plot((sub.3$Effect)~sub.3$bp.pos,xlim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))),ylim=c(miny,(1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})))),main=CHRLIST[i],ylab="",xlab="",cex=.5*Cexing,cex.axis=Cexing,cex.lab=Cexing,cex.main=Cexing,col=rgb(sub.3$Red,sub.3$Green,sub.3$Blue,1),axes=FALSE)
    #mtext("LOD Score",at=-30,side=2,cex=.5*Cexing,line=2)
    mtext("LOD",at=-30,side=2,cex=.4*Cexing,line=2)
    mtext("Score",at=-30,side=2,cex=.4*Cexing,line=1.4)
    }
    if(length(na.omit(sub.4$Effect))!=0){
    if(sum(is.na(sub.4$Effect))>0){sub.4<-sub.4[-is.na(sub.4$Effect),]}
    sub.4$Effect<-abs(as.numeric((sub.4$Effect))/(max(abs(as.numeric(na.omit(c(sub.4effect,sub.3effect)))))))
    sub.4$Effect<-(sub.4$Effect*17)+miny+1.5
    par(new=T)
    plot((sub.4$bp.pos1+sub.4$bp.pos2)/2,(sub.4$Effect),xlim=c(0,(1.05*max(c(if(exists("Sheet1")){sub.1$bp.pos},if(exists("Sheet2")){sub.2$bp.pos},if(exists("Sheet3")){sub.3$bp.pos})))),ylim=c(miny,(1.05*max(c(if(exists("Sheet1")){sub.1$cM.pos},if(exists("Sheet2")){sub.2$cM.pos})))),main=CHRLIST[i],ylab="",xlab="",cex=.5*Cexing,cex.axis=Cexing,cex.lab=Cexing,cex.main=Cexing,col=rgb(sub.4$Red,sub.4$Green,sub.4$Blue,1),pch=0,axes=FALSE) 
    mtext("LOD",at=-30,side=2,cex=.4*Cexing,line=2)
    mtext("Score",at=-30,side=2,cex=.4*Cexing,line=1.4)
    mtext(min(abs(as.numeric(na.omit(c(sub.4effect,sub.3effect))))),side=2,line=1,at=miny+1.5,las=2,cex=.7*Cexing)
    mtext(max(abs(as.numeric(na.omit(c(sub.4effect,sub.3effect))))),side=2,line=1,at=miny+18.5,las=2,cex=.7*Cexing)
    segments(-100000000,miny+1.5,-15000000,miny+1.5,col="black",lwd=1)
    segments(-100000000,miny+18.5,-15000000,miny+18.5,col="black",lwd=1)
    #text(0,y=miny,labels=min(abs(as.numeric(na.omit(c(sub.4effect,sub.3effect))))))
    #text(0,y=miny+20,labels=max(abs(as.numeric(na.omit(c(sub.4effect,sub.3effect))))))
    }
    }

}
dev.off()
#TheLegend<-read.csv("PosterLegend.csv",header=TRUE)
#par(mfrow=c(1,1))
#barplot(c(1,1,1,1,1,1),names.arg=c("Falling Number","Baking","Grain","Flour","Milling","Preharvest Sprouting"),col=c(rgb(0,0,0),rgb(0.3,0.3,0),rgb(0.7,0.7,0),rgb(0.1,0.8,0.1),rgb(0.8,0.1,0.1),rgb(0,0.5,0.5)))

##########I think a few more contingencies are needed for wider applications, but this is working here.
