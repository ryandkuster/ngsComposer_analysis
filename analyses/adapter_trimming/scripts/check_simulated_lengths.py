'''
sys.argv[1] is the uncompressed, adapter-trimmed fastq file
sys.argv[2] is a modifier for length if, for example, RE motifs
are built into adapters, but technically don't exist within the
cut fragment of non-synthetic DNA (e.g., Olukolu 'OmeSeq')
if 'TGCA' and 'CATG' flank every read, use 8 to offset
'''

import pandas as pd
import sys


fastq = sys.argv[1]
modifier = int(sys.argv[2])
i = 0
expected = []
observed = []


with open(fastq) as trimmed:
    for line in trimmed:
        i += 1
        if i == 1:
            expected.append(int(line.split(':')[3]))
        if i == 2:
            observed.append(len(line.rstrip()) - modifier)
        if i == 4:
            i = 0

df = pd.DataFrame(observed, columns=['observed'])
df['expected'] = expected
max_len = max(df['observed'])
df['o_minus_e'] = [abs(i - j) if j <= max_len else 0 for i, j in zip(df['observed'], df['expected'])]

'''
keep only those reads deviating
'''
index_names = df[df['o_minus_e'] == 0].index
df.drop(index_names, inplace=True)
df.reset_index(inplace=True, drop=True)
df.to_csv('incorrect_adapter_trims.csv')
print(df['o_minus_e'].describe())
