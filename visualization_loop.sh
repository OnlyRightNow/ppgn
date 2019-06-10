#!/usr/bin/env bash

# define the numbers of the runs in an array
run_numbers=(1 2)

# iteration_numbers_basic=(100000)

# loop over all runs and visualize features with certain weight files
for run_number in "${run_numbers[@]}"; do
    echo "run number iter ${run_number}"


    if [ "${run_number}" -eq "1" ]; then
       # iteration_numbers=(10000 50000 130000)
       iteration_numbers=(10000 130000)
       iteration_numbers_len=`echo "${#iteration_numbers[@]} - 1" | bc`
    else
       # iteration_numbers=(10000 50000 100000)
       iteration_numbers=(5000 15000)
       iteration_numbers_len=`echo "${#iteration_numbers[@]} - 1" | bc`
    fi

    # Define the names of the neurons and of the folder containing the weight files
    if [ "${run_number}" -eq "1" ]; then
       echo "start visualizing run 1"
       folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run1_cat_baseball_car_airplane_face"
       net_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"
       neuron_names=("cat" "baseball" "car" "airplane" "face")

    elif [ "${run_number}" -eq "2" ]; then
       echo "start visualizing run 2"
       folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run2b_dog_cat_female_male_ball"
       net_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"
       neuron_names=("dog" "cat" "female" "male" "ball")

    elif [ "${run_number}" -eq "3" ]; then
       echo "start visualizing run 3"
       folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run3_animal_gender_tennisball_soccerball_basketball"
       net_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"
       neuron_names=("animal" "gender" "tennisball" "soccerball" "basketball")

    elif [ "${run_number}" -eq "5" ]; then
       echo "start visualizing run 5"
       folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run5_golfnKeyboard_billiardball_tennisball_soccerball_basketball"
       net_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"
       neuron_names=("golfnKeyboard" "billardball" "tennisball" "soccerball" "basketball")

    elif [ "${run_number}" -eq "6" ]; then
       echo "start visualizing run 6"
       folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run6_dog_cat_female_male_ball_100"
       net_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"
       neuron_names=("dog" "cat" "female" "male" "ball")

    elif [ "${run_number}" -eq "7" ]; then
       echo "start visualizing run 7"
       folder_name="/home/pussycat/finetune_caffe_model/models/caffenet/run7_snapshot"
       net_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy_15_outputs.prototxt"
       neuron_names=("cat" "dog" "female" "male" "ball" "broccoli" "geysir" "gondola" "hammer" "hare" "locomotive" "palmtree" "piano" "strawberry" "valley")
    fi

    # Count the number of neurons for which we have to visualize features
    max_neuron_number=`echo "${#neuron_names[@]} - 1" | bc`

    for n in `seq 0 ${iteration_numbers_len}`; do
       net_weights="${folder_name}/solver_iter_${iteration_numbers[n]}.caffemodel"
       echo "net weights path ${net_weights}"
       echo "net definition ${net_definition}"
       echo "iteration numbers len ${iteration_numbers_len}"
       echo "Max neuron number ${max_neuron_number}"
       echo "Visualize run number ${run_number}"
       echo "Iteration number ${iteration_numbers[n]}"

       for i in `seq 0 ${max_neuron_number}`; do
          echo "Called 0_class_conditional_sampling_DL_PROJECT.sh script with input $i"
          # parameters: neuron number, neuron name, weight name, run number, iteration number
          ./0_class_conditional_sampling_DL_PROJECT.sh $i ${neuron_names[i]} ${net_weights} ${run_number} ${iteration_numbers[n]} ${net_definition}
       done
    done
done
