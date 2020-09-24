#!/bin/bash

#TO USE:
#type in bash <this script> <sequences_only_file> <krill_series_file>
#the files should consist of only sequence reads from fastq source
#(if needed, run sed -n '2~4p' <fastq>)

reps=3

script_dir=$(dirname "$0")
input=$1
series_file=$2
read_no=$(< "$input" wc -l)
loop_no=$(< "$series_file" wc -l)
loop_no=$(expr $loop_no - 1)

awk '{if(NR==1) print $0}' $series_file > final_big_${series_file}

for i in $(seq 1 $loop_no); do
    i=$(expr $i + 1)
    samples=$(awk -v var="$i" '{if(NR==var) print $2}' $series_file)
    percent=$(python3 -c "print($samples / $read_no)")
    previous_line=$(awk -v var="$i" '{if(NR==var) print $0}' $series_file)
    write=""
    for j in $(seq $reps); do
        echo 'performing' $samples 'samples' $j 'of' $reps
        cat $input | awk -v var="$percent" 'BEGIN {srand()} !/^$/ { if (rand() <= var) print $0}' > sample_tmp.txt
        sort sample_tmp.txt | uniq > uniq_tmp.txt
        uniq_reads=$(< "uniq_tmp.txt" wc -l)
        write="$write $uniq_reads"
        rm uniq_tmp.txt sample_tmp.txt
        sleep 1
    done
    echo $previous_line $write >> final_big_${series_file}
done


