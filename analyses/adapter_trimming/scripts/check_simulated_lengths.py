import pandas as pd
import sys

'''
sys.argv[1] is the uncompressed, adapter-trimmed fastq file
sys.argv[1] is the uncompressed, fastq file before trimming
sys.argv[3] is a modifier for length if, for example, RE motifs
are built into adapters, but technically don't exist within the
cut fragment of non-synthetic DNA (e.g., Olukolu 'OmeSeq')
if 'TGCA' and 'CATG' flank every read, use 8 to offset
sys.argv[4] is the name of the csv dateframe to write to file
'''

fastq1 = sys.argv[1]
fastq2 = sys.argv[2]
modifier = int(sys.argv[3])
outname = sys.argv[4]

i = 0
expected = []
read_id = []
observed = []
read_len = []
contaminated = []
o_minus_e = []
false_id = []
missed_id = []


with open(fastq1) as trimmed, open(fastq2) as original:
    for line1, line2 in zip(trimmed, original):
        i += 1

        if i == 1:
            exp_len = int(line1.split(':')[3])
            expected.append(exp_len)
            read_id.append(line1.split(':')[0][1:])

        if i == 2:
            obs_len = len(line1.rstrip()) - modifier
            untrimmed_len = len(line2.rstrip()) - modifier
            observed.append(obs_len)
            read_len.append(untrimmed_len)

            if exp_len <= untrimmed_len:
                contaminated.append(1)
                diff = obs_len - exp_len
                o_minus_e.append(diff)
            else:
                contaminated.append(0)
                diff = obs_len - untrimmed_len
                o_minus_e.append(diff)

            if diff > 0:
                missed_id.append(1)
                false_id.append(0)
            elif diff < 0:
                missed_id.append(0)
                false_id.append(1)
            else:
                missed_id.append(0)
                false_id.append(0)

        if i == 4:
            i = 0

df = pd.DataFrame(read_id, columns=['read_id'])
df['observed'] = observed
df['expected'] = expected
df['read_len'] = read_len
df['o_minus_e'] = o_minus_e
df['contaminated'] = contaminated
df['missed_id'] = missed_id
df['false_id'] = false_id

print('all reads:')
print(df['o_minus_e'].describe())

print('\nreads containing adapters:')
print(df['contaminated'].value_counts())

print('\nreads containing missed adapters:')
print(df['missed_id'].value_counts())

print('\nreads containing falsely-identified adapters:')
print(df['false_id'].value_counts())

'''
keep only those reads deviating (untrimmed or perfectly detected adapters ignored)
'''
index_names = df[df['o_minus_e'] == 0].index
df.drop(index_names, inplace=True)
df.reset_index(inplace=True, drop=True)

print('\nmisidentified reads:')
print(df['o_minus_e'].describe())

'''
sort by differences
'''
df = df.sort_values(['o_minus_e'])

df.to_csv(outname + '_misses.csv', index=False)
