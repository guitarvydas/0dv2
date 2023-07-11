#!/usr/bin/env python3

# bracket compound operators with ⟪...⟫

import sys

for line in sys.stdin:
    r = line.replace ('==', '⟪==⟫')\
      .replace (':=', '⟪:=⟫') \
      .replace ('&&', '⟪&&⟫')
    print (r, end='')
