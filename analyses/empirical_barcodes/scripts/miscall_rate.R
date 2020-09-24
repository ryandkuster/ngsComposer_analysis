library(ggplot2)
setwd("empirical_barcodes") # set to empirical barcodes results folder
source("./scripts/empirical_tests_combined.R")

w_d = './miseq'
platform = "MiSeq"
miseq_miscalls = see_the_calls(w_d, platform)
plot_machine(w_d, miseq_miscalls)

w_d = './hiseq_125_ho'
platform = "HiSeq2500 High-Output"
hiseq125_miscalls = see_the_calls(w_d, platform)
plot_machine(w_d, hiseq125_miscalls)

w_d = './hiseq_250_rr'
platform = "HiSeq2500 Rapid-Run"
hiseq250_miscalls = see_the_calls(w_d, platform)
plot_machine(w_d, hiseq250_miscalls)

w_d = './novaseq'
platform = "NovaSeq 6000"
novaseq_miscalls = see_the_calls(w_d, platform)
plot_machine(w_d, novaseq_miscalls)


miscalls = rbind(miseq_miscalls, hiseq125_miscalls, hiseq250_miscalls, novaseq_miscalls)
miscalls$empirical_qscore_mean = ave(miscalls$empirical_qscore, miscalls$group, miscalls$mismatch)
miscalls$instrument_qscore_mean = ave(miscalls$mean_match_and_miss, miscalls$group, miscalls$mismatch)
write.csv(miscalls, file = 'combined_miscalls.csv', row.names = FALSE)


aggdata <-aggregate(miscalls, by=list(miscalls$mismatch, miscalls$group),
                    FUN=mean, na.rm=TRUE)

sec_breaks = c(0, 10, 20, 30, 40) # 5 positions
probabilities = c(1, 0.1, 0.01, 0.001, 0.0001) # 5 positions

plot1 = ggplot()+
  geom_hline(aes(yintercept = 10), lty=1, size=1, color="white")+
  geom_hline(aes(yintercept = 20), lty=1, size=1, color="white")+
  geom_hline(aes(yintercept = 30), lty=1, size=1, color="white")+
  geom_hline(aes(yintercept = 40), lty=1, size=1, color="white")+
  geom_vline(aes(xintercept = 1.5), lty=1, size=.5)+
  geom_vline(aes(xintercept = 2.5), lty=1, size=.5)+
  geom_vline(aes(xintercept = 3.5), lty=1, size=.5)+
  #EMPIRICAL DATA
  geom_point(data=miscalls, aes(x=mismatch,y=empirical_qscore, color = factor(group)),
             size = 4,
             alpha = .5,
             shape = 15,
             position = position_dodge(width = .6))+
  geom_point(data=aggdata, aes(x=mismatch,y=empirical_qscore, color = factor(Group.2)),
             size = 7,
             shape = 0,
             position = position_dodge(width = .6))+
  #INSTRUMENT DATA
  geom_point(data=miscalls, aes(x=mismatch,y=mean_match_and_miss, color = factor(group)),
             size = 4,
             alpha = .5,
             shape = 16,
             position = position_dodge(width = .6))+
  geom_point(data=aggdata, aes(x=mismatch,y=mean_match_and_miss, color = factor(Group.2)),
             size = 7,
             shape = 1,
             position = position_dodge(width = .6))+
  #VISUAL MANIPULATIONS
  scale_color_manual(values = c("#F18C8E"  , "#F0B7A4" ,  "#568EA6"  , "#9b786f"))+ #NEW
  # scale_color_manual(values = c("#d79922", "#f13c20", "#4056a1", "#c5cbe3"))+ #B not bad
  # scale_color_manual(values = c("#F99E4C"  , "#F36F38"  , "#EF4648" ,  "#582841" ))+ #G
  # scale_color_manual(values = c( "#F18C8E"  , "#F0B7A4" ,  "#568EA6"  , "#305F72" ))+ #H good
  # scale_color_manual(values = c("#FCBB6D"  , "#D8737F"  , "#AB6C82" ,  "#685D79"))+ #I
  # scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#000000"))+ #J black not good, but good
  scale_x_continuous(limits = c(0.7, 4.3), breaks = seq(1, max(miscalls$mismatch, by = 1)))+
  scale_y_continuous(limits = c(10, 40), sec.axis = sec_axis(trans = (~.),
                     breaks = sec_breaks,
                     labels = sprintf("%.4f", probabilities),
                     name = "Probability of Miscall\n"))+
  theme_classic()+
  # ggtitle("Comparison Between Instrument and Empirical Demultiplexing Error Rates")+
  ggtitle("Instrument-derived and Empirical Error Rates in Barcode Sequences")+
  labs(color = 'Platform:')+
  ylab("Q score\n")+
  xlab("Hamming Distance")+
  theme(
    plot.title=element_text(size=20, hjust = 0.5),
    axis.text=element_text(size=16),
    axis.title=element_text(size=16),
    legend.text=element_text(size=16),
    legend.title=element_text(size=16),
    panel.border = element_rect(color = "black", fil=NA, size=1),
    legend.position = "top",
    panel.background = element_rect(fill = "#f0f2f1")
  )
