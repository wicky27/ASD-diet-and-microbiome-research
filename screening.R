#转化matrix格式矩阵及数据归一化
#R 4.2.3
# 分辨率600像素 画布大小2300*1800
library(ComplexHeatmap)
install.packages("gridBase")
library(gridBase)
library(RColorBrewer)
library(circlize)
setwd("D:/CUHK2023FALL/HATCH COHORT/MR analysis")
GM_MRcorr <- read_excel("circle_MR_GM ASD.xlsx",sheet = "sum_p")
GM_MRcorr <- read_excel("circle_MR_GM ASD.xlsx",sheet = "reverse_p")
GM_MRcorr <- read_excel("circle_MR_GM ASD.xlsx",sheet = "bi_p")
GM_MRcorr$`MR Egger`<-as.numeric(GM_MRcorr$`MR Egger`)
GM_MRcorr$`Weighted median`<-as.numeric(GM_MRcorr$`Weighted median`)
GM_MRcorr$`Inverse variance weighted`<-as.numeric(GM_MRcorr$`Inverse variance weighted`)
GM_MRcorr$`Simple mode`<-as.numeric(GM_MRcorr$`Simple mode`)
GM_MRcorr$`Weighted mode`<-as.numeric(GM_MRcorr$`Weighted mode`)
GM_MRcorr$`MR Egger_`<-as.numeric(GM_MRcorr$`MR Egger_`)
GM_MRcorr$`Weighted median`<-as.numeric(GM_MRcorr$`Weighted median_`)
GM_MRcorr$`Inverse variance weighted_`<-as.numeric(GM_MRcorr$`Inverse variance weighted_`)
GM_MRcorr$`Simple mode_`<-as.numeric(GM_MRcorr$`Simple mode_`)
GM_MRcorr$`Weighted mode_`<-as.numeric(GM_MRcorr$`Weighted mode_`)
data<-GM_MRcorr
rownames(data)<-GM_MRcorr$GM
cir1<-as.matrix(data[,-1])
rownames(cir1)<-rownames(data)

GM_MRcorr <- read_excel("circle_MR_GM ASD.xlsx",sheet = "sum_beta")
data<-GM_MRcorr
rownames(data)<-GM_MRcorr$GM
cir1<-as.matrix(data[,-1])
rownames(cir1)<-rownames(data)
cir1<-t(scale(t(cir1)))

head(cir1) #查看数据#转化matrix格式矩阵及数据归一化
mycol=colorRamp2(c(-2.5, 0.3, 3.1),c("blue","white","red"))#设置legend颜色，范围；可从https://www.58pic.com/peisebiao/网站进行配色

mycol = colorRamp2(c(-1, 0, 1), c("#003399", "white", "red"))
mycol = colorRamp2(c(0,0.05, 1), c( "red","white","#003399")) #p value

#install.packages("dendextend")#改颜色
#install.packages("dendsort")#聚类树回调
library(dendextend)
library(dendsort)
circos.clear()

circos.par(gap.after=c(30),track.height = 0.1) #circos.par()调整圆环首尾间的距离，数值越大，距离越宽
circos.heatmap(cir1,col=mycol,dend.side="inside",#dend.side：控制行聚类树的方向，inside为显示在圆环内圈，outside为显示在圆环外圈
                              rownames.side="outside",#rownames.side：控制矩阵行名的方向,与dend.side相同；但注意二者不能在同一侧，必须一内一外
                              track.height = 0.08, #轨道的高度，数值越大圆环越粗 enough space for track index"3" 放大
                              rownames.col="black",
                              rownames.cex=0.19, #字体大小 enough space for track
                              rownames.font=1, #字体粗细
                              cluster=TRUE, #cluster=TRUE为对行聚类，cluster=FALSE则不显示聚类
                              dend.track.height=0.06, #调整行聚类树的高度 变小
                              dend.callback=function(dend,m,si){#dend.callback：用于聚类树的回调，当需要对聚类树进行重新排序，或者添加颜色时使用包含的三个参数：dend：当前扇区的树状图；m：当前扇区对应的子矩阵；si：当前扇区的名称
                                  color_branches(dend,k=1) #color_branches(dend,k=15,col=1:15):修改聚类树颜色#聚类树颜色改为1，即单色/黑色
                                })
