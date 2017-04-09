#!/bin/bash

. ./max.txt
cat _results_ab_$max.txt | grep all &
cat _results_web_rand_$max.txt | grep times 
