#!/usr/bin/env bash
  echo "Rebuilding i686" \
  && docker build --no-cache --rm -t yebyen/urbinit:i686 . \
  && docker tag yebyen/urbinit:i686 yebyen/urbinit \
  && docker push yebyen/urbinit
