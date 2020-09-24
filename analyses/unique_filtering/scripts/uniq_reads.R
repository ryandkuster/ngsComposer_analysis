R_packages <- "./R/" # set to location where R packages should be installed
setwd('.../unique_reads/') # set wd to location of read counts file
comp_df <- read.table(file = 'raw_threshold_data.csv', header=T, sep=",")


if (!require(ggplot2, lib.loc = R_packages)) install.packages('ggplot2', dependencies=TRUE, repos='http://cran.us.r-project.org', lib = R_packages)
if (!require(directlabels, lib.loc = R_packages)) install.packages('directlabels', dependencies=TRUE, repos='http://cran.us.r-project.org', lib = R_packages)
if (!require(ggrepel, lib.loc = R_packages)) install.packages('ggrepel', dependencies=TRUE, repos='http://cran.us.r-project.org', lib = R_packages)

library(ggplot2, lib.loc = R_packages)
library(directlabels, lib.loc = R_packages)
library(ggrepel, lib.loc = R_packages)


make_plots <- function(title, current, rotif){
  plot1 <- ggplot(data = current, aes(x=percent_sampled, y=percent_compression, color=group)) +
    geom_point(alpha=0.75, size = 2) +
    geom_point(data = rotif, shape = 3, color = "black", size = 15)+
    # geom_line(stat = "smooth", method = "loess", alpha = 0.25)+
    geom_line(alpha = 0.25)+
    theme_classic() +
    theme(legend.position = "none",
          panel.border = element_rect(colour = "black", fill=NA, size=1),
          panel.grid.major.y = element_line(size=.5, color="white"))+
    geom_dl(aes(label = group), method = list('last.bumpup', dl.combine("last.points")), cex = 0.8) +
    scale_x_continuous(expand = c(0.2,0), breaks = seq(0,100,by=10))+
    scale_y_continuous(expand = c(0.2,0), breaks = seq(0, 100, by = 10))+
    scale_color_manual(values = colors)+
    theme(panel.background = element_rect(fill = "#f5f5f5"))+
    xlab("Percent of Raw Reads")+
    ylab("Percent Compression")+
    ggtitle(paste("Filtering Effect on Read Compression in ",title, sep = ""))
  title2 = gsub(" ","_",title)
  ggsave(filename = paste("./figures/", title2, "_compression.tiff", sep = ""), plot=plot1, width=8, height= 8, dpi=600, compression = "lzw")


  plot2 <- ggplot(data = current, aes(x=percent_sampled, y=percent_compression, color=group, shape = group)) +
    geom_point(alpha=1, size = 2) +
    geom_point(data = rotif, shape = 3, color = "black", size = 15)+
    # geom_line(stat = "smooth", method = "loess", alpha = 0.5)+
    geom_line(alpha = 0.25)+
    theme_classic() +
    theme(panel.border = element_rect(colour = "black", fill=NA, size=1),
          panel.grid.major.y = element_line(size=.5, color="white"))+
    geom_dl(aes(label = group), method = list('last.bumpup', dl.combine("last.points")), cex = 0.8) +
    scale_x_continuous(expand = c(0.2,0), breaks = seq(0,100,by=10))+
    scale_y_continuous(expand = c(0.2,0), breaks = seq(0, 100, by = 10))+
    scale_color_manual(values = colors)+
    theme(panel.background = element_rect(fill = "#f5f5f5"))+
    xlab("Percent of Raw Reads")+
    ylab("Percent Compression")+
    ggtitle(paste("Filtering Effect on Read Compression in ",title, sep = ""))
  title2 = gsub(" ","_",title)
  ggsave(filename = paste("./figures/shape_",title2, "_compression.tiff", sep = ""), plot=plot2, width=10, height= 8, dpi=600, compression = "lzw")

  plot3 <- ggplot(data = current, aes(x=percent_sampled, y=change_percent_compression, color=group)) +
    geom_point(alpha=0.75, size = 3, shape = 21) +
    geom_point(data = rotif, shape = 3, color = "black", size = 15)+
    geom_line(alpha = 0.25)+
    geom_hline(aes(yintercept = 0), lty=1, alpha=0.5, size=0.35) +
    geom_vline(aes(xintercept = 50), lty=4, alpha=0.5, size=0.35) +
    theme_classic() +
    theme(legend.position = "none",
          panel.border = element_rect(colour = "black", fill=NA, size=1),
          panel.grid.major.y = element_line(size=.25, color="white"))+
    geom_dl(aes(label = group), method = list('last.bumpup', cex = 0.75, hjust = -.25)) +
    scale_x_continuous(expand = c(0.25,0), breaks = seq(0,100,by=10))+
    scale_y_continuous(expand = c(0.25,0), breaks = seq(-100, 100, by = 5))+
    scale_color_manual(values = colors)+
    theme(panel.background = element_rect(fill = "#f5f5f5"))+
    xlab("Percent of Raw Reads")+
    ylab("Percent Change in Compression (Normalized by Sample Size)")+
    ggtitle(paste("Filtering Effect on Read Compression in ",title, sep = ""))+
    geom_text_repel(aes(x = percent_sampled, y = change_percent_compression, label = label),
      size=2,
      segment.size = 0.2,
      alpha=0.5,
      segment.color="grey",
      segment.alpha=.25,
      direction = "both"
    )
  title2 = gsub(" ","_",title)
  ggsave(filename = paste("./figures/normalized_", title2, "_compression.png", sep = ""), plot=plot3, width=8, height= 8, dpi=600)

  plot4 <- ggplot(data = current, aes(x=percent_sampled, y=change_percent_compression, color=group)) +
    geom_point(alpha=0.75, size = 4, shape = 21, stroke = 1.5) +
    geom_line(alpha = 0.5, size = 1)+
    geom_hline(aes(yintercept = 0), lty=1, alpha=0.5, size=0.35) +
    geom_vline(aes(xintercept = 50), lty=4, alpha=0.5, size=0.35) +
    theme_classic() +
    theme(legend.position = "none",
          panel.border = element_rect(colour = "black", fill=NA, size=1),
          panel.grid.major.y = element_line(size=.25, color="white"))+
    scale_x_continuous(expand = c(0.1,0), breaks = seq(0,100,by=10))+
    scale_y_continuous(expand = c(0.1,0), breaks = seq(-100, 100, by = 5))+
    scale_color_manual(values = colors)+
    theme(panel.background = element_rect(fill = "#f5f5f5"))+
    xlab("Percent of Raw Reads")+
    ylab("Percent Change in Compression (Normalized by Sample Size)")+
    ggtitle(paste("Filtering Effect on Read Compression in ",title, sep = ""))+
    geom_text_repel(aes(x = percent_sampled, y = change_percent_compression, label = label),
                    size=4,
                    segment.size = 0.4,
                    nudge_x = -6,
                    alpha=0.5,
                    segment.color="grey",
                    segment.alpha=.75,
                    direction = "both"
    )+
    geom_point(data = rotif, shape = 3, color = "black", size = 8, stroke = 1.5)
  title2 = gsub(" ","_",title)
  ggsave(filename = paste("./figures/labelless_normalized_", title2, "_compression.png", sep = ""), plot=plot4, width=8, height= 8, dpi=600)


}

