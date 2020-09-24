library(ggplot2)

if (exists("fail_file_rot") == TRUE){
  fail_score_data = read.csv(file = fail_file_rot, header = F, sep = ',')
  fail_scores = as.numeric(as.character(fail_score_data$V1))
  pass_score_data = read.csv(file = pass_file_rot, header = F, sep = ',')
  pass_scores = as.numeric(as.character(pass_score_data$V1))
  group = rep("fail",length(fail_score_data$V1))
  qscore = rep("rotifer",length(fail_score_data$V1))
  fail_score_data = cbind(fail_score_data, group, qscore)
  group = rep("pass",length(pass_score_data$V1))
  qscore = rep("rotifer",length(pass_score_data$V1))
  pass_score_data = cbind(pass_score_data, group, qscore)
  blastn_data = rbind(fail_score_data, pass_score_data)
  rm(fail_score_data, pass_score_data)
} else {
  blastn_data = data.frame(V1 = as.numeric(),
                     group = character(),
                     qscore = character())
}

if (exists("failed_100") == TRUE){
  failed_100 = read.csv(file = failed_100, header = F, sep = ',')
  group = rep("fail",length(failed_100$V1))
  qscore = rep("100",length(failed_100$V1))
  failed_100 = cbind(failed_100, group, qscore)
  blastn_data = rbind(blastn_data, failed_100)
  
  se_100 = read.csv(file = se_100, header = F, sep = ',')
  group = rep("pass",length(se_100$V1))
  qscore = rep("100",length(se_100$V1))
  se_100 = cbind(se_100, group, qscore)
  blastn_data = rbind(blastn_data, se_100)
  rm(se_100, failed_100)
}

if (exists("failed_90") == TRUE){
  failed_90 = read.csv(file = failed_90, header = F, sep = ',')
  group = rep("fail",length(failed_90$V1))
  qscore = rep("90",length(failed_90$V1))
  failed_90 = cbind(failed_90, group, qscore)
  blastn_data = rbind(blastn_data, failed_90)
  
  se_90 = read.csv(file = se_90, header = F, sep = ',')
  group = rep("pass",length(se_90$V1))
  qscore = rep("90",length(se_90$V1))
  se_90 = cbind(se_90, group, qscore)
  blastn_data = rbind(blastn_data, se_90)
  rm(se_90, failed_90)
}

if (exists("failed_80") == TRUE){
  failed_80 = read.csv(file = failed_80, header = F, sep = ',')
  group = rep("fail",length(failed_80$V1))
  qscore = rep("80",length(failed_80$V1))
  failed_80 = cbind(failed_80, group, qscore)
  blastn_data = rbind(blastn_data, failed_80)
  
  se_80 = read.csv(file = se_80, header = F, sep = ',')
  group = rep("pass",length(se_80$V1))
  qscore = rep("80",length(se_80$V1))
  se_80 = cbind(se_80, group, qscore)
  blastn_data = rbind(blastn_data, se_80)
  rm(se_80, failed_80)
}

if (exists("failed_70") == TRUE){
  failed_70 = read.csv(file = failed_70, header = F, sep = ',')
  group = rep("fail",length(failed_70$V1))
  qscore = rep("70",length(failed_70$V1))
  failed_70 = cbind(failed_70, group, qscore)
  blastn_data = rbind(blastn_data, failed_70)
  
  se_70 = read.csv(file = se_70, header = F, sep = ',')
  group = rep("pass",length(se_70$V1))
  qscore = rep("70",length(se_70$V1))
  se_70 = cbind(se_70, group, qscore)
  blastn_data = rbind(blastn_data, se_70)
  rm(se_70, failed_70)
}

if (exists("failed_60") == TRUE){
  failed_60 = read.csv(file = failed_60, header = F, sep = ',')
  group = rep("fail",length(failed_60$V1))
  qscore = rep("60",length(failed_60$V1))
  failed_60 = cbind(failed_60, group, qscore)
  blastn_data = rbind(blastn_data, failed_60)
  
  se_60 = read.csv(file = se_60, header = F, sep = ',')
  group = rep("pass",length(se_60$V1))
  qscore = rep("60",length(se_60$V1))
  se_60 = cbind(se_60, group, qscore)
  blastn_data = rbind(blastn_data, se_60)
  rm(se_60, failed_60)
}

