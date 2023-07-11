#!/bin/bash
sed -E \
    -e 's/package /\/\/ package /' \
    -e 's/import /\/\/ import /' 

