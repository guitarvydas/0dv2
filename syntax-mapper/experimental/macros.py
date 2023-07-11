#!/usr/bin/env python3

# simple Symbol Macro replacer for Odin code

# FIFO :: queue.Queue(Message)
# fifo_push :: queue.push_back
# fifo_pop :: queue.pop_front_safe


import sys

for line in sys.stdin:
    # # first delete macro defs
    # rdel = line.replace (r'FIFO +\:\:.*', '')\
    #   .replace (r'fifo_push +\:\:.*', '')\
    #   .replace (r'fifo_pop +\:\:.*', '')
    # then, do replacements
    r = line.replace ('FIFO', 'queue.Queue(Message)')\
      .replace ('fifo_push', 'queue.push_back')\
      .replace ('fifo_pop', 'queue.pop_front_safe') \
      .replace ('ENTER', 'Port("__STATE_ENTER__")') \
      .replace ('EXIT', 'Port("__STATE_EXIT__")')
    print (r, end='')
