#!/usr/bin/env bash
# Unroll Layers: doit.sh

# docker ps -a|egrep -v 'CONTAINER ID|Up'|awk '{print $1}'|xargs docker rm

#http://pastebin.com/t0AKDjbz
# When you reach 40 layers, your urbit-docker ship won't launch into a new
# container anymore.  If you carelessly discarded the container (as I am wont
# to do often using the above one-liner), you won't be able to save it with:
# docker export > ship.tar; cat ship.tar|docker import $ship

# The docker save is semantically a little different than docker export; it
# keeps all of the layers.  That means save and load don't exactly help us now.

# unroll-layers doit.sh (this script) USAGE:
####(satnum-maptux is my ship)####
# ~ $ docker save satnum-maptux > satnum.tar
# ~ $ mkdir satnum; tar xvf satnum.tar -C satnum; cd satnum
# ~/satnum $ mkdir maptux; ./doit.sh |while read line; do sudo tar xpvf $line/layer.tar --numeric-owner -C maptux; done
# ~/satnum $ cd maptux; sudo tar cvpf ../maptux.tar --numeric-owner ./
# ~/satnum/maptux $ cat ../maptux.tar|docker import - satnum-maptux-2
####

# The recursive function below unrolls repositories layer by layer and prints
# them out in order from oldest to newest (top) layer.  After, your new image
# "satnum-maptux-2" has only one layer and can replace your old "satnum-maptux"

TOP=$(sudo cat repositories |awk -F\" '{print $6}')

neat()
{
  if [ -d "$1" ]
  then
    local NEXT=$(sudo cat $1/json|awk -F\" '{print $8}')
    neat "$NEXT"
    if [ -d "$NEXT" ]; then
      echo $NEXT
    fi
  fi
}

neat $TOP
echo $TOP
