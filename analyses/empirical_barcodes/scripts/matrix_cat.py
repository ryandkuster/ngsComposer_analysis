import argparse, sys


def main():
    with open(args.a1) as f1, open(args.a2) as f2:
        a = [line.rstrip().split(',') for line in f1]
        b = [line.rstrip().split(',') for line in f2]
        if b:
            pass
        else:
            b = [[0 for j in range(len(a[0]))] for i in range(args.l)]
        for i, col in enumerate(b):
            for j, score in enumerate(col):
                try:
                    b[i][j] = int(b[i][j]) + int(a[i][j])
                except IndexError:
                    break
    with open(args.o, 'w') as o1:
        for row in b:
            o1.write(",".join(str(x) for x in row))
            o1.write("\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='combine matrices of equal dimensions')
    parser.add_argument('-a1', type=str,
            help='the full or relative path to 2d array 1')
    parser.add_argument('-a2', type=str,
            help='the full or relative path to 2d array 2 (can be empty file for use in for loop)')
    parser.add_argument('-o', type=str,
            help='the full or relative path to write out to')
    parser.add_argument('-l', type=int,
            help='length of maximum array length to be used for empty array')
    args = parser.parse_args()
    main()
