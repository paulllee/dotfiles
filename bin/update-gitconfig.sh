#!/bin/bash

read -p "Enter Git Name: " GIT_NAME
read -p "Enter Git Email: " GIT_EMAIL

git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global user.signingkey ~/.ssh/id_rsa.pub
git config --global gpg.format ssh
