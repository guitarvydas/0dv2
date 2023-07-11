#!/bin/bash
sed -E \
    -e '/FIFO +\:\:/d' \
    -e '/fifo_push +\:\:/d' \
    -e '/fifo_pop +\:\:/d' \
    -e '/ENTER +\:\:/d' \
    -e '/EXIT +\:\:/d'
