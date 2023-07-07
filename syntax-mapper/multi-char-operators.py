#!/usr/bin/env python3

# simple Symbol Macro replacer for Odin code

# FIFO :: queue.Queue(Message)
# fifo_push :: queue.push_back
# fifo_pop :: queue.pop_front_safe


import sys

for line in sys.stdin:
    r = line.replace ('==', '⟪==⟫')\
      .replace (':=', '⟪:=⟫') \
      .replace ('&&', '⟪&&⟫')
    print (r, end='')
