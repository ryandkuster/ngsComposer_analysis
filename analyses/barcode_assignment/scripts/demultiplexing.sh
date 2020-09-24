#all tools run from within mismatch folder, e.g. '0mm', with barcodes in folder containing '0mm'

#GBSX commit c881f60 on Aug 19, 2016
java -jar /GBSX_v1.3.jar --Demultiplexer -f1 ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -i ../hiseq_misassignment_gbsx.txt -o ./ -rad false -mb 0 -s 0 -minsl 50 -t 1
java -jar /GBSX_v1.3.jar --Demultiplexer -f1 ../../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -i ../hiseq_misassignment_gbsx_by_len.txt -o ./ -mb 8 -me 9

#sabre last github commit Sep 27, 2013
/sabre-master/sabre se -f ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -b ../hiseq_misassignment_sabre.txt -u unknowns.fastq
/sabre-master/sabre se -f ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -b ../hiseq_misassignment_sabre.txt -u unknowns.fastq -m 1

#ea-utils fastq-multx version 1.04.807 from Jan 26, 2017
/ea-utils/clipper/fastq-multx -B ../hiseq_misassignment_multx.txt ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -o %.fastq
/ea-utils/clipper/fastq-multx -B ../hiseq_misassignment_multx.txt ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -o %.fastq -m 1

#TagGD commit d778dcc on May 10, 2019
#while running the following:
#/taggd/scripts/taggd_demultiplex.py --overhang 0 --metric Hamming ../hiseq_misassignment_taggd.txt ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq ./
#received this error:
#'ValueError: Barcode file incorrect, varying lengths among barcodes'

#axe commit c1039c7 on Sep 5, 2019
/axe/bin/axe-demux -f ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -F ./ -b ../hiseq_misassignment_axe.txt
/axe/bin/axe-demux -f ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -F ./ -b ../hiseq_misassignment_axe.txt -p
/axe/bin/axe-demux -f ../../raw_data/trimmed_se.hiseq125_R1_1M.fastq -F ./ -b ../hiseq_misassignment_axe.txt -m 1
