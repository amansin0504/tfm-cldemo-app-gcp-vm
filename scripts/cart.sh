#!/bin/bash
sudo apt update
sudo apt install python3-pip -y
sudo apt install wget
sudo pip install Flask

git clone https://github.com/amansin0504/tfm-cldemo-app-gcp-vm.git
mkdir app/
mkdir app/templates
cp tfm-cldemo-app-gcp-vm/source/carts.py app/app.py
cp tfm-cldemo-app-gcp-vm/source/templates/carts.json app/templates/
cd app
flask run  --host=0.0.0.0 -p 8997&
