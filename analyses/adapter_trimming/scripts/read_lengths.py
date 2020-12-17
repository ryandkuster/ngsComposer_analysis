'''
sys.argv[1] is an adapter trimmed fastq file (uncompressed)
sys.argv[2] is the name of the output histogram
sys.argv[3] excludes n last positions from the plot
(x axis; in libraries containing few instances of adapter-
contamination the y-axis will reflect the longest reads only,
use the maximum read length minus 1-n where n is difference in
readlengths from variable length barcodes)
'''

import os
import subprocess
import sys


output = sys.argv[1] + '_readcounts.csv'

read_counts = {}

with open(sys.argv[1]) as f, open(output, 'w') as o:
    n = 0
    for line in f:
        n += 1
        if n == 4:
            n = 0
            if len(line.rstrip()) in read_counts:
                read_counts[len(line.rstrip())] += 1
            else:
                read_counts[len(line.rstrip())] = 1

    o.write('read_length,count\n')
    for k, v in read_counts.items():
        write_out = (str(k) + ',' + str(v) + '\n')
        o.write(write_out)


subprocess.check_call(['Rscript',
    os.path.join(os.path.dirname(__file__),
    'read_lengths_visuals.R')] + [os.path.abspath(output), sys.argv[2], sys.argv[3]], shell=False)
