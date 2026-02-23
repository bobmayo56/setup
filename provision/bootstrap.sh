#!/bin/bash

if ! [ -x "$(command -v git)" ]; then
  if [ -x "$(command -v yum)" ]; then
    echo Yum exists.
    sudo yum install git
  else
    echo Yum does not exist.
  fi
else
  echo Git exists.
fi

if [ -f ~/setup ]; then
  echo Setup exists.
  (cd ~/setup; git pull origin master)
else
  echo Setup does not exist.
  (cd ~; git clone https://github.com/bobmayo56/setup.git)
  git config --global user.email "bob-git@bobmayo.com"
  git config --global user.name "Bob Mayo"
fi
