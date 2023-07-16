#!/usr/bin/env python3

import sys

for line in sys.stdin:
    r0 = line
    r = r0.replace ('・', '').replace ('⦚', '\n').replace ('◦', '').replace ('¶', '').replace ('□', '').replace ('‡', '').replace ('☐', '').replace ('†', '').replace ('❳❲', '❳ ❲').replace ('❲', '').replace ('❳', '').replace ('⟨', '').replace ('⟩', '').replace ('‹', '').replace ('›', '').replace ('⟪', '').replace ('⟫', '')
    print (r, end='')

