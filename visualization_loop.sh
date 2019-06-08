#!/usr/bin/env bash

# define the numbers of the runs in an array
run_numbers=(2 3 5 6)

# loop over all runs and visualize features with certain weight files
for run_number in "${run_numbers[@]}"; do

# THESE PARAMETERS CAN BE CHANGED!
if [${run_number}=1]; then
    iteration_numbers=(10000 50000 130000)
else
    iteration_numbers=(5000 10000 50000 100000)
fi

iteration_numbers_len=`echo "${#iteration_numbers[@]} - 1" | bc`

# Define the names of the neurons and of the folder containing the weight files
if [ ${run_number}=1 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run1_cat_baseball_car_airplane_face"
   neuron_names=("cat" "baseball" "car" "airplane" "face")

   max_neuron_number=`echo "${#neuron_names[@]} - 1" | bc`
fi

if [ ${run_number}=2 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run2b_dog_cat_female_male_ball"
   neuron_names=("dog" "cat" "female" "male" "ball")
   max_neuron_number=`echo "${#neuron_names[@]} - 1" | bc`
fi

if [ ${run_number}=3 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run3_animal_gender_tennisball_soccerball_baseball"
   neuron_names=("animal" "gender" "tennisball" "soccerball" "basketball")
   max_neuron_number=`echo "${#neuron_names[@]} - 1" | bc`
fi

if [ ${run_number}=5 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run5_golfnKeyboard_billiardball_tennisball_soccerball_basketball"
   neuron_names=("golfnKeyboard" "billardball" "tennisball" "soccerball" "basketball")
   max_neuron_number=`echo "${#neuron_names[@]} - 1" | bc`
fi

if [ ${run_number}=6 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run6_dog_cat_female_male_ball_100"
   neuron_names=("dog" "cat" "female" "male" "ball")
   max_neuron_number=`echo "${#neuron_names[@]} - 1" | bc`
fi

if [ ${run_number}=7 ]; then
   folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run7_snapshot"
   neuron_names=("cat" "dog" "female" "male" "ball" "broccoli" "geysir" "gondola" "hammer" "hare" "locomotive" "palmtree" "piano" "strawberry" "valley")
   max_neuron_number=`echo "${#neuron_names[@]} - 1" | bc`
fi

echo "iteration numbers len ${iteration_numbers_len}"
echo "Max neuron number ${max_neuron_number}"
echo "Visualize run number ${run_number}"

for n in `seq 0 ${iteration_numbers_len}`; do
   net_weights="${folder_name}/solver_iter_${iteration_numbers[n]}.caffemodel"
   echo "net weights path ${net_weights}"

   for i in `seq 0 ${max_neuron_number}`; do
      echo "Called 0_class_conditional_sampling_DL_PROJECT.sh script with input $i"
      # parameters: neuron number, neuron name, weight name, run number, iteration number
      ./0_class_conditional_sampling_DL_PROJECT.sh $i ${neuron_names[i]} ${net_weights} ${run_number} ${iteration_numbers[n]}
   done
done

done
