#!/bin/bash
# Note both have trailing slashes
from="kamiak:/data/vcea/matt.taylor/Projects/ras-object-detection/"
to="/home/garrett/Documents/School/17_Fall/CASAS/RAS/ras-object-detection/"

rsync -Pahuv --exclude="old" --exclude="old_v2" --include="*/" \
    --include="*_final.weights" --include="*.backup" --include="*.out*" \
    --include="*.err*" --exclude="*" "$from" "$to"

rsync -Pahuv "$from/results/" "$to/results/"
rsync -Pahuv "$from/results_iterations/" "$to/results_iterations/"