lg=Legend(title="Exp",col_fun=mycol, grid_height = unit(0.05, "mm"),
          grid_width = unit(2, "mm"),
          gap = unit(0.05, "mm"),size = unit(0.05, "mm"),
                    direction = c("vertical")
                    #title_position= c('topcenter'),
)

grid.draw(lg)
#draw(lg, x = unit(0.9,"npc"), y = unit(0.5,"npc"), just = c("right","center"))#画在右边
#添加列名：

circos.clear()
circos.par(gap.after=c(30),track.height = 0.1) #circos.par()调整圆环首尾间的距离，数值越大，距离越宽
circos.heatmap(cir1,col=mycol,dend.side="inside",#dend.side：控制行聚类树的方向，inside为显示在圆环内圈，outside为显示在圆环外圈
               rownames.side="outside",#rownames.side：控制矩阵行名的方向,与dend.side相同；但注意二者不能在同一侧，必须一内一外
               track.height = 0.14, #轨道的高度，数值越大圆环越粗 enough space for track index"3" 放大
               rownames.col="black",
               rownames.cex=0.22, #字体大小 enough space for track
               rownames.font=1, #字体粗细
               cluster=TRUE, #cluster=TRUE为对行聚类，cluster=FALSE则不显示聚类
               dend.track.height=0.08, #调整行聚类树的高度 变小
               dend.callback=function(dend,m,si){#dend.callback：用于聚类树的回调，当需要对聚类树进行重新排序，或者添加颜色时使用包含的三个参数：dend：当前扇区的树状图；m：当前扇区对应的子矩阵；si：当前扇区的名称
                 color_branches(dend,k=1) #color_branches(dend,k=15,col=1:15):修改聚类树颜色#聚类树颜色改为1，即单色/黑色
               })
lg=Legend(title="P values",col_fun=mycol, grid_height = unit(0.005, "mm"),
          grid_width = unit(1, "mm"),
          gap = unit(0.02, "mm"),size = unit(0.015, "mm"),
          direction = c("vertical")
)

grid.draw(lg)

# 6*6 inch pdf

exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
exposure_dat<- extract_instruments(c("ebi-a-GCST90016930","ebi-a-GCST90016940","ebi-a-GCST90016989","ebi-a-GCST90017006","ebi-a-GCST90017021","ebi-a-GCST90017024","ebi-a-GCST90017041","ebi-a-GCST90017060","ebi-a-GCST90017084","ebi-a-GCST90017074","ebi-a-GCST90016913","ebi-a-GCST90016909","ebi-a-GCST90016952","ebi-a-GCST90017070"),p1=1e-5)
outcome_dat<- extract_outcome_data(exposure_dat$SNP, c('ieu-a-1185'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
exposure_dat<- extract_instruments(c("ebi-a-GCST90016989","ebi-a-GCST90017074"),p1=1e-5)
outcome_dat<- extract_outcome_data(exposure_dat$SNP, c("ebi-a-GCST90016989","ebi-a-GCST90017074"), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)

outcome_dat<- extract_outcome_data(exposure_dat$SNP, c('ukb-b-11697','ukb-b-1489','ukb-b-8006','ukb-b-2209','ebi-a-GCST90096893','ebi-a-GCST90096904','ebi-a-GCST90096918','ebi-a-GCST90096906','ebi-a-GCST90096923'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat <- harmonise_data(exposure_dat,outcome_dat,action=2)
res <- mr(dat)
path<-file.path("C:/Users/Administrator/Desktop","MRresluts.xls")
write.table(res, sep= "\t",file = path)

GCST90094824_buildGRCh37$chromosome<-1
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_dat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n") 
dat <- harmonise_data(exposure_dat,outcome_dat,action=2)
res <- mr(dat)


###################################cheese 'ukb-b-1489'#########################
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017074'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2224274")))
mediation<-extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5)
outcome_dat3<- extract_outcome_data(exposure_dat$SNP, c('ukb-b-1489'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)%>% subset(., !(SNP %in% c("rs2391769")))
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ukb-b-1489'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)

exp1<- extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017074','ieu-a-1185'), pval_threshold = 1e-05) %>% subset(., !(SNP %in% c("rs2391769","rs2224274")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ukb-b-1489'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]

diff<-function(beta_total,se_total,direct_beta,direct_se,verbose=F){
  indirect_beta=beta_total-direct_beta
  if (verbose) {print(paste("Indirect effect="),round(beta_total,2),"-",round(direct_beta,2),"-",round(indirect_beta,2))}
  indirect_se=round(se_total^2 +direct_se^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_total,2),"^2 +",round(direct_se,2),"^2)="),indirect_se)}
  df<-data.frame(b=indirect_beta,se=indirect_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,4)
  return(df)
}
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #5.179%