plot1
ggsave(filename = "./plot1.tiff", plot=plot1, width=12, height= 7, dpi=600, compression = "lzw")

############################################################################################################


plotz = ggplot()+
  geom_hline(aes(yintercept = 10), lty=1, size=1, color="white")+
  geom_hline(aes(yintercept = 20), lty=1, size=1, color="white")+
  geom_hline(aes(yintercept = 30), lty=1, size=1, color="white")+
  geom_hline(aes(yintercept = 40), lty=1, size=1, color="white")+
  # geom_hline(aes(yintercept = 10), lty=1, size=0.25, color="gray")+
  # geom_hline(aes(yintercept = 20), lty=1, size=0.25, color="gray")+
  # geom_hline(aes(yintercept = 30), lty=1, size=0.25, color="gray")+
  # geom_hline(aes(yintercept = 40), lty=1, size=0.25, color="gray")+
  geom_vline(aes(xintercept = 1.5), lty=1, size=.5)+
  geom_vline(aes(xintercept = 2.5), lty=1, size=.5)+
  geom_vline(aes(xintercept = 3.5), lty=1, size=.5)+
  #EMPIRICAL DATA
  geom_point(data=miscalls, aes(x=mismatch,y=empirical_qscore, color = factor(group)),
             size = 4,
             alpha = .25,
             shape = 15,
             position = position_dodge(width = .6))+
  geom_point(data=aggdata, aes(x=mismatch,y=empirical_qscore, color = factor(Group.2)),
             size = 7,
             shape = 0,
             stroke = 0.75,
             position = position_dodge(width = .6))+
  #INSTRUMENT DATA
  geom_point(data=miscalls, aes(x=mismatch,y=mean_match_and_miss, color = factor(group)),
             size = 4,
             alpha = 0.25,
             shape = 16,
             position = position_dodge(width = .6))+
  geom_point(data=aggdata, aes(x=mismatch,y=mean_match_and_miss, color = factor(Group.2)),
             size = 7,
             alpha = 0.5,
             shape = 1,
             stroke = 0.75,
             position = position_dodge(width = .6))+
  #VISUAL MANIPULATIONS
  scale_color_manual(values = c("#ff2f00"  , "#fcba03" ,  "#0066ff"  , "#00b828"))+ #NEW
  scale_x_continuous(limits = c(0.7, 4.3), breaks = seq(1, max(miscalls$mismatch, by = 1)))+
  scale_y_continuous(limits = c(10, 40), sec.axis = sec_axis(trans = (~.),
                                                            breaks = sec_breaks,
                                                            labels = sprintf("%.4f", probabilities),
                                                            name = "Probability of Miscall\n"))+
  theme_classic()+
  # ggtitle("Comparison Between Instrument and Empirical Demultiplexing Error Rates")+
  ggtitle("Instrument-derived and Empirical Error Rates in Barcode Sequences")+
  labs(color = 'Platform:')+
  ylab("Q score\n")+
  xlab("Hamming Distance")+
  theme(
    plot.title=element_text(size=20, hjust = 0.5),
    axis.text=element_text(size=16),
    axis.title=element_text(size=16),
    legend.text=element_text(size=16),
    legend.title=element_text(size=16),
    panel.border = element_rect(color = "black", fill=NA, size=1),
    legend.position = "top",
    panel.background = element_rect(fill = "#f0f2f1")
  )
plotz
ggsave(filename = "./plotz.png", plot=plotz, width=10, height= 7, dpi=600)

############################################################################################################

