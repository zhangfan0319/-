library(asreml)
library(data.table)
setwd("/storage-01/poultrylab1/zhangfan/work/VcfDataBase/gblup")
##读取数据
datag<-asreml.read.table("pheno.txt",header=TRUE,na.strings='NA')
id <- read.table("ID.txt",header = T," ")
##G逆矩阵
test <- fread("Ginv.csv",header=TRUE,sep=",")
rownames(test) <-test$V1
test <- as.matrix(test)
Ginv <- test[,-1]
attr(Ginv,"rowNames")<-as.character(id$IID)
attr(Ginv,"colNames")<-as.character(id$IID)
attr(Ginv,"INVERSE")<-TRUE

##表型数据正态化
source("/storage-01/poultrylab1/zhangfan/Genome/rntransform.R")
source("/storage-01/poultrylab1/zhangfan/Genome/ztransform.R")
ntra <- rntransform(datag$bw42_g,datag,family=gaussian)

####构建模型(固定效应里不能有缺失)
modelGBLUP <- asreml(fixed=ntra ~ 1 + Year + Batch + Sex,
                     random=~vm(IID2,Ginv),residual = ~idv(units),
                     workspace=128e06,
                     data=datag)
var <- summary(modelGBLUP)$varcomp
write.table(var,"trait_var.txt",append=T)
(h2<-vpredict(modelGBLUP,h2~V1/(V1+V2)))
write.table(h2,"trait_h2.txt",append=T)
BLUP <- summary(modelGBLUP,coef=TRUE)$coef.random
write.csv(BLUP,"GEBV_trait.csv")
