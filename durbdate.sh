#!/usr/bin/env bash
cd ~/urbit \
  && sudo docker.io build --no-cache --rm -t yebyen/urbinit:base-i686 urbinit/urbinit-base \
  && sudo docker.io build --no-cache --rm -t yebyen/urbinit:src-i686 urbinit/urbinit-src   \
  && sudo docker.io build --no-cache --rm -t yebyen/urbinit:i686 urbinit/                  \
  && sudo docker.io push yebyen/urbinit
