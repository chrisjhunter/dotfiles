#!/bin/bash

for next in $( git ls-files --others --exclude-standard ) 
do
    git --no-pager diff --no-index /dev/null $next
done

