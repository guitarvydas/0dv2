#!/bin/bash
./debug-cleanup.py <$1 | ./indenter.py | ./show.py
