import sys

score_dictionary = {}

with open(sys.argv[1]) as f:
    for line in f:
        line = line.rstrip()
        if line in score_dictionary:
            score_dictionary[line] += 1
        else:
            score_dictionary[line] = 1

with open('count_' + sys.argv[1], 'w') as o:
    for k, v in score_dictionary.items():
        o.write(k + ',' + str(v) + '\n')

