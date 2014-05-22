#!/usr/bin/env bash
cd ~/bin \
  && docker build --no-cache --rm -t yebyen/urbinit:i686      ./           \
  && docker push yebyen/urbinit
