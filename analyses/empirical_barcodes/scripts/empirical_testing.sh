# create barcodes file where output name is the barcode sequence
# perform demultiplexing with anemone_no_trim.py with 0 mismatch
# repeat with increasing mismatch using unknown file (write to 0mm, 1mm, etc. directories)

#barcodes=HiSeq_BT_high_output_empirical_barcodes
#input=trimmed.Mwanga_GBSpoly_nolig_S1_R1_001.fastq

#barcodes=mwanga_empirical_test_barcodes
#input=trimmed.Mwanga-GBSpoly-nolig_S1_L001_R1_001.fastq

if [ -n "$barcodes" ]; then echo 'barcodes defined'; else echo 'please define barcodes';  fi
if [ -n "$input" ]; then echo 'input defined'; else echo 'please define input';  fi

START=0
END=8

#demultiplex files sequentially
for i in $(seq $START $END); do
mkdir $i'mm'
python3 ./anemone_no_trim.py \
        -c $barcodes \
        -r1 $input \
        -o ./${i}mm/ \
        -m $i
input=./${i}mm/unknown*
done

# count the occurences of mismatches and matches
for i in $(seq $START $END); do
    cd $i'mm'
    rm match* miss*
    for i in [ACGT]*.fastq; do
        python3 ./nova_miscall.py -r1 $i -m1 ${i%.R1.fastq}
    done
    touch miss.total.txt match.total.txt
    for i in miss.*.fastq; do
        python3 ./matrix_cat.py -a1 $i -a2 miss.total.txt -l 20 -o miss.total.txt
    done
    for i in match.*.fastq; do
        python3 ./matrix_cat.py -a1 $i -a2 match.total.txt -l 20 -o match.total.txt
    done
    rm miss.*.fastq match.*.fastq
    cd ..
done

