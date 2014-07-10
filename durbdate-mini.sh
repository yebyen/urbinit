#!/usr/bin/env bash
  echo "Rebuilding amd64" \
<<<<<<< HEAD
  && docker build --no-cache --rm -t yebyen/urbinit:amd64 . \
  && docker tag yebyen/urbinit:amd64 yebyen/urbinit \
=======
  && docker build --no-cache --rm -t yebyen/urbinit:amd64     ./           \
>>>>>>> catch up amd64 branch to sipsup-dopdep (i686)
  && docker push yebyen/urbinit
