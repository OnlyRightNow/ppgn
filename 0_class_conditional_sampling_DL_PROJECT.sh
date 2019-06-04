#/bin/bash
#
# Anh Nguyen <anh.ng8@gmail.com>
# 2016

# Take in a unit number
if [ "$#" -ne "1" ]; then
  echo "Provide 1 output unit number e.g. 945 for bell pepper."
  exit 1
fi

opt_layer=fc6
act_layer=fc8_DL_PROJECT
units="${1}"      # Index of neurons in fc layers or channels in conv layers
xy=0              # Spatial position for conv layers, for fc layers: xy = 0

n_iters=1000       # Run for N iterations. HAS TO BE A MULTIPLE OF reset_every !!
reset_every=200    # Reset the code every N iterations (for diversity) HAS TO BE A MULTIPLE OF save_every !!
save_every=20      # Save a sample every N iterations
lr=1
lr_end=1          # Linearly decay toward this ending lr (e.g. for decaying toward 0, set lr_end = 1e-10)
threshold=0       # Filter out samples below this threshold e.g. 0.98

# -----------------------------------------------
# Multipliers in the update rule Eq.11 in the paper
# -----------------------------------------------
epsilon1=1e-5       # prior
epsilon2=1        # condition
epsilon3=1e-17    # noise
# -----------------------------------------------

init_file="None"    # Start from a random code. To start from a real code, replace with a path e.g. "images/filename.jpg"

# Condition net
net_weights="/home/pussycat/finetune_caffe_model/models/caffenet/run5_snapshot/solver_iter_95000.caffemodel"
net_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"
#-----------------------

# Output dir
output_dir="output/test_images_nicely_arranged"  #"${act_layer}_chain_${units}_eps1_${epsilon1}_eps3_${epsilon3}"
mkdir -p ${output_dir}

# Directory to store samples
if [ "${save_every}" -gt "0" ]; then
    sample_dir=${output_dir}/samples
    rm -rf ${sample_dir} 
    mkdir -p ${sample_dir} 
fi

for unit in ${units}; do
    unit_pad=`printf "%04d" ${unit}`

    for seed in {0..0}; do

        python ./sampling_class.py \
            --act_layer ${act_layer} \
            --opt_layer ${opt_layer} \
            --unit ${unit} \
            --xy ${xy} \
            --n_iters ${n_iters} \
            --save_every ${save_every} \
            --reset_every ${reset_every} \
            --lr ${lr} \
            --lr_end ${lr_end} \
            --seed ${seed} \
            --output_dir ${output_dir} \
            --init_file ${init_file} \
            --epsilon1 ${epsilon1} \
            --epsilon2 ${epsilon2} \
            --epsilon3 ${epsilon3} \
            --threshold ${threshold} \
            --net_weights ${net_weights} \
            --net_definition ${net_definition} \

        # Plot the samples
        if [ "${save_every}" -gt "0" ]; then
	    num_cols=`echo "${reset_every} / ${save_every} + 1" | bc`
            num_images=`echo "${n_iters} / ${save_every} + ${num_cols}"| bc`
            echo "Creating montage of images with a total of ${num_cols} columns"

            f_chain=${output_dir}/chain_unit_${units}_lr_${lr}_lr_end_${lr_end}_seed_${seed}.jpg        # ${output_dir}/chain_${units}_hx_${epsilon1}_noise_${epsilon3}__${seed}.jpg

            # Make a montage of steps
            montage `ls ${sample_dir}/*.jpg | head -${num_images}` -tile ${num_cols}x -geometry +1+1 ${f_chain}

            readlink -f ${f_chain}
        fi
    done
done