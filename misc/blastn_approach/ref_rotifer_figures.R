library(plyr)
library(ggplot2)
library(plotly)
library(viridis)
library(MASS)
library(ggridges)


#####################################
##### using non-relative data ROTIFER
#####################################

fail_score_data = read.table(file = fail_file_rot, header = F, sep = '\t')
fail_scores = as.numeric(as.character(fail_score_data$V1))
pass_score_data = read.table(file = pass_file_rot, header = F, sep = '\t')
pass_scores = as.numeric(as.character(pass_score_data$V1))
group = rep("fail",length(fail_score_data$V1))
fail_score_data = cbind(fail_score_data, group)
group = rep("pass",length(pass_score_data$V1))
pass_score_data = cbind(pass_score_data, group)

total = rbind(fail_score_data, pass_score_data)

#total_na = subset(total, total$V1 != "na")
total_na = total
total_na$V1 = as.numeric(levels(total_na$V1))[total_na$V1]
total_na$V1 = -log10(total_na$V1)
total_na[is.na(total_na)] <- 0


#####################################
##### using non-relative data ROTIFER
#####################################

ggplot(total_na, aes(x = total_na$V1, y = group, height = stat(density), fill = stat(x))) +
  geom_density_ridges_gradient(stat = "density", scale = 1) +
  scale_fill_viridis_c(option = "D")  +
  labs(title = paste(platform,"-",read,"\nE-value Frequencies in Read Populations\nBased on Restriction Motif Status", sep=" ")) +
  ylab("read density") +
  xlab("-log10(E-value)") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  theme_ridges(font_size = 18)


ggplot(total_na, aes(x=total_na$V1, y=group, fill = factor(stat(quantile)))) +
  stat_density_ridges(
    geom = "density_ridges_gradient",
    calc_ecdf = TRUE,
    quantiles = 4,
    quantile_lines = TRUE,
    scale = 1
  ) +
  scale_fill_viridis_d(name = "Quartiles")
