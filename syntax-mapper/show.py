#!/usr/bin/env python3

import sys

for line in sys.stdin:
    r = line.replace ('⦚', '⦚\n')
    print (r, end='')
