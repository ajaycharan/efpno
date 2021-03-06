#!/bin/bash
set -e
set -x
logs="intel manhattanOlson3500 w10000-odom"
data='../data'
out="out/test_reduce/"
mkdir -p $out

# logs="manhattanOlson3500 intel w10000-odom"
# logs="intel"
logs="manhattanOlson3500 w10000-odom intel"

dists="15"
nodes="150 200 250"


for log in $logs; do
	source=$data/$log.g2o
	efpno_plot --stats --outdir $out/reports $source
	
	for min_nodes in $nodes; do
	for dist in $dists; do
		mkdir -p $out/simplified/
		simplified=$out/simplified/$log-D$dist-N${min_nodes}.g2o
		efpno_simplify  \
			--max_dist=$dist \
			--min_nodes=$min_nodes \
			$source > $simplified
		efpno_plot  --stats  --outdir $out/reports $simplified
	done
	done
done