GCST90017024 GCST90017070
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017070'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)%>% subset(., !(SNP %in% c("rs2224274","rs11185408")))
mediation<-extract_instruments(c('ebi-a-GCST90017070'),p1=1e-5)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ukb-b-1489'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=1)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017070'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017070','ieu-a-1185'), pval_threshold = 1e-05)%>% subset(., !(SNP %in% c("rs2391769","rs2224274","rs11185408")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ukb-b-1489'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #46.612%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 18))

###################################oily fish 'ukb-b-2209'#########################
7074 7024 6913
exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017074'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2224274")))
mediation<-extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5)
outcome_dat3<- extract_outcome_data(exposure_dat$SNP, c('ukb-b-2209'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ukb-b-2209'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017074','ieu-a-1185'), pval_threshold = 1e-05) %>% subset(., !(SNP %in% c("rs2224274")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ukb-b-2209'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #49.640%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 11))

outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017024'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) 
mediation<-extract_instruments(c('ebi-a-GCST90017024'),p1=1e-5)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ukb-b-2209'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017024'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017024','ieu-a-1185'), pval_threshold = 1e-05)
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ukb-b-2209'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #53.244%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 11))

outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016913'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2391769")))
mediation<-extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ukb-b-2209'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016913','ieu-a-1185'), pval_threshold = 1e-05)
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)%>% subset(., !(SNP %in% c("rs2391769")))
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ukb-b-2209'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #35.629%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 11))

Delta_method<-function(beta_total,se_total,direct_beta,direct_se,verbose=F){
  EO<-beta_total-direct_beta
  if (verbose){print(paste("total effect=",round(beta_total,2),"-",round(direct_beta,2),"-",round(EO,2)))}
  cis=medci(beta_total,se_total,direct_beta,direct_se,type="DOP")
  df<-data.frame(b=EO,
                 se=cis$SE,
                 lo_ci=cis[["95% CI"]][1],
                 up_ci=cis[["95% CI"]][2])
  df<-round(df,3)
}
eff<-Delta_method(beta_total,se_total,direct_beta,direct_se)
eff[,1]/beta_total #36.03%

