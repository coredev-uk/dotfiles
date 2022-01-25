#!/bin/sh

updates=$(paru -Qu | wc -l)
if [ $updates -gt 5 ]; then
    echo "%{T2}%{T-}  $updates"
else
    echo ""
fi
