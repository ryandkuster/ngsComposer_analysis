import argparse
from argparse import RawTextHelpFormatter
import sys


def fastq_search(header, value, fastq, out):
    '''
    we know header MUST be in the file, so we search until we find the exact
    header and replace it with value, else na, upon finding header, return
    '''
    y, entry, exit = 0, '', False
    for line in fastq:
        y += 1
        if y == 1:
            if line.split()[0] == header:
                line = value + '\n'
                exit = True
            else:
                line = 'na\n'
        entry += line
        if y == 4:
            out.write(entry)
            if exit:
                return
            y, entry, exit = 0, '', False

parser = argparse.ArgumentParser(description='replace fastq header with xml outfmt 6 column', formatter_class=RawTextHelpFormatter)
parser.add_argument('-r1', type=str, required=True, metavar='',
        help='the full or relative path to R1 or R2 fastq file')
parser.add_argument('-xml', type=str, required=True, metavar='',
        help='the full or relative path to xml file in same order as fastq')
parser.add_argument('-col', type=str, required=True, metavar='',
        help='the blast outfmt 6 column to replace fastq header with\n'+
             ' 1. 	 qseqid 	 query (e.g., gene) sequence id\n' +
             ' 2. 	 sseqid 	 subject (e.g., reference genome) sequence id\n' + 
             ' 3. 	 pident 	 percentage of identical matches\n' +
             ' 4. 	 length 	 alignment length\n' +
             ' 5. 	 mismatch 	 number of mismatches\n' +
             ' 6. 	 gapopen 	 number of gap openings\n' +
             ' 7. 	 qstart 	 start of alignment in query\n' +
             ' 8. 	 qend 	 end of alignment in query\n' +
             ' 9. 	 sstart 	 start of alignment in subject\n' +
             ' 10. 	 send 	 end of alignment in subject\n' +
             ' 11. 	 evalue 	 expect value\n' +
             ' 12. 	 bitscore 	 bit score')
args = parser.parse_args()
col = int(args.col) - 1

with open(args.xml) as outfmt_6,\
     open(args.r1) as fastq,\
     open(args.r1 + '_' + args.col + '_header.fastq', 'w') as out:
    for match_line in outfmt_6:
        line_ls = match_line.split()
        header = '@' + line_ls[0]
        value = line_ls[col]
        fastq_search(header, value, fastq, out)
    print('reached end of xml file')
    fastq_search(None, None, fastq, out)
