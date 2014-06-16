#!/usr/bin/env bash
#cd ~/bin \
  echo "Rebuilding urbinit-src" \
  && docker build --rm -t yebyen/urbinit:base-i686 urbinit-base \
  #&& docker build --rm -t yebyen/urbinit:src-i686  urbinit-src \
  #&& docker build --rm -t yebyen/urbinit:i686 . \
  && docker push yebyen/urbinit
