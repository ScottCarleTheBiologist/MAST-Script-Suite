###############Program: Smart_Basic_Mast
########Author: Scott Carle
###Script Language: R

###Use this script if you want to compare the genetic positions of a linkage map to the positions of a physical map.
##No packages are necessary to run this script, only base R commands.

###Begin Code:
####Define the name of your file

Filename<-("Example_MAP")

########input data
####set your working directory, change this to wherever you're storing your R input and output files

setwd("C:/ExampleDirectory")

###Prepare your input file
###Columns Needed: | Marker Names | CHR | bp.pos | cM.pos | 
##Marker Names should be self-explanatory, each marker has a unique name. The markers don't need to be sorted into any particular order, but all columns must align, with the data across each 'row' corresponding with this listed marker.
##CHR is short hand for chromosome, and will need to contain the name of the chromosome that the marker in question is located on for your organism.
##cM.pos is the distance along the chromosome in centimorgans according to the linkage map/consensus map that you're using for this purpose.
##bp.pos is the distance along the chromosome in basepairs that each given marker occurs at according to the genomic alignment you're referencing

###Important note, sometimes studies will find that a given marker occurs in multiple locations. For our study, we ommitted any markers that did this. However, if you chose to include markers that occur in multiple locations you'd need to have separate rows in your .csv file for each occurance of the marker.

####We're going to define your input file as Sheet1 in the code, and upload it below. 

Sheet1<-read.csv("Example_Basic_MAST_1.csv",header=TRUE)

###########This section pulls out each chromosome as a separate subset, so that each one can be plotted individually. If you didn't do this, all the data from all the chromosomes would get plotted on top of eachother in a giant mess.
######If you are using an organism other than wheat, you will need to redefine the number of these commands and rename the different subsets and 'CHR' labels to fit your organism.
CHRLIST<-sort(unique(Sheet1$CHR))
CHRLIST
i<-1

pdf(paste(Filename,".pdf",sep=""))
for(i in c(1:length(CHRLIST)))
{
subCHR<-Sheet1[c(Sheet1$CHR==CHRLIST[i]),]
plot(subCHR$cM.pos~subCHR$bp.pos,main=paste(CHRLIST[i]),ylab="cM",xlab="Basepairs")
}
dev.off()

#####the above section creates a .pdf file with all of your specified chromosomes plotted out. 
##If you're using an organism other than wheat, you'll need to change the number of chromosomes and the names of them.
##The first command creates the PDF, and will plot a graph of each chromosome on 1 page of it.
##Each subsequent plot command creates a new page, and plots the basepair position along the X-axis, and the cM position along the Y-axis
##The .pdf file will not be created until you run the dev.off() command at the end.