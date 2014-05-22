#!/usr/bin/env bash
  echo "Rebuilding urbinit-base and urbinit-src first" \
  && docker build --rm -t yebyen/urbinit:base urbinit-base \
  && docker build --rm -t yebyen/urbinit:src  urbinit-src \
  && docker build --rm -t yebyen/urbinit:amd64 . \
  && docker tag yebyen/urbinit:amd64 yebyen/urbinit \
  && docker push yebyen/urbinit
