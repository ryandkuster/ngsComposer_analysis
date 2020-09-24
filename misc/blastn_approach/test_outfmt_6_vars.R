file1 = "/media/drive_b/Ryan/composer_analysis/analysis/hiseq_2x250_ngscomposer/ref_alignment/split_files_R1/1_combined.R1_output.xml"
data1 = read.table(file=file1, header = F, sep = '\t')
names(data1) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
hist(data1$bitscore, breaks = 500)
hist(-log10(data1$evalue), breaks = 500)
hist(data1$gapopen, breaks = 500)
hist(data1$mismatch, breaks = 500)
hist(data1$length, breaks = 500)
hist(data1$pident, breaks = 500)

length_match = ((data1$pident/100) * data1$length) - data1$mismatch - data1$mismatch
hist(length_match, breaks = 500)