if (exists("failed_50") == TRUE){
  failed_50 = read.csv(file = failed_50, header = F, sep = ',')
  group = rep("fail",length(failed_50$V1))
  qscore = rep("50",length(failed_50$V1))
  failed_50 = cbind(failed_50, group, qscore)
  blastn_data = rbind(blastn_data, failed_50)
  
  se_50 = read.csv(file = se_50, header = F, sep = ',')
  group = rep("pass",length(se_50$V1))
  qscore = rep("50",length(se_50$V1))
  se_50 = cbind(se_50, group, qscore)
  blastn_data = rbind(blastn_data, se_50)
  rm(se_50, failed_50)
}

if (exists("failed_40") == TRUE){
  failed_40 = read.csv(file = failed_40, header = F, sep = ',')
  group = rep("fail",length(failed_40$V1))
  qscore = rep("40",length(failed_40$V1))
  failed_40 = cbind(failed_40, group, qscore)
  blastn_data = rbind(blastn_data, failed_40)
  
  se_40 = read.csv(file = se_40, header = F, sep = ',')
  group = rep("pass",length(se_40$V1))
  qscore = rep("40",length(se_40$V1))
  se_40 = cbind(se_40, group, qscore)
  blastn_data = rbind(blastn_data, se_40)
  rm(se_40, failed_40)
}

if (exists("failed_30") == TRUE){
  failed_30 = read.csv(file = failed_30, header = F, sep = ',')
  group = rep("fail",length(failed_30$V1))
  qscore = rep("30",length(failed_30$V1))
  failed_30 = cbind(failed_30, group, qscore)
  blastn_data = rbind(blastn_data, failed_30)
  
  se_30 = read.csv(file = se_30, header = F, sep = ',')
  group = rep("pass",length(se_30$V1))
  qscore = rep("30",length(se_30$V1))
  se_30 = cbind(se_30, group, qscore)
  blastn_data = rbind(blastn_data, se_30)
  rm(se_30, failed_30)
}

if (exists("failed_20") == TRUE){
  failed_20 = read.csv(file = failed_20, header = F, sep = ',')
  group = rep("fail",length(failed_20$V1))
  qscore = rep("20",length(failed_20$V1))
  failed_20 = cbind(failed_20, group, qscore)
  blastn_data = rbind(blastn_data, failed_20)
  
  se_20 = read.csv(file = se_20, header = F, sep = ',')
  group = rep("pass",length(se_20$V1))
  qscore = rep("20",length(se_20$V1))
  se_20 = cbind(se_20, group, qscore)
  blastn_data = rbind(blastn_data, se_20)
  rm(se_20, failed_20)
}

if (exists("failed_10") == TRUE){
  failed_10 = read.csv(file = failed_10, header = F, sep = ',')
  group = rep("fail",length(failed_10$V1))
  qscore = rep("10",length(failed_10$V1))
  failed_10 = cbind(failed_10, group, qscore)
  blastn_data = rbind(blastn_data, failed_10)
  
  se_10 = read.csv(file = se_10, header = F, sep = ',')
  group = rep("pass",length(se_10$V1))
  qscore = rep("10",length(se_10$V1))
  se_10 = cbind(se_10, group, qscore)
  blastn_data = rbind(blastn_data, se_10)
  rm(se_10, failed_10)
}

gc()
rm(list=setdiff(ls(), c("blastn_data", "platform", "read", "fail_file_rot", "title")))


#GET THE DATASET(S) READY FOR VISUALS
names(blastn_data)[names(blastn_data) == "V1"] <- "E-value"
names(blastn_data)[names(blastn_data) == "V2"] <- "count"
density = blastn_data$count/sum(blastn_data$count)
blastn_data = cbind(blastn_data, density)
blastn_data$'E-value' = as.numeric(levels(blastn_data$'E-value'))[blastn_data$'E-value']
blastn_data$'E-value' = -log10(blastn_data$'E-value')
blastn_data[is.na(blastn_data)] <- 0
blastn_data$all_group <- paste(blastn_data$group,' ',blastn_data$qscore, sep = '')
fail_data = subset(blastn_data, blastn_data$group == "fail")
pass_data = subset(blastn_data, blastn_data$group == "pass")


