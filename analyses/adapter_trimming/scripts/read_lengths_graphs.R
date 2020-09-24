library(ggplot2)

rm(list=ls())

data1 = read.csv(file='adapter_miseq_R1.fastq_readcounts.csv', header=T, sep=",")
group = rep("adapter",length(data1$read_length))
data1 = cbind(data1, group)

data2 = read.csv(file='/home/ryan/Desktop/adapter_testing/miseq_mwanga/comparison/tiny.R1.fastq_readcounts.csv', header=T, sep=",")
group = rep("adapter_tiny",length(data2$read_length))
data2 = cbind(data2, group)

data3 = read.csv(file='/home/ryan/Desktop/adapter_testing/miseq_mwanga/comparison/adapter_miseq_no_RE_R1.fastq_readcounts.csv', header=T, sep=",")
group = rep("adapter_bc",length(data3$read_length))
data3 = cbind(data3, group)

data4 = read.csv(file='/home/ryan/Desktop/adapter_testing/miseq_mwanga/comparison/adapter_miseq_with_RE_R1.fastq_readcounts.csv', header=T, sep=",")
group = rep("adapter_bc_RE",length(data4$read_length))
data4 = cbind(data4, group)

data5 = read.csv(file='/home/ryan/Desktop/adapter_testing/miseq_mwanga/comparison/adapter_bc_RE_tiny_R1.fastq_readcounts.csv', header=T, sep=",")
group = rep("adapter_bc_RE_tiny",length(data5$read_length))
data5 = cbind(data5, group)


max_len = max(data1$read_length, data2$read_length, data3$read_length)
 
data = rbind(data1, data3, data4) #compare effectiveness of bc/RE

lines = ggplot(data, aes(x=read_length, y=count, color=group)) +
  geom_line(alpha=0.7, size = 1.5)+
  scale_x_continuous(limits = c(0, max_len -4)) +
  scale_y_continuous(limits = c(0, 25000)) +
  theme_classic()
lines
ggsave(filename = "/home/ryan/Desktop/tool_comparison.tiff", plot=lines, width=15, height= 7.5, dpi=600, compression = "lzw")
ggsave(filename = "/home/ryan/Desktop/with_without_bc_RE.tiff", plot=lines, width=15, height= 7.5, dpi=600, compression = "lzw")
ggsave(filename = "/home/ryan/Desktop/tiny_comparison.tiff", plot=lines, width=15, height= 7.5, dpi=600, compression = "lzw")
