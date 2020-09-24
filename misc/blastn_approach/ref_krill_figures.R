library(plyr)
library(ggplot2)
library(plotly)
library(viridis)
library(MASS)
library(ggridges)


###################################
##### using non-relative data KRILL
###################################

if (exists("fail_file_rot") == TRUE){
  fail_score_data = read.table(file = fail_file_rot, header = F, sep = '\t')
  fail_scores = as.numeric(as.character(fail_score_data$V1))
  pass_score_data = read.table(file = pass_file_rot, header = F, sep = '\t')
  pass_scores = as.numeric(as.character(pass_score_data$V1))
  group = rep("fail",length(fail_score_data$V1))
  qscore = rep("rotifer",length(fail_score_data$V1))
  fail_score_data = cbind(fail_score_data, group, qscore)
  group = rep("pass",length(pass_score_data$V1))
  qscore = rep("rotifer",length(pass_score_data$V1))
  pass_score_data = cbind(pass_score_data, group, qscore)
  total = rbind(fail_score_data, pass_score_data)
  rm(fail_score_data, pass_score_data)
} else {
  total = data.frame(V1 = as.numeric(),
                     group = character(),
                     qscore = character())
}

if (exists("failed_100") == TRUE){
  failed_100 = read.table(file = failed_100, header = F, sep = '\t')
  group = rep("fail",length(failed_100$V1))
  qscore = rep("100",length(failed_100$V1))
  failed_100 = cbind(failed_100, group, qscore)
  total = rbind(total, failed_100)
  
  se_100 = read.table(file = se_100, header = F, sep = '\t')
  group = rep("pass",length(se_100$V1))
  qscore = rep("100",length(se_100$V1))
  se_100 = cbind(se_100, group, qscore)
  total = rbind(total, se_100)
  rm(se_100, failed_100)
}

if (exists("failed_90") == TRUE){
  failed_90 = read.table(file = failed_90, header = F, sep = '\t')
  group = rep("fail",length(failed_90$V1))
  qscore = rep("90",length(failed_90$V1))
  failed_90 = cbind(failed_90, group, qscore)
  total = rbind(total, failed_90)
  
  se_90 = read.table(file = se_90, header = F, sep = '\t')
  group = rep("pass",length(se_90$V1))
  qscore = rep("90",length(se_90$V1))
  se_90 = cbind(se_90, group, qscore)
  total = rbind(total, se_90)
  rm(se_90, failed_90)
}

if (exists("failed_80") == TRUE){
  failed_80 = read.table(file = failed_80, header = F, sep = '\t')
  group = rep("fail",length(failed_80$V1))
  qscore = rep("80",length(failed_80$V1))
  failed_80 = cbind(failed_80, group, qscore)
  total = rbind(total, failed_80)
  
  se_80 = read.table(file = se_80, header = F, sep = '\t')
  group = rep("pass",length(se_80$V1))
  qscore = rep("80",length(se_80$V1))
  se_80 = cbind(se_80, group, qscore)
  total = rbind(total, se_80)
  rm(se_80, failed_80)
}

if (exists("failed_70") == TRUE){
  failed_70 = read.table(file = failed_70, header = F, sep = '\t')
  group = rep("fail",length(failed_70$V1))
  qscore = rep("70",length(failed_70$V1))
  failed_70 = cbind(failed_70, group, qscore)
  total = rbind(total, failed_70)
  
  se_70 = read.table(file = se_70, header = F, sep = '\t')
  group = rep("pass",length(se_70$V1))
  qscore = rep("70",length(se_70$V1))
  se_70 = cbind(se_70, group, qscore)
  total = rbind(total, se_70)
  rm(se_70, failed_70)
}

if (exists("failed_60") == TRUE){
  failed_60 = read.table(file = failed_60, header = F, sep = '\t')
  group = rep("fail",length(failed_60$V1))
  qscore = rep("60",length(failed_60$V1))
  failed_60 = cbind(failed_60, group, qscore)
  total = rbind(total, failed_60)
  
  se_60 = read.table(file = se_60, header = F, sep = '\t')
  group = rep("pass",length(se_60$V1))
  qscore = rep("60",length(se_60$V1))
  se_60 = cbind(se_60, group, qscore)
  total = rbind(total, se_60)
  rm(se_60, failed_60)
}

if (exists("failed_50") == TRUE){
  failed_50 = read.table(file = failed_50, header = F, sep = '\t')
  group = rep("fail",length(failed_50$V1))
  qscore = rep("50",length(failed_50$V1))
  failed_50 = cbind(failed_50, group, qscore)
  total = rbind(total, failed_50)
  
  se_50 = read.table(file = se_50, header = F, sep = '\t')
  group = rep("pass",length(se_50$V1))
  qscore = rep("50",length(se_50$V1))
  se_50 = cbind(se_50, group, qscore)
  total = rbind(total, se_50)
  rm(se_50, failed_50)
}

if (exists("failed_40") == TRUE){
  failed_40 = read.table(file = failed_40, header = F, sep = '\t')
  group = rep("fail",length(failed_40$V1))
  qscore = rep("40",length(failed_40$V1))
  failed_40 = cbind(failed_40, group, qscore)
  total = rbind(total, failed_40)
  
  se_40 = read.table(file = se_40, header = F, sep = '\t')
  group = rep("pass",length(se_40$V1))
  qscore = rep("40",length(se_40$V1))
  se_40 = cbind(se_40, group, qscore)
  total = rbind(total, se_40)
  rm(se_40, failed_40)
}

