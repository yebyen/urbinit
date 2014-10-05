#!/usr/bin/env bash
  echo "Rebuilding amd64" \
  && docker build --no-cache --rm -t yebyen/urbinit:amd64 . \
  && docker tag yebyen/urbinit:amd64 yebyen/urbinit \
  && docker push yebyen/urbinit:amd64 # \
  # && docker push yebyen/urbinit:latest
