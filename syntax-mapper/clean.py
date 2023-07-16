#!/usr/bin/env python3

import sys
import re

# for line in sys.stdin:
#     r0 = line.replace ('\n', 'Z').replace ('⦚', 'Z').replace ('❫','Q')
# #    r = r0.replace (r'⦚❫', 'X')
# #    r = r0.replace ("⦚", "C")
# #    r = re.sub (r"⦚❫", "K", r0)
# #    r = r0.replace (r"⦚⦚"gm, "H")
#     print (r0)
#     r = re.sub (r"QZ", "R", r0)
# #    r = r0.replace ('ZQ','P')
#     print (r)


s0 = sys.stdin.read()
s1 = s0.replace ('⦚', '\n').replace ('\n❫', '❫')
s = re.sub (r'\n+', '\n', s1)
print (s)
