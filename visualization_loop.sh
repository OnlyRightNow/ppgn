#!/usr/bin/env bash

# Take in a unit number
if [ "$#" -ne "1" ]; then
  echo "Please provide the number of the run"
  exit 1
fi

run_number=${1}

# THESE PARAMETERS CAN BE CHANGED!
iteration_numbers=(10000 50000 100000)
iteration_numbers_len=2

# create a vector with elements 0..run_number




# Define the names of the neurons and of the folder containing the weight files
if [ ${run_number}=1 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run1_cat_baseball_car_airplane_face"
   neuron_names=("cat" "baseball" "car" "airplane" "face")
   max_neuron_number=4
fi

if [ ${run_number}=2 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run2_dog_cat_female_male_ball"
   neuron_names=("dog" "cat" "female" "male" "ball")
   max_neuron_number=4
fi

if [ ${run_number}=3 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run3_animal_gender_tennisball_soccerball_baseball"
   neuron_names=("animal" "gender" "tennisball" "soccerball" "basketball")
   max_neuron_number=4
fi

# TODOTODOTODO
# ADD THE OTHER RUNS HERE

if [ ${run_number}=6 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run6_dog_cat_female_male_ball_100"
   neuron_names=("dog" "cat" "female" "male" "ball")
   max_neuron_number=4
fi

echo "iteration numbers len ${iteration_numbers_len}"
echo "Max neuron number ${max_neuron_number}"

for n in `seq 0 ${iteration_numbers_len}`; do
   net_weights="${folder_name}/solver_iter_${iteration_numbers[n]}.caffemodel"
   echo "net weights path ${net_weights}"

   for i in `seq 0 ${max_neuron_number}`; do
      echo "Called 0_class_conditional_sampling_DL_PROJECT.sh script with input $i"
      # parameters: neuron number, neuron name, weight name, run number, iteration number
      ./0_class_conditional_sampling_DL_PROJECT.sh $i ${neuron_names[i]} $net_weights $run_number ${iteration_numbers[n]}
   done
done
