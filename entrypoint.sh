#!/bin/bash

# Run Jupyterlab
cd /home/jupyter/notebook
sudo runuser -l jupyter -c "/opt/conda/bin/jupyter lab --port=9999 --ip=0.0.0.0 --no-browser"
