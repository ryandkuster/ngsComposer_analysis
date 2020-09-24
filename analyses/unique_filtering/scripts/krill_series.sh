#!/bin/bash


#stdin 1 is a gzipped fastq file

function pass_fail {
    pass_reads=$(< se* wc -l)
    fail_reads=$(< failed* wc -l)
    pass_reads=$(expr $pass_reads / 4)
    fail_reads=$(expr $fail_reads / 4)
    sed -n '2~4p' se* | sort | uniq > uniq.pass.txt
    sed -n '2~4p' failed* | sort | uniq > uniq.failed.txt
    pass_uniq=$(< uniq.pass.txt wc -l)
    fail_uniq=$(< uniq.failed.txt wc -l)
    rm uniq*
}


input=$1
output=${input%%.fastq.gz}.txt
echo $output
echo "uniq total q30p_ krill rotifer" > $output
for i in $(seq 10 10 100); do
    python3 ./krill_fails.py -r1 $input -q 30 -p $i
    pass_fail
    echo $pass_uniq $pass_reads  $i "pass" "" >> $output
    echo $fail_uniq $fail_reads  $i "fail" "" >> $output
    mv se* tmp_pass.fastq
    mv failed* tmp_fail.fastq

    python3 ./rotifer_fails.py -r1 tmp_pass.fastq -m1 TGCAT CATG
    pass_fail
    echo $pass_uniq $pass_reads  $i "pass" "pass" >> $output
    echo $fail_uniq $fail_reads  $i "pass" "fail" >> $output
    rm se* failed* tmp_pass.fastq

    python3 ./rotifer_fails.py -r1 tmp_fail.fastq -m1 TGCAT CATG
    pass_fail
    echo $pass_uniq $pass_reads  $i "fail" "pass" >> $output
    echo $fail_uniq $fail_reads  $i "fail" "fail" >> $output
    rm se* failed* tmp_fail.fastq
done
