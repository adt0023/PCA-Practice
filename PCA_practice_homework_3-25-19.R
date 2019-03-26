#Recreate (most of) the example outlined here: https://www.datacamp.com/community/tutorials/pca-analysis-r 
#But using the iris data (load by data(“iris”)), or use one of the fake datasets in the BMS_793_PCA.Rmd.  Be sure to practice git in R studio.
data("iris")
#exclude species because non-numeric
iris.pca<-prcomp(iris[,c(-5)],center=TRUE,scale. = TRUE)
summary(iris.pca)
str(iris.pca)
library(devtools)
library(ggbiplot)

#Read about the following dataset presented here: https://www.kaggle.com/costalaether/yeast-transcriptomics

#Download the transcriptomics data from here: https://www.kaggle.com/costalaether/yeast-transcriptomics#SC_expression.csv
#And do PCA on the data.  There are no meaningful labels yet, so just download the file, load it into R, and run prcomp() or princomp().  The data is on Slack or the drive (in the data folder) if you don’t want to create an account.

#Relabel some of the columns in the dataset from 3 above using a more meaningful identifier from here: https://www.kaggle.com/costalaether/yeast-transcriptomics#conditions_annotation.csv

#If time, recreate (some) of the NMDS tutorial here: https://jonlefcheck.net/2012/10/24/nmds-tutorial-in-r/
#Using the dune dataset in the vegan package (after loading vegan by library(vegan), load data by data(“dune”).)

