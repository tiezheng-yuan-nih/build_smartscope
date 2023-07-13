#! /usr/bin/python3
import os
import sys

def get_file(indir, extension):
    res = []
    pool = [indir,]
    while pool:
        this_dir = pool.pop(0)
        for root, dirs, files in os.walk(this_dir, topdown=False):
            for d in dirs:
                if not d.startswith('_') and not d.startswith('.'):
                    dir_path = os.path.join(root, d)
                    pool.append(dir_path)
            for file in files:
                if file.endswith(extension) and not file.startswith('_') \
                    and not file.startswith('.'):
                    file_path = os.path.join(root, file)
                    if file_path not in res:
                        res.append(file_path)
    return res

def detect_line(infile, target):
    res = []
    target = target.lower()
    with open(infile, 'r') as f:
        for line in f:
            if target in line.lower():
                res.append(line)
    return res

if __name__== "__main__":
    indir = '/home/yuant2/nieh/build_smartscope/SmartScope/Smartscope'
    files = get_file(indir, '.py')
    for file in files:
        res = detect_line(file, 'DEFAULT_UMASK')
        if res:
            print('###########\n', file)
            for r in res:
                print(f"\t{r}")
