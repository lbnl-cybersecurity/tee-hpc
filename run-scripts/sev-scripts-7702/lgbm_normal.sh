time (LightGBM/lightgbm config=lightgbm.conf data=../data/msltr.train objective=lambdarank 2>&1 | tee lightgbm_msltr_speed.log) > lgbm_native_normal 2>&1
