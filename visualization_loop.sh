#!/usr/bin/env bash

for i in {0..4}
do
   echo "Called 0_class_conditional_sampling_DL_PROJECT.sh script with input $i"
   exec ./0_class_conditional_sampling_DL_PROJECT.sh $i
done