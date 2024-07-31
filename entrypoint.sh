#!/bin/bash
cd /stylegan/imgur5k-dataset
python3.7 download_imgur5k.py
python3.7 prepare_dataset.py
cd /stylegan/deep-text-edit
python3.7 run.py ./src/config/stylegan_adversarial.py
