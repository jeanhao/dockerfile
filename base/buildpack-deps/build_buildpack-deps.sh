#!/bin/bash

DOCKER_BASE=registry.cn-shanghai.aliyuncs.com/russell-hub/buildpack-deps

if [ ! -n "$1" ] ;then
    path="./"
else
    path="$1"
fi
if [ ! -n "$2" ] ;then
    preffix="buildpack-deps."
else
    preffix="$2"
fi

basename=$path$preffix
for file in $(ls $basename*)
do
  version=${file/$basename/}
  tag="$DOCKER_BASE:$version"
  docker build -t $tag -f ./$file .
  docker push $tag
done