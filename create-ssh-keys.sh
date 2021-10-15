#!/usr/bin/env bash

ssh-keygen -t ecdsa -b 521 -f ~/.ssh/packer
mv ~/.ssh/packer ~/.ssh/packer.pem
ssh-add ~/.ssh/packer.pem
cp ~/.ssh/packer.pub files/keys/