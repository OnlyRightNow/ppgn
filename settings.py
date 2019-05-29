# Set this to the path to Caffe installation on your system
caffe_root = "/home/pussycat/caffe"
gpu = True

# maximum number of class probability outputed.
# If classifier-network has lower number of output classes it will output all.
maxNumberClassProbabilityOutput = 20

# -------------------------------------
# The following are hard-coded and hardly change unless we change to use a different generator.
# -------------------------------------
# Generator G 
generator_weights = "nets/generator/noiseless/generator.caffemodel"
generator_definition = "nets/generator/noiseless/generator.prototxt"

# input / output layers in the generator prototxt
generator_in_layer = "feat"
generator_out_layer = "deconv0"

# Encoder E
encoder_weights="/home/pussycat/finetune_caffe_model/models/caffenet/run2b_dog_cat_female_male_ball/solver_iter_100000.caffemodel"
encoder_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"
# encoder_weights="/home/pussycat/finetune_caffe_model/models/weights/bvlc_reference_caffenet.caffemodel"
# encoder_definition="/home/pussycat/finetune_caffe_model/models/caffenet/caffenet_deploy.prototxt"


# Text files
synset_file = "misc/synset_words.txt"
vocab_file = "misc/vocabulary.txt"
