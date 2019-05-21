# Set this to the path to Caffe installation on your system
<<<<<<< HEAD
caffe_root = "/home/pussycat/caffe/python"
#caffe_root = "/home/pussycat/anaconda2/bin/caffe"
gpu = True
=======
caffe_root = "/home/sebastian/anaconda3/envs/nguyen/include/caffe"
gpu = False

# maximum number of class probability outputed.
# If classifier-network has lower number of output classes it will output all.
maxNumberClassProbabilityOutput = 20
>>>>>>> 20013c3685d54a2ca09e291aac44fff308df4c39

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
#encoder_weights = "nets/caffenet/bvlc_reference_caffenet.caffemodel"
#encoder_definition = "nets/caffenet/caffenet.prototxt"
encoder_weights = "nets/caffenet_DL_PROJECT/solver_iter_130000.caffemodel"
encoder_definition = "nets/caffenet_DL_PROJECT/caffenet_deploy.prototxt"

# Text files
synset_file = "misc/synset_words.txt"
vocab_file = "misc/vocabulary.txt"
