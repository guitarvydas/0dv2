#!/bin/bash
sed -E \
    -e 's/append\(\&([^,]+),(.*)\)/\1.append (\2)/g'
