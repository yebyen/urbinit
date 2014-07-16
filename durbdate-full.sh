#!/usr/bin/env bash
#cd ~/bin \
  echo "Rebuilding urbinit-base and urbinit-src first" \
  && docker build --rm --no-cache -t yebyen/urbinit:base-i686 urbinit-base \
  && docker build --rm -t yebyen/urbinit:src-i686  urbinit-src \
  && docker build --rm -t yebyen/urbinit:i686 . \
  && docker tag yebyen/urbinit:i686 yebyen/urbinit \
  && docker push yebyen/urbinit
