import argparse
import os
from argparse import RawTextHelpFormatter
import sys


def fastq_search(header, value, line_ls, fastq, out):
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
                line = '\t'.join(['na' for i in line_ls]) + '\n'
        entry += line
        if y == 4:
            out.write(entry)
            if exit:
                return
            y, entry, exit = 0, '', False

parser = argparse.ArgumentParser(description='replace fastq header with entire xml line, qseqid MUST BE FIRST', formatter_class=RawTextHelpFormatter)
parser.add_argument('-r1', type=str, required=True, metavar='',
        help='the full or relative path to R1 or R2 fastq file')
parser.add_argument('-xml', type=str, required=True, metavar='',
        help='the full or relative path to xml file in same order as fastq')
args = parser.parse_args()

with open(args.xml) as xml,\
     open(args.r1) as fastq,\
     open(os.path.basename(args.r1) + '_blast_output_header.fastq', 'w') as out:
    for match_line in xml:
        line_ls = match_line.split()
        value = '\t'.join([str(i) for i in line_ls])
        header = '@' + line_ls[0]
        fastq_search(header, value, line_ls, fastq, out)
    print('reached end of xml file, successfully identified all xml qseqids')
    fastq_search(None, None, line_ls, fastq, out)