###################################salad 'ebi-a-GCST90096923'#########################
GCST90017074 GCST90017024 GCST90016913
exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017074'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2224274")))
mediation<-extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5)
outcome_dat3<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90096923'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)%>% subset(., !(SNP %in% c("rs325485","rs11185408","rs1452075")))
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ebi-a-GCST90096923'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017074','ieu-a-1185'), pval_threshold = 1e-05) %>% subset(., !(SNP %in% c("rs2224274","rs325485","rs11185408","rs1452075")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ebi-a-GCST90096923'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
eff<-Delta_method(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #24.549% -0.0037 1e-04 -0.0039 -0.0035
eff[,1]/beta_total #26.540%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 12))

outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017024'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) 
mediation<-extract_instruments(c('ebi-a-GCST90017024'),p1=1e-5)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ebi-a-GCST90096923'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017024'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017024','ieu-a-1185'), pval_threshold = 1e-05)
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)%>% subset(., !(SNP %in% c("rs325485","rs11185408","rs1452075")))
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ebi-a-GCST90096923'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_EM,se_EM,beta_MO,se_MO,verbose=F){
  EO_beta=beta_EM*beta_MO
  if (verbose) {print(paste("Indirect effect="),round(beta_EM,2),"-",round(beta_MO,2),"-",round(EO_beta,2))}
  EO_se=round(se_EM^2 +se_EM^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_EM,2),"^2 +",round(se_MO,2),"^2)="),EO_se)}
  df<-data.frame(b=EO_beta,se=EO_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,3)
  return(df)
}
eff<-diff(beta_EM,se_EM,direct_beta,direct_se) 
eff[,1]/beta_total #6.635% P=0.806
z<-eff[,1]/eff[,2]
p_value <- 2 * (1 - pt(abs(z), 15))

outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016913'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2391769")))
mediation<-extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ebi-a-GCST90096923'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016913','ieu-a-1185'), pval_threshold = 1e-05)
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)%>% subset(., !(SNP %in% c("rs325485","rs11185408","rs1452075","rs2391769")))
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ebi-a-GCST90096923'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_total,se_total,direct_beta,direct_se,verbose=F){
  indirect_beta=beta_total-direct_beta
  if (verbose) {print(paste("Indirect effect="),round(beta_total,2),"-",round(direct_beta,2),"-",round(indirect_beta,2))}
  indirect_se=round(se_total^2 +direct_se^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_total,2),"^2 +",round(direct_se,2),"^2)="),indirect_se)}
  df<-data.frame(b=indirect_beta,se=indirect_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,4)
  return(df)
}
eff<-diff(beta_EM,se_EM,direct_beta,direct_se) 
eff[,1]/beta_total #0.002 0.004 -0.007 0.011 13.279%
z<-eff[,1]/eff[,2]
p_value <- 2 * (1 - pt(abs(z), 19))

################################oily fish ebi-a-GCST90096918#########################
7074 6913
exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017074'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2224274")))
mediation<-extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5)
outcome_dat3<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90096918'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ebi-a-GCST90096918'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017074','ieu-a-1185'), pval_threshold = 1e-05) 
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ebi-a-GCST90096918'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #16.354%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 9))

outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016913'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2391769")))
mediation<-extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ebi-a-GCST90096918'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016913','ieu-a-1185'), pval_threshold = 1e-05)
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ebi-a-GCST90096918'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_EM,se_EM,beta_MO,se_MO,verbose=F){
  EO_beta=beta_EM*beta_MO
  if (verbose) {print(paste("Indirect effect="),round(beta_EM,2),"-",round(beta_MO,2),"-",round(EO_beta,2))}
  EO_se=round(se_EM^2 +se_EM^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_EM,2),"^2 +",round(se_MO,2),"^2)="),EO_se)}
  df<-data.frame(b=EO_beta,se=EO_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,3)
  return(df)
}
eff<-diff(beta_EM,se_EM,direct_beta,direct_se) 
eff[,1]/beta_total #10.665%
z<-eff[,1]/eff[,2]
p_value <- 2 * (1 - pt(abs(z), 9))
##################################################healthy diet ebi-a-GCST90096893###################
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017024'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) 
mediation<-extract_instruments(c('ebi-a-GCST90017024'),p1=1e-5)
outcome_dat3<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90096893'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ebi-a-GCST90096893'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017024'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017024','ieu-a-1185'), pval_threshold = 1e-05) 
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ebi-a-GCST90096893'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_EM,se_EM,beta_MO,se_MO,verbose=F){
  EO_beta=beta_EM*beta_MO
  if (verbose) {print(paste("Indirect effect="),round(beta_EM,2),"-",round(beta_MO,2),"-",round(EO_beta,2))}
  EO_se=round(se_EM^2 +se_EM^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_EM,2),"^2 +",round(se_MO,2),"^2)="),EO_se)}
  df<-data.frame(b=EO_beta,se=EO_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,3)
  return(df)
}
eff<-diff(beta_EM,se_EM,direct_beta,direct_se) 
eff[,1]/beta_total #0

