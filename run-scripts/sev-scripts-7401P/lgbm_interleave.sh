time (numactl --interleave=0,1,2,3 LightGBM/lightgbm config=lightgbm.conf data=../data/msltr.train objective=lambdarank 2>&1 | tee lightgbm_msltr_speed.log) > lgbm_native_interleave 2>&1
