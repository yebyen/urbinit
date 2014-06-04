#!/usr/bin/env bash
  echo "Rebuilding urbinit-src" \
  && docker build --no-cache --rm -t yebyen/urbinit:src urbinit-src \
  && docker build --rm -t yebyen/urbinit:amd64 . \
  && docker push yebyen/urbinit