#########################################bread ebi-a-GCST90096904 #####################
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016913'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2391769")))
mediation<-extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5)
outcome_dat3<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90096904'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
outcome_dat2<- extract_outcome_data(mediation$SNP, c('ebi-a-GCST90096904'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016913'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016913','ieu-a-1185'), pval_threshold = 1e-05)
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- extract_outcome_data(exposure_mvdat$SNP,c('ebi-a-GCST90096904'))
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
eff<-diff(beta_EM,se_EM,beta_MO,se_MO) 
eff[,1]/beta_total #18.730%
z<-eff[,1]/eff[,2]
p_value <- 2 * (1 - pt(abs(z), 9))


#######################################GCST90094824_buildGRCh37############################################
exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017074'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3) %>% subset(., !(SNP %in% c("rs2224274")))
mediation<-extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")%>% subset(., !(SNP %in% c("rs11185408","rs45595836","rs78827416")))
outcome_dat3 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = exposure_dat$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")%>% subset(., !(SNP %in% c("rs11185408","rs45595836","rs78827416")))
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)

exp1<- extract_instruments(c('ebi-a-GCST90017074'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017074','ieu-a-1185'), pval_threshold = 1e-05) %>% subset(., !(SNP %in% c("rs11185408","rs45595836","rs78827416","rs2224274")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n")  
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 2)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_EM,se_EM,beta_MO,se_MO,verbose=F){
  EO_beta=beta_EM*beta_MO
  if (verbose) {print(paste("Indirect effect="),round(beta_EM,2),"-",round(beta_MO,2),"-",round(EO_beta,2))}
  EO_se=round(se_EM^2 +se_EM^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_EM,2),"^2 +",round(se_MO,2),"^2)="),EO_se)}
  df<-data.frame(b=EO_beta,se=EO_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,3)
  return(df)
}
eff<-diff(beta_EM,se_EM,direct_beta,direct_se) 
eff[,1]/beta_total #9.169%
z<-eff[,1]/eff[,2]
p_value <- 2 * (1 - pt(abs(z), 7))

###############################GCST90094767_buildGRCh37.tsv#############################################
exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016952'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)%>% subset(., !(SNP %in% c("rs2224274","rs11185408")))
mediation<-extract_instruments(c('ebi-a-GCST90016952'),p1=1e-5)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")%>% subset(., !(SNP %in% c("rs2391769","rs111931861")))
outcome_dat3 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = exposure_dat$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")%>% subset(., !(SNP %in% c("rs2391769","rs111931861")))
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=2)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)

exp1<- extract_instruments(c('ebi-a-GCST90016952'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016952','ieu-a-1185'), pval_threshold = 1e-05) %>% subset(., !(SNP %in% c("rs2224274","rs11185408","rs2391769","rs111931861")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n")  
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 2)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_total,se_total,direct_beta,direct_se,verbose=F){
  indirect_beta=beta_total-direct_beta
  if (verbose) {print(paste("Indirect effect="),round(beta_total,2),"-",round(direct_beta,2),"-",round(indirect_beta,2))}
  indirect_se=round(se_total^2 +direct_se^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_total,2),"^2 +",round(direct_se,2),"^2)="),indirect_se)}
  df<-data.frame(b=indirect_beta,se=indirect_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,4)
  return(df)
}
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #13.793%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z),21)) #0.060

