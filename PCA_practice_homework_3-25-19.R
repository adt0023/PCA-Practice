#Recreate (most of) the example outlined here: https://www.datacamp.com/community/tutorials/pca-analysis-r 
#But using the iris data (load by data(“iris”)), or use one of the fake datasets in the BMS_793_PCA.Rmd.  Be sure to practice git in R studio.
data("iris")
#exclude species because non-numeric
iris.pca<-prcomp(iris[,c(-5)],center=TRUE,scale. = TRUE)
summary(iris.pca)
str(iris.pca)
library(devtools)
library(ggbiplot)
ggbiplot(iris.pca)
ggbiplot(iris.pca, labels = rownames(iris))
ggbiplot(iris.pca, labels = iris$species) #why that works and iris doesn't is beyond me
ggbiplot(iris.pca,ellipse=TRUE,  labels=rownames(iris), groups=iris$Species) #adding ellipses
ggbiplot(iris.pca,ellipse=TRUE,choices=c(3,4),   labels=rownames(iris), groups=iris$Species) #adding labels
ggbiplot(iris.pca,ellipse=TRUE,choices=c(3,6),   labels=rownames(iris), groups=iris$Species) #only goes to highest PCA/n of datasets
ggbiplot(iris.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(iris), groups=iris$Species) #scaling
ggbiplot(iris.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1, var.axes = FALSE,  labels=rownames(iris), groups=iris$Species) #removing arrows

ggbiplot(iris.pca, obs.scale=1,var.axes=FALSE)
#Read about the following dataset presented here: https://www.kaggle.com/costalaether/yeast-transcriptomics

#Download the transcriptomics data from here: https://www.kaggle.com/costalaether/yeast-transcriptomics#SC_expression.csv
#And do PCA on the data.  There are no meaningful labels yet, so just download the file, load it into R, and run prcomp() or princomp().
yeast_conditions<-read.csv("C:/Users/Andrew/Documents/R_files/kaggle_yeast/conditions_annotation.csv")
yeast_labels_CC<-read.csv("C:/Users/Andrew/Documents/R_files/kaggle_yeast/labels_CC.csv")
yeast_labels_MF<-read.csv("C:/Users/Andrew/Documents/R_files/kaggle_yeast/labels_MF.csv", row.names = NULL)
yeast_labels_BP<-read.csv("C:/Users/Andrew/Documents/R_files/kaggle_yeast/labels_BP.csv", row.names = NULL)
yeast_SC_expression<-read.csv("C:/Users/Andrew/Documents/R_files/kaggle_yeast/SC_expression.csv")
yeast.pca<-prcomp(yeast_SC_expression[,-1],center=TRUE,scale. = TRUE)
summary(yeast.pca)
ggbiplot(yeast.pca, labels = yeast_SC_expression$X)

#Relabel some of the columns in the dataset from 3 above using a more meaningful identifier from here: https://www.kaggle.com/costalaether/yeast-transcriptomics#conditions_annotation.csv
yeast_labeled<- data.frame(c(yeast_SC_expression,yeast_conditions))

#If time, recreate (some) of the NMDS tutorial here: https://jonlefcheck.net/2012/10/24/nmds-tutorial-in-r/
#Using the dune dataset in the vegan package (after loading vegan by library(vegan), load data by data(“dune”).)

