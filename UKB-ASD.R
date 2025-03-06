setwd("D:/CUHK2023FALL/HATCH COHORT/MR analysis")

library(haven)
ukb <- read_sas("ukb.sas7bdat", NULL)
View(ukb)
install.packages("MatchIt")
library(MatchIt)
analysis$ASD<-as.factor(analysis$ASD)
analysis$sex<-as.factor(analysis$sex)
analysis <- analysis[!is.na(analysis$ASD), ]
m.out <- matchit(ASD ~ BMI + sex,data = analysis, method = "nearest")
summary(m.out$distance)
summary(m.out)
data<-match.data(m.out)
wilcox.test(Age ~ ASD, data = data)
wilcox.test(DMSscore ~ ASD, data = data)
write_xlsx(list(as.data.frame(data)), path= "match_UKB.xlsx")


library(mi)
library(mice)
data<-airquality
data[4:10,3]<-rep(NA,7)
md.pattern(data)


imp <- mice(data, 5)
fit <- with(imp, lm())
pooled <- pool(fit)
summary(pooled)
