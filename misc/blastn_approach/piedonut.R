library(ggplot2)


#########################################
# krill first
#########################################
# tool1 = "threshold"
# tool2 = "motif"
# #light interior
# good_cols = c("#f2d3d3","#F18C8E", "#7ee0c8" ,"#c4f5e9", "#F18C8E", "#7ee0c8")

# #########################################
# 
#MISEQ R1
# platform = "miseq"
# read = "R1"
# ymin1 <- c(0,	0,	732248,	732248)
# ymax1 <- c(732248,	732248,	835261,	835261)
# ymin2 <- c(0,	677196,	732248,	827247)
# ymax2 <- c(677196,	732248,	827247,	835261)
# 
# #MISEQ R2
# platform = "miseq"
# read = "R2"
# ymin1 <- c(0,	0,	700793,	700793)
# ymax1 <- c(700793,	700793,	835261,	835261)
# ymin2 <- c(0,	684146,	700793,	828915)
# ymax2 <- c(684146,	700793,	828915,	835261)
# 
# #########################################
# 
# #HISEQ125 R1
# platform = "hiseq125"
# read = "R1"
# ymin1 <- c(0,	0,	121950573,	121950573)
# ymax1 <- c(121950573,	121950573,	156472029,	156472029)
# ymin2 <- c(0,	121220503,	121950573,	156104567)
# ymax2 <- c(121220503,	121950573,	156104567,	156472029)
# 
#HISEQ125 R2
# platform = "hiseq125"
# read = "R2"
# ymin1 <- c(0,	0,	133550949,	133550949)
# ymax1 <- c(133550949,	133550949,	156472029,	156472029)
# ymin2 <- c(0,	132840771,	133550949,	155491136)
# ymax2 <- c(132840771,	133550949,	155491136,	156472029)
# 
# #########################################
# 
# #HISEQ250 R1
# platform = "hiseq250"
# read = "R1"
# ymin1 <- c(0,	0,	96431360,	96431360)
# ymax1 <- c(96431360,	96431360,	122317249,	122317249)
# ymin2 <- c(0,	95740739,	96431360,	121714448)
# ymax2 <- c(95740739,	96431360,	121714448,	122317249)
# 
#HISEQ250 R2
# platform = "hiseq250"
# read = "R2"
# ymin1 <- c(0,	0,	64052522,	64052522)
# ymax1 <- c(64052522,	64052522,	122317249,	122317249)
# ymin2 <- c(0,	62381546,	64052522,	118144203)
# ymax2 <- c(62381546,	64052522,	118144203,	122317249)
# 
# #########################################
# 
# #########################################
# # rotifer first
# #########################################
tool1 = "motif"
tool2 = "threshold"
#dark interior
good_cols = c("#F18C8E","#f2d3d3", "#c4f5e9" ,"#7ee0c8", "#f2d3d3", "#c4f5e9")

# #########################################
# 
# #MISEQ R1
# platform = "miseq"
# read = "R1"
# ymin1 <- c(0,	0,	772195,	772195)
# ymax1 <- c(772195,	772195,	835261,	835261)
# ymin2 <- c(0,	677196,	772195,	827247)
# ymax2 <- c(677196,	772195,	827247,	835261)
#   
# #MISEQ R2
# platform = "miseq"
# read = "R2"
# ymin1 <- c(0,	0,	812268,	812268)
# ymax1 <- c(812268,	812268,	835261,	835261)
# ymin2 <- c(0,	684146,	812268,	828915)
# ymax2 <- c(684146,	812268,	828915,	835261)
# 
# #########################################
# 
# #HISEQ125 R1
# platform = "hiseq125"
# read = "R1"
# ymin1 <- c(0,	0,	155374497,	155374497)
# ymax1 <- c(155374497,	155374497,	156472029,	156472029)
# ymin2 <- c(0,	121220503,	155374497,	156104567)
# ymax2 <- c(121220503,	155374497,	156104567,	156472029)
# 
# 
# #HISEQ125 R2
# platform = "hiseq125"
# read = "R2"
# ymin1 <- c(0,	0,	154780958,	154780958)
# ymax1 <- c(154780958,	154780958,	156472029,	156472029)
# ymin2 <- c(0,	132840771,	154780958,	155491136)
# ymax2 <- c(132840771,	154780958,	155491136,	156472029)
# 
# #########################################
# 
# #HISEQ250 R1
# platform = "hiseq250"
# read = "R1"
# ymin1 <- c(0,	0,	121023827,	121023827)
# ymax1 <- c(121023827,	121023827,	122317249,	122317249)
# ymin2 <- c(0,	95740739,	121023827,	121714448)
# ymax2 <- c(95740739,	121023827,	121714448,	122317249)
# 
#HISEQ250 R2
# platform = "hiseq250"
# read = "R2"
# ymin1 <- c(0,	0,	116473227,	116473227)
# ymax1 <- c(116473227,	116473227,	122317249,	122317249)
# ymin2 <- c(0,	62381546,	116473227,	118144203)
# ymax2 <- c(62381546,	116473227,	118144203,	122317249)
# 
# #########################################



#########################################
# universal from here onward
#########################################

first <- c(paste("pass", tool1),
           paste("pass", tool1),
           paste("fail", tool1),
           paste("fail", tool1))
second <- c(paste("pass", tool1, "pass", tool2),
            paste("pass", tool1, "fail", tool2),
            paste("fail", tool1, "pass", tool2),
            paste("fail", tool1, "fail", tool2))

filter <- data.frame(first, second, ymin2, ymax2, ymin1, ymax1)

plotty<- ggplot(filter) +
  geom_rect(aes(fill=second, ymax=ymax2, ymin=ymin2, xmax=4, xmin=3), color = "white", size = 2) +
  geom_rect(aes(fill=first, ymax=ymax1, ymin=ymin1, xmax=2.9, xmin=1), color = "white", size = 2) +
  xlim(c(0, 4)) +
  theme(aspect.ratio=1)+
  coord_polar(theta="y")+
  theme_void()+
  scale_fill_manual(values = good_cols)+
  theme(legend.position = "none")
plotty
ggsave(filename = paste("/media/ceres/composer_covid_work/",platform,"_",read,"_",tool1,"_",tool2,".tiff", sep = ''), plot=plotty, width=12, height= 12, dpi=600, compression = "lzw")
