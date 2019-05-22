# MAST-Script-Suite
A series of R scripts to facilitate organization, display, and analysis of large amounts of genetic marker data. These scripts accomplish this by comparing and plotting positions of both physical basepair positions and linkage cM positions for each marker, calculating polymorphisms between individuals that have genotyping data, 



Script Instructions:

##########################################

Smart_Basic_MAST and Basic_MAST:
Function:
These scripts map all the markers across all chromosomes in a file by both cM and basepair position if the file is prepared correctly.

Requirements:
To use these scripts, you need 1 external .csv file. It needs to have at least 4 columns, containing respectively the marker names, the marker chromosome, the marker centimorgan position in a linkage/consensus map, and the marker physical position in basepairs.

Formatting:
The file should be formatted like the screenshot below, with the crucial headings being “CHR”, “bp.pos” (standing for basepair positions), and “cM.pos” (standing for centimorgan position).
The markers in this example file are ordered, but importantly, they do not have to be, the script will correctly subset the data and plot it regardless of order.

Smart vs. Manual:
The Basic_MAST script plots out each chromosome individually, which can be useful under certain circumstances, but requires manual adaptation for non-wheat organisms.
The Smart_Basic_MAST script has a single loop that will plot out every 

Running the scripts:
Open R or R Studio, ensure that the working directory and file names in the script coincide with the location and files you want to access, and run the code. Ensure that the read.csv command retains the “,header=TRUE” statement, as this is critical in denoting the vectors.

#################################################

Smart_Double_MAST and Double_MAST
Function:
These scripts plot 2 series of markers from two files, one over the other, in different colors, for every chromosome. While theoretically, any 2 series of can be plotted, generally this is most useful for highlighting a specific subset of markers, or comparing 2 maps.

Requirements:
To use these scripts, you need 2 external .csv files. Each containing a list of markers  with chromosome data, cM positions and basepair positions, as with the file for Basic_MAST.

Formatting:
The formatting of the .csv has the same requirements as Basic_MAST, for both files.
For Smart_Double_MAST, the script should function without notable alterations for any organism or map, but for ordinary Double_MAST, the boundaries of the graphs and the chromosome names will need to be manually changed to match your organism and map in question. For this script, it is vital to fix the X and Y limits of the graph in place, or the plotting of the second series will be scaled separately from the first.

Running the scripts:
This is the same as in Basic_MAST.
Open R or R Studio, ensure that the working directory and file names in the script coincide with the location and files you want to access, and run the code. Ensure that the read.csv command retains the “,header=TRUE” statement, as this is critical in denoting the vectors.


####################################

UP_MAST and Smart_UP_MAST
Acronym: Useful Polymorphic Markers Around Segregating Traits

Function:
These scripts identify polymorphic markers between any two individuals. Those polymorphic markers are then output into a separate .csv file that can be browsed. Then the scripts make chromosome plots, background markers are plotted by both physical position and linkage position, then the polymorphic markers between the 2 individuals are plotted on top of them in a separate color. Then on top of those plots, there is the optional plotting of labeled vertical lines, denoting the physical positions of specific loci of interest, and optionally labeling the genotypic state of each of these 2 individuals at that locus.

Requirements: 3 .csv files
File 1 = all markers on the chromosome with the same format as the Basic_MAST file.
File 2 = A marker call database file, with marker names, marker chromosomes, marker basepair positions, marker cM position, and genotyping data from multiple (at least 2) genotypes/cultivars/accessions.
File 3 = a file that highlights specific loci. 

These 3 files are technically independent, and this script can be run without file 1, or without file 2, or without file 3.
Formatting:
File 1 should be formatted as the files for Basic_MAST and Double_MAST were.

File 2 should have the first 4 columns formatted as File 1 is, but should then have the columns for each genotype. Genotyping values (the results of a given marker for a given genotype) should be in 0/1/2 format, where 0 and 2 represent homozygous opposing SNP/marker calls, and 1 represents a heterozygous marker call. See the example below.

File 3 (optional) needs marker/loci names, chromosome positions, basepair positions of the locus, a color that the locus will be marked in, an offset value (in cM, used for adjusting labels up and down for visibility on the graph in crowded circumstances), and optionally, genotyping data on the locus for any genotype you want to examine. The labels must be spelled consistently between the headings and the script.
File 3 does not include a cM column, and its input is not required to be (though can be) specific markers, it merely requires specific loci, though the column is labeled Markers.

Running the Scripts:
In the code, type in the names (exact spelling and capitalization) of two genotypes from your database in sheet 2 and/or sheet 3 where it is requested for Genotype1, and Genotype2.
Then ensure that the commands in the script are correctly referencing the working directory, and the 3 file names.
Run the script, the output should be in 2 files, a .csv of the polymorphic markers, and a .pdf of the plots. Both of those files will include the names of the 2 genotypes that were examined.
Some warnings will occur, where the script will have attempted to plot empty vectors, but these should not be concerning, and the data should be correctly plotted if the formatting was correct.