if (exists("fail_file_rot") == TRUE){
  fail_color_fn = colorRampPalette(c("gray", "#F18C8E"))
  fail_colors = c(fail_color_fn(length(levels(blastn_data$qscore)) - 1), "#9b786f")
  pass_color_fn = colorRampPalette(c("white", "#568EA6"))
  pass_colors = c(pass_color_fn(length(levels(blastn_data$qscore)) - 1), "#d1a745")
} else {
  fail_color_fn = colorRampPalette(c("gray", "#F18C8E"))
  fail_colors = c(fail_color_fn(length(levels(blastn_data$qscore))))
  pass_color_fn = colorRampPalette(c("white", "#568EA6"))
  pass_colors = c(pass_color_fn(length(levels(blastn_data$qscore))))
}

graph_colors = c(fail_colors, pass_colors)



#GRAPH ALL READS ON SAME DENSITY SCALE (CALULATED USING SUM OF ALL READS)
plot1 <- ggplot(blastn_data, aes(x=`E-value`, weight=count, color=blastn_data$all_group)) +
  scale_color_manual(values = graph_colors)+
  geom_line(stat="density",size=1, adjust = 0.5, alpha = 0.85) +
  theme_classic()+
  ggtitle(paste(title, " (", platform, " ", read, ")", sep = ""))+
  labs(y = "Read count", col="Filtering Approach")+
  theme(
    panel.background = element_rect(fill = "#d4d6d5"),
    legend.key = element_rect(fill = "#d4d6d5", size = 0),
    plot.title=element_text(size=20, hjust = 0.5),
    axis.text=element_text(size=16),
    axis.title=element_text(size=16),
    legend.text=element_text(size=16),
    legend.title=element_text(size=16)
  )
# plot1
ggsave(filename = paste(title, "_", platform, "_", read, "_summary.tiff", sep = ""), plot=plot1, width=12, height= 7, dpi=600, compression = "lzw")


#GRAPH PASSING READS ONLY
plot2 <- ggplot(pass_data, aes(x=`E-value`, weight=count, color=pass_data$all_group)) +
  geom_line(stat="density",size=1, adjust = 0.5, alpha = 0.85) +
  theme_classic()+
  ggtitle(paste("Passed ", title, " (", platform, " ", read, ")", sep = ""))+
  scale_color_manual(values = pass_colors)+
  labs(y = "Read count", col="Filtering Approach")+
  theme(
    panel.background = element_rect(fill = "#d4d6d5"),
    legend.key = element_rect(fill = "#d4d6d5", size = 0),
    plot.title=element_text(size=20, hjust = 0.5),
    axis.text=element_text(size=16),
    axis.title=element_text(size=16),
    legend.text=element_text(size=16),
    legend.title=element_text(size=16)
  )
# plot2
ggsave(filename = paste(title, "_", platform, "_", read, "_passed.tiff", sep = ""), plot=plot2, width=12, height= 7, dpi=600, compression = "lzw")

#GRAPH FAILING READS ONLY
plot3 <- ggplot(fail_data, aes(x=`E-value`, weight=count, color=fail_data$all_group)) +
  geom_line(stat="density",size=1, adjust = 0.5, alpha = 0.85) +
  theme_classic()+
  ggtitle(paste("Failed ", title, " (", platform, " ", read, ")", sep = ""))+
  scale_color_manual(values = fail_colors)+
  labs(y = "Read count", col="Filtering Approach")+
  theme(
    panel.background = element_rect(fill = "#d4d6d5"),
    legend.key = element_rect(fill = "#d4d6d5", size = 0),
    plot.title=element_text(size=20, hjust = 0.5),
    axis.text=element_text(size=16),
    axis.title=element_text(size=16),
    legend.text=element_text(size=16),
    legend.title=element_text(size=16)
  )
# plot3
ggsave(filename = paste(title, "_", platform, "_", read, "_failed.tiff", sep = ""), plot=plot3, width=12, height= 7, dpi=600, compression = "lzw")
