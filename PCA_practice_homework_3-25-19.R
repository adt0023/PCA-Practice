#What is PCA
#Using linear regression
#Line vectors from PCA plot indicate variation, correlated datasets are going to have proximal arrows
#rotation from PCA represents factor by which plots were rotated to fit axes

#Recreate (most of) the example outlined here: https://www.datacamp.com/community/tutorials/pca-analysis-r 
#But using the iris data (load by data(“iris”)), or use one of the fake datasets in the BMS_793_PCA.Rmd.  Be sure to practice git in R studio.
data("iris")
#exclude species because non-numeric
iris.pca<-prcomp(iris[,c(-5)],center=TRUE,scale. = TRUE)
summary(iris.pca)
str(iris.pca)
cor(iris[,-5])
cor(iris.pca$x)
library(devtools)
library(ggbiplot)
ggbiplot(iris.pca)
ggbiplot(iris.pca, labels = rownames(iris))
ggbiplot(iris.pca, labels = rownames(iris$Species))
ggbiplot(iris.pca, labels = iris$species) #why that works and iris doesn't is beyond me
ggbiplot(iris.pca,ellipse=TRUE,  labels=rownames(iris), groups=iris$Species) #adding ellipses
ggbiplot(iris.pca,ellipse=TRUE,choices=c(3,4),   labels=rownames(iris), groups=iris$Species) #adding labels
ggbiplot(iris.pca,ellipse=TRUE,choices=c(3,6),   labels=rownames(iris), groups=iris$Species) #only goes to highest PCA/n of datasets
ggbiplot(iris.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(iris), groups=iris$Species) #scaling
ggbiplot(iris.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1, var.axes = FALSE,  labels=rownames(iris), groups=iris$Species) #removing arrows

ggbiplot(iris.pca, obs.scale=1,var.axes=FALSE)
ggbiplot(iris.pca,ellipse=TRUE,circle=TRUE, groups=iris$Species) 
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
ggbiplot(yeast.pca, ellipse=TRUE, circle=TRUE,var.scale=1, var.axes = FALSE)

#Removing outliers, starting with searching text for where outliers are
grep("^__align",rownames(yeast_SC_expression))
grep("^__no",rownames(yeast_SC_expression))
grep("^__ambig",rownames(yeast_SC_expression))
#Removing outliers
yeast.new <- yeast_SC_expression[-c(696,4381,5114,5664),]
yeast.pca <- prcomp(yeast.new[,-1], center = TRUE,scale. = TRUE)
ggbiplot(yeast.pca,var.axes=FALSE,labels=rownames(yeast.new))
ggbiplot(yeast.pca, var.axes=FALSE,labels=rownames(yeast_SC_expression))

## calc the proportions for each observation
#yeast1 <- aggregate(.~X,data=yeast.data, FUN = sum,na.rm=TRUE, na.action=NULL)
temp <- colSums(yeast_SC_expression[,-1])
yeast.data.prop <- yeast_SC_expression
yeast.data.prop[,-1] <- sweep(yeast.data.prop[,-1],MARGIN=2,temp,"/")
yeast.new <- yeast.data.prop[apply(yeast.data.prop[, -1], MARGIN = 1, function(x) any(x > 0.1)), ]

#x<-which(yeast.data.prop[,-1]<0.5)
#length(x)
yeast.pca <- prcomp(yeast.new[,-1], center = TRUE,scale. = TRUE)
ggbiplot(yeast.pca,var.axes=FALSE)

#subsetting by ID
yeast.sub <- yeast.data.prop[,yeast.covar$ID[c(76,80,88)]]
yeast.pca <- prcomp(yeast.sub[,-1], center = TRUE,scale. = TRUE)
ggbiplot(yeast.pca,scale.obs=2,var.axes=TRUE)
cor(yeast.sub)


#Relabel some of the columns in the dataset from 3 above using a more meaningful identifier from here: https://www.kaggle.com/costalaether/yeast-transcriptomics#conditions_annotation.csv
yeast_labeled<- data.frame(c(yeast_SC_expression,yeast_conditions))


#-NMDS (Multidimensional scaling)
#If time, recreate (some) of the NMDS tutorial here: https://jonlefcheck.net/2012/10/24/nmds-tutorial-in-r/
#Using the dune dataset in the vegan package (after loading vegan package and library(vegan), load data by data(“dune”).)
#Here is a good reference: <https://rpubs.com/Shaahin/MDS_1> and another <http://personality-project.org/r/mds.html>.

#trying to find relative positions/relationships betweens cities distance-wise
#MDS finds differences between objects, not correlation
city.location <- cmdscale(cities, k=2)    #ask for a 2 dimensional solution
round(city.location,0)        #print the locations to the screen
plot(city.location,type="n", xlab="Dimension 1", ylab="Dimension 2",main ="cmdscale(cities)")   #put up a graphics window
text(city.location,labels=names(cities))  #put the cities into the map

city.location <- -city.location
plot(city.location,type="n", xlab="Dimension 1", ylab="Dimension 2",main ="cmdscale(cities)")    #put up a graphics window
text(city.location,labels=names(cities))     #put the cities into the map

#non-metric MDS looks at scaling/ranking instead of absolute distances
#Plots can vary each time ran
tst <- monoMDS(cities)  ## from the vegan package
plot(tst)

data("dune")
ord <- metaMDS(dune)
#ordiplot(ord)
ordiplot(ord,type="n")
orditorp(ord,display="species",col="red",air=0.01)
orditorp(ord,display="sites",cex=1.25,air=0.01)
abline(h=0);abline(v=0)
#goodness of fit
stressplot(ord)
ord$stress
#add environmental variables
data(dune.env)
attach(dune.env)  #careful!
plot(ord, disp="sites", type="n")
#ordihull(ord, Management, col=1:4, lwd=3)
ordiellipse(ord, Management, col=1:4, kind = "ehull", lwd=3)
#ordiellipse(ord, Management, col=1:4, draw="polygon")
ordispider(ord, Management, col=1:4, label = TRUE)
points(ord, disp="sites", pch=21, col="red", bg="yellow", cex=1.3)
#add more environmental variables
ord.fit <- envfit(ord ~ A1 + Management, data=dune.env, perm=999)
ord.fit
ordiplot(ord, type ="n")
orditorp(ord,display="sites",cex=1.25,air=0.01)
plot(ord.fit)
ordiellipse(ord, Management, col=1:4, kind = "se", lwd=3, conf=0.95)

ordisurf(ord, A1, add=TRUE)

#If we have time we'll play with the data here: <http://geoffreyzahn.com/nmds-example/>

