#
# config file
# 
# This is for both Python and Bash, so... make sure syntax works in both, i.e.
# no spaces before or after equal signs and no variables. Probably a better way
# to do this.
#
dataset="SmartHome"
datasetFolder="datasets/SmartHome"

# Files for TensorFlow
datasetTFtrain="datasets/SmartHome/tftrain.record"
datasetTFtest="datasets/SmartHome/tftest.record"
datasetTFvalid="datasets/SmartHome/tfvalid.record"

# Files for YOLO
datasetLabels="datasets/SmartHome/labels.names"
datasetConfig="datasets/SmartHome/config.cfg"
datasetCompressed="datasets/SmartHome/files.tar.gz"

dataPrefix="dataset"
trainingPrefix="training"
validateFile="validate.txt"
testingFile="testing.txt"
backupPrefix="backup" # remotedir/datasetFolder/backupPrefix_...
weightsName="darknet19_448.conv.23"
weightsDir="/data/vcea/matt.taylor/Projects/ras-object-detection/"

# Connecting to the remote server
remotedir="/data/vcea/matt.taylor/Projects/ras-object-detection/"
remotessh="kamiak"
localdir="/home/garrett/Documents/School/17_Fall/CASAS/RAS/ras-object-detection/"