if (exists("failed_30") == TRUE){
  failed_30 = read.table(file = failed_30, header = F, sep = '\t')
  group = rep("fail",length(failed_30$V1))
  qscore = rep("30",length(failed_30$V1))
  failed_30 = cbind(failed_30, group, qscore)
  total = rbind(total, failed_30)
  
  se_30 = read.table(file = se_30, header = F, sep = '\t')
  group = rep("pass",length(se_30$V1))
  qscore = rep("30",length(se_30$V1))
  se_30 = cbind(se_30, group, qscore)
  total = rbind(total, se_30)
  rm(se_30, failed_30)
}

if (exists("failed_20") == TRUE){
  failed_20 = read.table(file = failed_20, header = F, sep = '\t')
  group = rep("fail",length(failed_20$V1))
  qscore = rep("20",length(failed_20$V1))
  failed_20 = cbind(failed_20, group, qscore)
  total = rbind(total, failed_20)
  
  se_20 = read.table(file = se_20, header = F, sep = '\t')
  group = rep("pass",length(se_20$V1))
  qscore = rep("20",length(se_20$V1))
  se_20 = cbind(se_20, group, qscore)
  total = rbind(total, se_20)
  rm(se_20, failed_20)
}

if (exists("failed_10") == TRUE){
  failed_10 = read.table(file = failed_10, header = F, sep = '\t')
  group = rep("fail",length(failed_10$V1))
  qscore = rep("10",length(failed_10$V1))
  failed_10 = cbind(failed_10, group, qscore)
  total = rbind(total, failed_10)
  
  se_10 = read.table(file = se_10, header = F, sep = '\t')
  group = rep("pass",length(se_10$V1))
  qscore = rep("10",length(se_10$V1))
  se_10 = cbind(se_10, group, qscore)
  total = rbind(total, se_10)
  rm(se_10, failed_10)
}
gc()

#total_na = subset(total, total$V1 != "na")
total$V1 = as.numeric(levels(total$V1))[total$V1]
total$V1 = -log10(total$V1)
total[is.na(total)] <- 0

###################################
##### using non-relative data KRILL
###################################

# plot1 <- ggplot(total, aes(x = total$V1, y=total$qscore, color = group, fill = group)) +
#   geom_density_ridges(scale = 1.5, color = "white", alpha = 0.5, panel_scaling = TRUE) +
#   scale_y_discrete(expand = c(0, 0), name = "filtering approach") +
#   scale_x_continuous(expand = c(0, 0), name = "-log10(E-value)") +
#   scale_fill_manual(values = c("firebrick1", "cornflowerblue"), labels = c("fail", "pass")) +
#   scale_color_manual(values = c("firebrick1", "cornflowerblue"), guide = "none") +
#   coord_cartesian(clip = "off") +
#   guides(fill = guide_legend(
#     override.aes = list(
#       fill = c("firebrick1", "cornflowerblue"),
#       color = NA, point_color = NA)
#   )
#   ) +
#   ggtitle(paste(platform,"qscore threshold vs. rotifer alone","-",read,sep = ' ')) +
#   theme_ridges(center = TRUE)
# plot1

plot2 <- ggplot(total, aes(x = total$V1, y=total$qscore, color = group, fill = group)) +
  geom_density_ridges(scale = 1.5, alpha = 0.3, quantile_lines = TRUE, quantiles=2) +
  scale_y_discrete(expand = c(0, 0), name = "filtering approach") +
  scale_x_continuous(expand = c(0, 0), name = "-log10(E-value)") +
  scale_fill_manual(values = c("firebrick1", "cornflowerblue"), labels = c("fail", "pass")) +
  scale_color_manual(values = c("firebrick1", "cornflowerblue"), guide = "none") +
  coord_cartesian(clip = "off") +
  guides(fill = guide_legend(
    override.aes = list(
      fill = c("firebrick1", "cornflowerblue"),
      color = NA, point_color = NA)
  )
  ) +
  ggtitle(paste(platform,"qscore threshold vs. rotifer alone","-",read,sep = ' ')) +
  theme_ridges(center = TRUE)
plot2

plot3 <- ggplot(data=total, aes(x = V1, y=..count.., group=group, color = group, fill=group)) +
  geom_density(alpha=0.1, adjust=0.5, color=c("grey")) +
  facet_wrap( ~ qscore, ncol=3)+
  scale_fill_manual( values = c("firebrick1","cornflowerblue"))+
  theme_classic()
plot3

total <- subset(total, group == "fail")
plot4 <- ggplot(data=total, aes(x = V1, y=..count.., group=qscore, color = qscore)) +
  geom_density(adjust=0.5, position="stack") +
  scale_fill_manual( values = c("firebrick1","cornflowerblue"))+
  theme_classic()
plot4

ggsave(filename= paste(dirname(fail_file_rot), "/", read, "_", platform, ".tiff", sep = ""), plot=plot1, width=15, height=12, dpi=300, compression = "lzw")


# ggplot(total, aes(x=total$V1, y=total$qscore, color = group, fill = factor(stat(quantile)))) +
#   stat_density_ridges(
#     geom = "density_ridges_gradient",
#     calc_ecdf = TRUE,
#     quantiles = 2,
#     quantile_lines = TRUE,
#     scale = 1
#   ) +
#   scale_fill_viridis_d(name = "Quartiles", alpha = 0.6, guide = "none", option="magma") +
#   theme_ridges()

######################
# VIOLIN PLOTS
######################

ggplot(total, aes(x=qscore, y=V1, fill=group)) +
  geom_violin(draw_quantiles = c(0.5))+
  # geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))+
  theme_minimal()


