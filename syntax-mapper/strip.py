#!/usr/bin/env python3

# strip all special token symbols out

import sys

for line in sys.stdin:
    r = line.replace ('⎣', '') \
    .replace ('⎦', '') \
    .replace ('“', '') \
    .replace ('”', '') \
    .replace ('❛', '') \
    .replace ('❜', '') \
    .replace ('・', '') \
    .replace ('⦚', '') \
    .replace ('❲', '') \
    .replace ('❳', '') \
    .replace ('⟨', '') \
    .replace ('⟩', '') \
    .replace ('‹', '') \
    .replace ('›', '') \
    .replace ('⟪', '') \
    .replace ('⟫', '') \
    .replace ('⇢', '') \
    .replace ('⇠', '') \
    .replace ('«', '') \
    .replace ('»', '') \
    .replace ('', '')
    print (r, end='')

