#!/usr/bin/env bash
#cd ~/bin \
  echo "Rebuilding i686" \
  && docker build --no-cache --rm -t yebyen/urbinit:i686      ./           \
  && docker push yebyen/urbinit
