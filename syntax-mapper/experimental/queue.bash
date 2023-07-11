#!/bin/bash
sed -E \
    -e 's/queue.push_back\(\&([^,]+),(.*)\)/\1.enqueue (\2)/g'\
    -e 's/queue.pop_front_safe\(\&([^\)]+)\)/\1.dequeue ()/g'
