#!/usr/bin/env bash
  echo "Rebuilding urbinit-base and urbinit-src first" \
  && docker build --rm --no-cache -t yebyen/urbinit:base-amd64 urbinit-base \
  && docker build --rm -t yebyen/urbinit:src-amd64  urbinit-src \
  && docker run -i -t --name src-amd64 yebyen/urbinit:src-amd64 true  \
  && docker export src-amd64|docker import - urbinit-src-amd64  \
  && docker tag urbinit-src-amd64 yebyen/urbinit:src-amd64 \
  && docker rmi urbinit-src-amd64 \
  && docker rm src-amd64 && docker push yebyen/urbinit:src-amd64
