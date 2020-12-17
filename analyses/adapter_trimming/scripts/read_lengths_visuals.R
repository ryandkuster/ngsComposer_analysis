library(ggplot2)
input = commandArgs(trailingOnly=TRUE)
file1 = input[1]
print(file1)
data = read.csv(file=file1, header=T, sep=",")

max_len = max(data$read_length)
max_len = max_len - as.integer(input[3])

data = data[!(data$read_length>=max_len),]
hist1 = ggplot(data) + geom_bar(aes(x=data$read_length, y=data$count), stat="identity") +
  scale_x_continuous(limits = c(0, max_len + 1))

ggsave(filename = paste(input[2], "_hist.png", sep=''), plot=hist1, width=15, height= 7.5)
