#!/bin/bash
#
# Copy the sample config and change to use our dataset: the paths to our data
# and the number of classes we have
#
. config.py
maxExamples=2000

# Amount is for the learning curve
for Amount in 100 90 80 70 60 50 40 30 20 10; do
    suffix=".${Amount}"
    for TFArch; do
        base="models/research/object_detection/samples/configs/${TFArch}_pets.config"

        if [[ -e $base ]]; then
            echo "Creating config for $TFArch for ${Amount}% of the training data"
        else
            echo "Warning: $base doesn't exist, skipping"
            continue
        fi

        cp "$base" "$datasetFolder/tf_${TFArch}_${Amount}.config"

        # Count labels
        classes="$(grep "item" "$datasetFolder/$datasetTFlabels" | wc -l)"

        # The ../../ is because we'll be running the training script from with
        # models/research/
        #
        # Note: training set is specific for learning curve amount but the same
        # validation set is used for them all.
        sed -ri "
        s#num_classes: [0-9]+#num_classes: $classes#g
        s#num_examples: [0-9]+#num_examples: $maxExamples#g
        s#PATH_TO_BE_CONFIGURED/model.ckpt#PATH_TO_BE_CONFIGURED/${TFArch}_model_$Amount.ckpt#g
        s#PATH_TO_BE_CONFIGURED/pet_label_map.pbtxt#../../$datasetFolder/$datasetTFlabels#g
        s#PATH_TO_BE_CONFIGURED/pet_train.record#../../$datasetFolder/$datasetTFtrain$suffix#g
        s#PATH_TO_BE_CONFIGURED/pet_val.record#../../$datasetFolder/$datasetTFvalid#g
        s#PATH_TO_BE_CONFIGURED/mscoco_label_map.pbtxt#../../$datasetFolder/$datasetTFlabels#g
        s#PATH_TO_BE_CONFIGURED/mscoco_train.record#../../$datasetFolder/$datasetTFtrain$suffix#g
        s#PATH_TO_BE_CONFIGURED/mscoco_val.record#../../$datasetFolder/$datasetTFvalid#g
        s#PATH_TO_BE_CONFIGURED#../../$datasetFolder#g
        " "$datasetFolder/tf_${TFArch}_${Amount}.config"

        # if maxTFEvals = 0, then don't set a limit
        if [[ $maxTFEvals == 0 ]]; then
            sed -ri "s#max_evals: [0-9]+##g" "$datasetFolder/tf_${TFArch}_${Amount}.config"
        else
            sed -ri "s#max_evals: [0-9]+#max_evals: $maxTFEvals#g" "$datasetFolder/tf_${TFArch}_${Amount}.config"
        fi
    done
done