#############GCST90094795_buildGRCh37.tsv###################6952&7070########################################################
exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017070'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)%>% subset(., !(SNP %in% c("rs2224274","rs11185408")))
mediation<-extract_instruments(c('ebi-a-GCST90017070'),p1=1e-5)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")
outcome_dat3 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = exposure_dat$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")%>% subset(., !(SNP %in% c("rs45595836","rs6701243","rs11185408")))
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=1)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017070'),p1=1e-5) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017070','ieu-a-1185'), pval_threshold = 1e-05)%>% subset(., !(SNP %in% c("rs2391769","rs2224274","rs11185408","rs45595836","rs6701243")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n")
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
#product for coefficient
eff<-diff(beta_EM,se_EM,beta_MO,se_MO) 
eff[,1]/beta_total #15.146% -0.019 0.006 -0.031 -0.008 P=0.0056

diff<-function(beta_total,se_total,direct_beta,direct_se,verbose=F){
  indirect_beta=beta_total-direct_beta
  if (verbose) {print(paste("Indirect effect="),round(beta_total,2),"-",round(direct_beta,2),"-",round(indirect_beta,2))}
  indirect_se=round(se_total^2 +direct_se^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_total,2),"^2 +",round(direct_se,2),"^2)="),indirect_se)}
  df<-data.frame(b=indirect_beta,se=indirect_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,3)
  return(df)
}
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total  #36.668%  -0.046 0.008 -0.061 -0.031 for 6952/ -0.033 0.007 -0.047 -0.019 26.305% for 7070
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 14))
p_value <- 2 * (1 - pt(abs(z), 21))

outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016909'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)%>% subset(., !(SNP %in% c("rs11185408","rs2391769","rs45595836")))
mediation<-extract_instruments(c('ebi-a-GCST90016909'),p1=5e-6)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=1)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016909'),p1=5e-6) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016909','ieu-a-1185'), pval_threshold = 1e-05)%>% subset(., !(SNP %in% c("rs6701243","rs11185408","rs11185408","rs2391769","rs45595836")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n") 
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #22.320% 
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 12))

outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016940'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
mediation<-extract_instruments(c('ebi-a-GCST90016940'),p1=1e-5)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=1)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016940'),p1=1e-5) %>% select(SNP)
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016940','ieu-a-1185'), pval_threshold = 1e-05) %>% subset(., !(SNP %in% c("rs45595836","rs6701243","rs11185408")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n")
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #9,565%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 16))

###############################################GCST90094759_buildGRCh37.tsv############################
exposure_dat<- extract_instruments(c('ieu-a-1185'),p1=1e-6)
outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016913'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)%>% subset(., !(SNP %in% c("rs2391769")))
mediation<-extract_instruments(c('ebi-a-GCST90016913'),p1=5e-6)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n") 
outcome_dat3 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = exposure_dat$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n") %>% subset(., !(SNP %in% c("rs141455452","rs910805")))
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=1)
dat2 <- harmonise_data(mediation,outcome_dat2,action=1)
dat3 <- harmonise_data(exposure_dat,outcome_dat3,action=1)
res1 <- mr(dat1)
res2 <- mr(dat2)
res3 <- mr(dat3)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_total<-res3 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016913'),p1=5e-6) %>% select(SNP) 
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016913','ieu-a-1185'), pval_threshold = 1e-05)
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)%>% subset(., !(SNP %in% c("rs141455452","rs910805")))
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n") 
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_EM,se_EM,beta_MO,se_MO,verbose=F){
  EO_beta=beta_EM*beta_MO
  if (verbose) {print(paste("Indirect effect="),round(beta_EM,2),"-",round(beta_MO,2),"-",round(EO_beta,2))}
  EO_se=round(se_EM^2 +se_EM^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_EM,2),"^2 +",round(se_MO,2),"^2)="),EO_se)}
  df<-data.frame(b=EO_beta,se=EO_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,3)
  return(df)
}
eff<-diff(beta_EM,se_EM,beta_MO,se_MO) 
eff[,1]/beta_total #12.522%
z<-eff[,1]/eff[,2]
p_value <- 2 * (1 - pt(abs(z), 18))


outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90016940'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
mediation<-extract_instruments(c('ebi-a-GCST90016940'),p1=1e-5)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=1)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90016940'),p1=1e-5) %>% select(SNP)
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90016940','ieu-a-1185'), pval_threshold = 1e-05)%>% subset(., !(SNP %in% c("rs141455452","rs910805")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n")
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
indirect_effect<-diff(beta_total,se_total,direct_beta,direct_se)
indirect_effect[,1]/beta_total #18.258%
z<-indirect_effect[,1]/indirect_effect[,2]
p_value <- 2 * (1 - pt(abs(z), 28))


outcome_dat1<- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST90017021'), proxies=1, rsq = 0.8, align_alleles = 1, palindromes=1, maf_threshold = 0.3)
mediation<-extract_instruments(c('ebi-a-GCST90017021'),p1=1e-5)
outcome_dat2 <- format_data(GCST90094824_buildGRCh37,
                            type='outcome',snps = mediation$SNP,
                            snp_col = "variant_id",
                            beta_col = "beta",
                            se_col = "standard_error",
                            effect_allele_col = "effect_allele",
                            other_allele_col = "other_allele",
                            eaf_col = "effect_allele_frequency",
                            pval_col = "p-value",
                            units_col = "chromosome",
                            gene_col = "base_pair_location",
                            samplesize_col = "n")
dat1 <- harmonise_data(exposure_dat,outcome_dat1,action=1)
dat2 <- harmonise_data(mediation,outcome_dat2,action=2)
res1 <- mr(dat1)
res2 <- mr(dat2)
beta_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_EM<-res1 %>% filter(method=="Inverse variance weighted") %>% pull(se)
beta_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(b)
se_MO<-res2 %>% filter(method=="Inverse variance weighted") %>% pull(se)
exp1<- extract_instruments(c('ebi-a-GCST90017021'),p1=1e-5) %>% select(SNP)
exp2<- extract_instruments(c('ieu-a-1185'),p1=1e-6) %>% select(SNP)
exposure_mvdat<- mv_extract_exposures(c('ebi-a-GCST90017021','ieu-a-1185'), pval_threshold = 1e-05)%>% subset(., !(SNP %in% c("rs141455452","rs910805")))
exposure_mvdat <- exposure_mvdat %>% filter(as.character(SNP) %in% exp1$SNP | as.character(SNP) %in% exp2$SNP)
outcome_dat <- format_data(GCST90094824_buildGRCh37,
                           type='outcome',snps = exposure_mvdat$SNP,
                           snp_col = "variant_id",
                           beta_col = "beta",
                           se_col = "standard_error",
                           effect_allele_col = "effect_allele",
                           other_allele_col = "other_allele",
                           eaf_col = "effect_allele_frequency",
                           pval_col = "p-value",
                           units_col = "chromosome",
                           gene_col = "base_pair_location",
                           samplesize_col = "n")
mvdat <- mv_harmonise_data(exposure_mvdat, outcome_dat,harmonise_strictness = 1)
res <- mv_multiple(mvdat,pval_threshold=1e-05)
direct_beta<-res[["result"]][["b"]][2]
direct_se<-res[["result"]][["se"]][2]
mv_beta<-res[["result"]][["b"]][1]
mv_se<-res[["result"]][["se"]][1]
diff<-function(beta_EM,se_EM,beta_MO,se_MO,verbose=F){
  EO_beta=beta_EM*beta_MO
  if (verbose) {print(paste("Indirect effect="),round(beta_EM,2),"-",round(beta_MO,2),"-",round(EO_beta,2))}
  EO_se=round(se_EM^2 +se_EM^2,4) 
  if (verbose) {print(paste("SE of indirect=sqrt(",round(se_EM,2),"^2 +",round(se_MO,2),"^2)="),EO_se)}
  df<-data.frame(b=EO_beta,se=EO_se)
  df$lo_ci<-df$b-1.96*df$se
  df$up_ci<-df$b+1.96*df$se
  df<-round(df,3)
  return(df)
}
eff<-diff(beta_EM,se_EM,direct_beta,direct_se) 
eff[,1]/beta_total #16.229% -0.008 0.005 -0.017 0.002
z<-eff[,1]/eff[,2]
p_value <- 2 * (1 - pt(abs(z), 26))


