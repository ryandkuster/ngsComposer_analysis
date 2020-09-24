import argparse
import os
import sys


def compare_main():
    i1 = args.i1 #TODO create output file for corresponding lines that tools do not agree on
    o1 = args.o1
    o2 = args.o2
    n1 = args.n1 if args.n1 else 'tool_1'
    n2 = args.n2 if args.n2 else 'tool_2'
    with open(i1) as f0, open(o1) as f1, open(o2) as f2, open(os.path.basename(o1) + '_' + os.path.basename(o2) + '_compare.txt', 'w') as out1:
        for count, (line0, line1, line2) in enumerate(zip(f0, f1, f2)):
            line0 = line0.rstrip()
            line1 = line1.rstrip()
            line2 = line2.rstrip()
            if (count+1)%2 == 0 and (count+1)%4 != 0:
                if len(line1) > len(line2):
                    out1.write(n1 + ': ' + line1[len(line2):] + '\t' + n2 + ':\n')
                if len(line1) < len(line2):
                    out1.write(n1 + ': ' + '\t' + n2 + ': ' + line2[len(line1):] + '\n') 


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='compare adapter results')
    parser.add_argument('-i1', type=str, required=True,
            help='the full or relative path to source file')
    parser.add_argument('-o1', type=str, required=True,
            help='the full or relative path to output file')
    parser.add_argument('-o2', type=str, required=True,
            help='the full or relative path to output file')
    parser.add_argument('-n1', type=str,
            help='the tool name that created o1 (optional)')
    parser.add_argument('-n2', type=str,
            help='the tool name that created o2 (optional)')
    args = parser.parse_args()
    compare_main()
