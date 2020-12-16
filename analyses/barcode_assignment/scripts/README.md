# sample hiseq high output R1 file to first 1 million reads
sed -n '1,4000000p;4000001q' <input> > hiseq125_R1_1M.fastq

# trim 6 base buffer sequence to prepare for demultiplexing
python3 <path_to_ngscomposer>/tools/scallop.py -r1 hiseq125_R1_1M.fastq -f 6
