# pipeline
解释各个文件的作用


data_prepare.sh

数据的原始准备，为Gmatrix.R文件提供读入文件ID.txt和pop.raw


Gmatrix.R

该文件为构建基因组选择矩阵的R脚本，通过读入ID.txt和pop.raw进行矩阵计算，输出文件为Ginv.csv


gblup.R

该文件的输入文件分别为Ginv.csv、ID.txt、pheno.txt(该文件为生产数据)，并且需要导入rntransform.R、ztransform.R文件进行数据正态转化，最终经过计算得到的文件分别为trait_var.txt、trait_h2.txt、GEBV_trait.csv


multiple_trait.sh

该文件的目的是为了传参数到gblup.R文件里，通过替换{trait} 完成多个性状的计算，并且利用shell脚本实现并行计算
