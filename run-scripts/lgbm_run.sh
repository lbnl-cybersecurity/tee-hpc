#!/usr/bin/env bash

time (docker run --rm -it --device=/dev/isgx lgbm-scone sh -c "SCONE_HEAP=2G LightGBM/lightgbm config=lightgbm_msltr.conf data=../data/msltr.train objective=lambdarank") > lightgbm_msltr_speed-th1 2>&1
