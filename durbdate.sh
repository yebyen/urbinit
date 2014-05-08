#!/usr/bin/env bash
cd ~/urbit \
  && sudo docker.io build --no-cache --rm -t yebyen/urbinit:base urbinit/urbinit-base \
  && sudo docker.io build --no-cache --rm -t yebyen/urbinit:src urbinit/urbinit-src   \
  && sudo docker.io build --no-cache --rm -t yebyen/urbinit urbinit/                  \
  && sudo docker.io push yebyen/urbinit
