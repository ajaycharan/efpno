#!/bin/bash
set -e
set -x
logs="intel manhattanOlson3500 w10000-odom"
data='../data'
out="out/test_stats/"
mkdir -p $out

logs="w10000-odom manhattanOlson3500 intel "
# logs="intel"
# logs="manhattanOlson3500"
# logs="w10000-odom"
# logs="intel"
# dists="5"

# logs="manhattanOlson3500"
dists="20"
scale="10000"
# num=200

# logs="w10000-odom"
# dists="15"


# dists="10 20"
# dists="15"

# logs="w10000-odom"
# logs="grid100x100x10"
fast="--fast"
for log in $logs; do
	source=$data/$log.g2o
	efpno_plot $fast --stats --outdir $out/reports $source
	
	for dist in $dists; do
		mkdir -p $out/solved/
		solved=$out/solved/$log-solved$dist-T$scale.g2o
		efpno_solve $fast --seed 0 --scale $scale --max_dist=$dist $source > $solved
		efpno_plot $fast --stats --outdir $out/reports $solved
	done
done
