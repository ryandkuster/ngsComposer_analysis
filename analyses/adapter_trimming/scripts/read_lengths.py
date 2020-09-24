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
    'read_lengths_visuals.R')] + [os.path.abspath(output), sys.argv[2]], shell=False)
