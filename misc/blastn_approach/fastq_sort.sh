for i in *R1.fastq; do \
  awk '{ printf "%s", $0; if (NR % 4 == 0) print ""; else printf "\t" }' $i OFS='\t' > one_liner_${i%%.fastq}.txt ;
  sort -k 1 one_liner_${i%%.fastq}.txt > sorted_${i%%.fastq}.txt ;
  rm one_liner_${i%%.fastq}.txt ;
  awk -F '\t' '{print $1"\n"$2"\n"$3"\n"$4}' sorted_${i%%.fastq}.txt > sorted_$i ;
  rm sorted_${i%%.fastq}.txt ;
done

