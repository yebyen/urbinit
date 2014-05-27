#!/usr/bin/env bash
#cd ~/bin \
  echo "Rebuilding urbinit-base" \
  && docker build --rm -t yebyen/urbinit:base-i686 urbinit-base \
  && docker push yebyen/urbinit
