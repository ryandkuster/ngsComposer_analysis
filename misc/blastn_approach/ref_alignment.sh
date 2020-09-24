#2020.05.07 approach - use uniq reads to measure how 'collapsable' data is

for i in *.gz; do zcat $i | sed -n '2~4p' | sort | uniq > ./rotifer_uniq/uniq.${i%%fastq_11_header.fastq.gz}txt ; done
for i in *.gz; do zcat $i | sed -n '2~4p' > ./rotifer_uniq/all.${i%%fastq_11_header.fastq.gz}txt ; done

#change to root directory for blastn reference project...
dataset='miseq'
echo -e 'file\tunique_reads\ttotal_reads\tpercent\tdirname\tdataset' > miseq_uniq.txt

#for each individual project (e.g. rotifer, rotifer_then_krill, krill, krill_then_rotifer), do the following:
dirname=${PWD##*/}

for i in uniq.* ; do uniq_count=$(< "$i" wc -l) ; all_count=$(< "all${i#uniq}" wc -l) ; answer=$(echo "result = ($uniq_count/$all_count) * 100 ; scale=4; result / 1" | bc -l) ; echo -e ${i#uniq.}'\t'$uniq_count'\t'$all_count'\t'$answer'\t'$dirname'\t'$dataset >> ../../hiseq125_uniq.txt ; done


######################################################
######################################################
######################################################
#consider splitting large fastq files in a way that retains order (decreases blast time)
/home/ryan/github/fastools/fastq_handling/split_fq.sh

#convert fastq to fasta
for i in combined*;
  do paste - - - - < $i | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > ${i%%q}a;
done

for i in [1234567890]*.fastq;
  do paste - - - - < $i | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > ${i%%q}a;
done


#create index of trifida/triloba/chloroplast reference fastas
for i in *.fasta; do /home/ryan/Tools/ncbi-blast-2.10.0+/bin/makeblastdb -in $i -dbtype nucl; done

#map to reference with the single best hit retained
for i in *.fasta;
  do /home/ryan/Tools/ncbi-blast-2.10.0+/bin/blastn \
  -db /media/drive_b/Ryan/composer_analysis/analysis/reference_genomes/TF_TL_SPchloroplast.fasta \
  -outfmt 6 \
  -query $i \
  -max_hsps 1 \
  -max_target_seqs 1 \
  > ${i%%.fasta}_output.xml &
done


for i in *.fasta;
  do /home/ryan/Tools/ncbi-blast-2.10.0+/bin/blastn \
  -db /media/drive_b/Ryan/composer_analysis/analysis/reference_genomes/TF_TL_SPchloroplast.fasta \
  -outfmt "6 qseqid sseqid pident length mismatch gapopen gaps qstart qend sstart send qseq sseq evalue bitscore score frames qframe sframe qcovs qcovhsp qcovus" \
  -query $i \
  -max_hsps 1 \
  -max_target_seqs 1 \
  > ${i%%.fasta}_output.xml &
done

#if multithreading blastn, it will be necessary to sort the fastq and xml files before running read_grabber.py

#run read_grabber.py to assign evalues in place of headers in original fastq file
python3 /media/drive_b/Ryan/composer_analysis/scripts/empirical_tests/blastn_approach/read_grabber.py -r1 combined.R1.fastq -xml combined.R1_output.xml -col 11

#run rotifer/krill at various settings
for i in *evalue_header.fastq; do for p in `seq 5 5 100`; do for q in `seq 5 5 40`; do python3 /media/drive_b/Ryan/composer_analysis/scripts/krill_fails.py -r1 $i -p $p -q $q -o krill/; done; done; done
for i in *_header.fastq; do for p in `seq 10 10 100`; do python3 /media/drive_b/Ryan/composer_analysis/scripts/krill_fails.py -r1 $i -p $p -q 30 -o krill/; done; done

python3 /media/drive_b/Ryan/composer_analysis/scripts/rotifer_fails.py -r1 combined.R1.fastq_11_header.fastq -m1 TGCA -o ./rotifer/


#grab all the header lines
#if pulling only desired column using read_grabber.py
for i in *11_header.fastq; do sed -n '1~4p' $i > ${i%%fastq_11_header.fastq}scores.txt ; done

#if pulling entire blastn lines as headers using read_grabber_any_outfmt.py (specify column in awk)
for i in *fastq_blast_output_header.fastq; do sed -n '1~4p' $i | awk '{print $11}' > ${i%%fastq_blast_output_header.fastq}TF_TL_SP_scores.txt ; done

#if plotting with density functions in ggplot2, consider running score_dict.py to create a dictionary of scores as a csv file...
for i in *scores.txt; do python3 /media/drive_b/Ryan/composer_analysis/scripts/empirical_tests/blastn_approach/score_dict.py $i ; done

#confirm that the total number of evalue and na counts total the original fastq file...





######################################################
######################################################
######################################################


~/Tools/bwa-0.7.17/bwa mem /media/drive_b/Ryan/composer_analysis/analysis/reference_genomes/Chr01_NSP306_trifida_chr_v3.fasta se.combined.R2.fastq > se.combined.R2_bwa_mem_Chr1_TF_ref.sam


#sort and convert to .bam
samtools view -bS se.combined.R2_bwa_mem_Chr1_TF_ref.sam | samtools sort -o se.combined.R2_bwa_mem_Chr1_TF_ref.bam
samtools index se.combined.R2_bwa_mem_Chr1_TF_ref.bam