#colors = c("red", "#826f44", "#9b786f", "#4fc0f0", "#f0b124", "#568EA6", "black", "blue", "lightgrey")
# colors = c("red", "purple", "yellow", "orange", "green", "blue", "lightgrey")
colors = c("#ff2f00", "#fcba03", "#254f2e", "#0066ff", "#3d5880", "#00b828", "lightgrey")
#             FT         FT_FM      FT_PM       PT        PT_FM     PT_PM     sampling

current = subset(comp_df, comp_df$dataset == "miseq" & comp_df$read == "R1" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="miseq" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R1", ]
title = "MiSeq (R1)"
make_plots(title, current, rotif)

current = subset(comp_df, comp_df$dataset == "miseq" & comp_df$read == "R2" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="miseq" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R2", ]
title = "MiSeq (R2)"
make_plots(title, current, rotif)



current = subset(comp_df, comp_df$dataset == "hiseq125(high_output)" & comp_df$read == "R1" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="hiseq125(high_output)" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R1", ]
title = "HiSeq 2500 High Output (R1)"
make_plots(title, current, rotif)

current = subset(comp_df, comp_df$dataset == "hiseq125(high_output)" & comp_df$read == "R2" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="hiseq125(high_output)" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R2", ]
title = "HiSeq 2500 High Output (R2)"
make_plots(title, current, rotif)



current = subset(comp_df, comp_df$dataset == "hiseq250(rapid_run)" & comp_df$read == "R1" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="hiseq250(rapid_run)" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R1", ]
title = "HiSeq 2500 Rapid Run (R1)"
make_plots(title, current, rotif)

current = subset(comp_df, comp_df$dataset == "hiseq250(rapid_run)" & comp_df$read == "R2" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="hiseq250(rapid_run)" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R2", ]
title = "HiSeq 2500 Rapid Run (R2)"
make_plots(title, current, rotif)



current = subset(comp_df, comp_df$dataset == "novaseq" & comp_df$read == "R1" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="novaseq" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R1", ]
title = "NovaSeq 6000 (R1)"
make_plots(title, current, rotif)

current = subset(comp_df, comp_df$dataset == "novaseq" & comp_df$read == "R2" & comp_df$subgroup != "rotifer_uniq")
rotif = comp_df[comp_df$dataset=="novaseq" & comp_df$subgroup=="rotifer_uniq" & comp_df$read=="R2", ]
title = "NovaSeq 6000 (R2)"
make_plots(title, current, rotif)
