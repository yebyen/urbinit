#!/usr/bin/env bash
#cd ~/bin \
  echo "Rebuilding urbinit-src" \
  && docker build --no-cache --rm -t yebyen/urbinit:base-i686 urbinit-base \
  && docker push yebyen/urbinit
  #&& docker build --rm -t yebyen/urbinit:src-i686  urbinit-src \
  #&& docker build --rm -t yebyen/urbinit:i686 . \