plot2 = ggplot()+
  #INSTRUMENT DATA
  geom_point(data=miscalls, aes(x=mismatch,y=mean_match_and_miss, color = factor(group)),
             size = 4,
             alpha = .5,
             shape = 16,
             position = position_dodge(width = .5))+
  geom_point(data=aggdata, aes(x=mismatch,y=mean_match_and_miss, color = factor(Group.2)),
             size = 7,
             alpha = 1,
             shape = 1,
             position = position_dodge(width = .5))+
  #VISUAL MANIPULATIONS
  scale_color_manual(values = c("#F18C8E"  , "#F0B7A4" ,  "#568EA6"  , "#9b786f"))+ #NEW
  geom_hline(aes(yintercept = 10), lty=1, alpha=0.05, size=0.35)+
  geom_hline(aes(yintercept = 20), lty=1, alpha=0.05, size=0.35)+
  geom_hline(aes(yintercept = 30), lty=1, alpha=0.05, size=0.35)+
  geom_hline(aes(yintercept = 40), lty=1, alpha=0.05, size=0.35)+
  scale_x_continuous(limits = c(0.75, 4.25), breaks = seq(1, max(miscalls$mismatch, by = 1)))+
  scale_y_continuous(limits = c(0, 40), sec.axis = sec_axis(trans = (~.),
                                                            breaks = sec_breaks,
                                                            labels = sprintf("%.4f", probabilities),
                                                            name = "Probability of Miscall"))+
  theme_classic()+
  # ggtitle("Comparison Between Instrument and Empirical Demultiplexing Error Rates")+
  ggtitle("Instrument and Empirical Error Rates in Barcode Sequences")+
  labs(color = 'Instrument:')+
  ylab("Q score")+
  xlab("Hamming Distance")+
  theme(
    plot.title=element_text(size=20, hjust = 0.5),
    axis.text=element_text(size=16),
    axis.title=element_text(size=16),
    legend.text=element_text(size=16),
    legend.title=element_text(size=16),
    panel.border = element_rect(color = "black", fil=NA, size=1),
    legend.position = "top"
  )
plot2
ggsave(filename = "./plot2.tiff", plot=plot2, width=12, height= 7, dpi=600, compression = "lzw")


plot3 = ggplot()+
  #EMPIRICAL DATA
  geom_point(data=miscalls, aes(x=mismatch,y=empirical_qscore, color = factor(group)),
             size = 4,
             alpha = .5,
             shape = 15,
             position = position_dodge(width = .5))+
  geom_point(data=aggdata, aes(x=mismatch,y=empirical_qscore, color = factor(Group.2)),
             size = 7,
             alpha = 1,
             shape = 0,
             position = position_dodge(width = .5))+
  #VISUAL MANIPULATIONS
  scale_color_manual(values = c("#F18C8E"  , "#F0B7A4" ,  "#568EA6"  , "#9b786f"))+ #NEW
  geom_hline(aes(yintercept = 10), lty=1, alpha=0.05, size=0.35)+
  geom_hline(aes(yintercept = 20), lty=1, alpha=0.05, size=0.35)+
  geom_hline(aes(yintercept = 30), lty=1, alpha=0.05, size=0.35)+
  geom_hline(aes(yintercept = 40), lty=1, alpha=0.05, size=0.35)+
  scale_x_continuous(limits = c(0.75, 4.25), breaks = seq(1, max(miscalls$mismatch, by = 1)))+
  scale_y_continuous(limits = c(0, 40), sec.axis = sec_axis(trans = (~.),
                                                            breaks = sec_breaks,
                                                            labels = sprintf("%.4f", probabilities),
                                                            name = "Probability of Miscall"))+
  theme_classic()+
  # ggtitle("Comparison Between Instrument and Empirical Demultiplexing Error Rates")+
  ggtitle("Instrument and Empirical Error Rates in Barcode Sequences")+
  labs(color = 'Empirical:')+
  ylab("Q score")+
  xlab("Hamming Distance")+
  theme(
    plot.title=element_text(size=20, hjust = 0.5),
    axis.text=element_text(size=16),
    axis.title=element_text(size=16),
    legend.text=element_text(size=16),
    legend.title=element_text(size=16),
    panel.border = element_rect(color = "black", fil=NA, size=1),
    legend.position = "top"
  )
plot3
ggsave(filename = "./plot3.tiff", plot=plot3, width=12, height= 7, dpi=600, compression = "lzw")
