#!/usr/bin/env bash
  echo "Rebuilding urbinit-base and urbinit-src first" \
  && docker build --rm --no-cache -t yebyen/urbinit:base-i686 urbinit-base \
  && docker build --rm -t yebyen/urbinit:src-i686  urbinit-src \
  && docker run -i -t --name src-i686 yebyen/urbinit:src-i686 true  \
  && docker export src-i686|docker import - urbinit-src-i686  \
  && docker tag urbinit-src-i686 yebyen/urbinit:src-i686 \
  && docker rm src-i686 && docker push yebyen/urbinit:src-i686
