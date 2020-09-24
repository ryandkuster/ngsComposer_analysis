import sys
import os
import subprocess
import argparse


def crinoid_main():
    in1 = args.r1
    proj_dir = os.path.dirname(os.path.abspath(in1))
    out1 = proj_dir + '/match.' + os.path.basename(in1)
    out2 = proj_dir + '/miss.' + os.path.basename(in1)
    barcode = args.m1
    crinoid(in1, out1, out2, barcode)


def crinoid(in1, out1, out2, barcode):
    '''
    produce raw counts of nucleotide and qscore occurrences
    '''
    scores = open(os.path.dirname(os.path.abspath(__file__)) +
                  '/scores.txt').read().split()
    score_ref_dt = dict(zip(scores[:41], scores[-int(len(scores)/2):
                        -int(len(scores)/2)+41]))
    with open(in1) as f, open(out1, "w") as o1, open(out2, "w") as o2:
        y = 0
        miss_dt = {i: {j: 0 for j in score_ref_dt.keys()}
                    for i in range(len(barcode))}
        match_dt = {i: {j: 0 for j in score_ref_dt.keys()}
                    for i in range(len(barcode))}
        for line in f:
            y += 1
            if y == 2:
                miss_ls, match_ls = [], []
                for i, base in enumerate(barcode):
                    if barcode[i] != line[i]:
                        miss_ls.append(i)
                    else:
                        match_ls.append(i)
            if y == 4:
                for i in miss_ls:
                    miss_dt[i][line[i]] += 1
                for i in match_ls:
                    match_dt[i][line[i]] += 1
                y = 0
        miss_mx = [[0] * len(miss_dt[0]) for i in range(len(barcode))]
        miss_mx = output_prep(miss_dt, miss_mx, score_ref_dt, 0)
        matrix_print(miss_mx, o2)

        match_mx = [[0] * len(match_dt[0]) for i in range(len(barcode))]
        match_mx = output_prep(match_dt, match_mx, score_ref_dt, 0)
        matrix_print(match_mx, o1)


def output_prep(dt1, mx, dt2, col):
    '''
    use recursion to extract counts from nested dictionaries
    '''
    for k1, v1 in dt1.items():
        if isinstance(v1, dict):
            output_prep(v1, mx, dt2, k1)
        else:
            for k2, v2 in dt2.items():
                if k1 == k2:
                    mx[int(col)][int(v2)] = v1
    return mx


def matrix_print(mx, outfile):
    '''
    write matrix of raw counts to csv file
    '''
    for row in mx:
        outfile.write(",".join(str(x) for x in row))
        outfile.write("\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='qc summary statistics')
    parser.add_argument('-r1', type=str,
            help='the full or relative path to R1 or R2 fastq file')
    parser.add_argument('-m1', type=str,
            help='barcode string')
    args = parser.parse_args()
    crinoid_main()
