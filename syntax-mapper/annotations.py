#!/usr/bin/env python3
import sys

for line in sys.stdin:
    r = line.replace ('/*⎨', '⎨')\
      .replace ('⎬*/', '⎬')
    print (r, end='')
