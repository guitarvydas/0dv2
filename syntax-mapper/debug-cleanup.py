#!/usr/bin/env python3

import sys
import re

line = sys.stdin.read ()
r0 = line.replace ('・', ' ').replace ('⦚', '\n').replace ('◦', ' ').replace ('¶', '\n').replace ('□', ' ').replace ('‡', '\n').replace ('☐', ' ').replace ('†', '\n')
r1 = re.sub (' +\n', '\n', r0)
r = re.sub ('\n+', '\n', r1)
print (r, end='')
