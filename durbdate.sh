#!/usr/bin/env bash
#cd ~/bin \
  echo "Rebuilding urbinit-base" \
  && docker build --no-cache --rm -t yebyen/urbinit:base-i686 urbinit-base \
  && docker push yebyen/urbinit
