#### shell 整合脚本 
Rscritp Gmatrix.R 
for i in bw42_g sfw_g sfr_% afw_g afr_% bmw_g bmr_% bmt_mm sf_N fac_% sft_mm ew dw fbl bw neck_len bl fcr rfi;
do
sed  s/trait/$i/g gblup.R > ${i}.R
Rscript ${i}.R &
done
wait
