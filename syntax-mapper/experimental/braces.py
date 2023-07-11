#!/usr/bin/env python3

import sys

# convert remaining braces to (- ... -)
for line in sys.stdin:
    r = line.replace ('{', '(-')\
      .replace ('}', '-)')
    print (r, end='')
