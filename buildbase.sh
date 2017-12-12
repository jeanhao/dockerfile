#!/bin/bash

VERSION=v1

set -e

# buildpack-deps
docker build -t registry.cn-shanghai.aliyuncs.com/russellcloud/buildpack-deps:${VERSION} -f ./base/buildpack-deps/Dockerfile .
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/buildpack-deps:${VERSION}

docker build -t registry.cn-shanghai.aliyuncs.com/russellcloud/buildpack-deps:${VERSION}-gpu -f ./base/buildpack-deps/Dockerfile.gpu .
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/buildpack-deps:${VERSION}-gpu

# python-base
sed -i "1s/:latest/:${VERSION}/g" ./base/python-base/2.7/Dockerfile
docker build -t registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-py2 -f ./base/python-base/2.7/Dockerfile .
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-py2
sed -i "1s/:${VERSION}/:latest/g" ./base/python-base/2.7/Dockerfile

sed -i "1s/:latest/:${VERSION}/g" ./base/python-base/3.5/Dockerfile
docker build -t registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-py3 -f ./base/python-base/3.5/Dockerfile .
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-py3
sed -i "1s/:${VERSION}/:latest/g" ./base/python-base/3.5/Dockerfile

sed -i "1s/:latest/:${VERSION}/g" ./base/python-base/2.7/Dockerfile.gpu
docker build -t registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-gpu-py2 -f ./base/python-base/2.7/Dockerfile.gpu .
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-gpu-py2
sed -i "1s/:${VERSION}/:latest/g" ./base/python-base/2.7/Dockerfile.gpu

sed -i "1s/:latest/:${VERSION}/g" ./base/python-base/3.5/Dockerfile.gpu
docker build -t registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-gpu-py3 -f ./base/python-base/3.5/Dockerfile.gpu .
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:${VERSION}-gpu-py3
sed -i "1s/:${VERSION}/:latest/g" ./base/python-base/3.5/Dockerfile.gpu

# dl-deps
floydker build ./base/dl-deps/${VERSION}/Dockerfile-py2
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-deps:${VERSION}-py2

floydker build ./base/dl-deps/${VERSION}/Dockerfile-py3
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-deps:${VERSION}-py3

floydker build ./base/dl-deps/${VERSION}/Dockerfile-py2.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-deps:${VERSION}-gpu-py2

floydker build ./base/dl-deps/${VERSION}/Dockerfile-py3.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-deps:${VERSION}-gpu-py3

# dl-python
floydker build ./dl/dl-python/${VERSION}/Dockerfile-py2
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-python:${VERSION}-py2

floydker build ./dl/dl-python/${VERSION}/Dockerfile-py3
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-python:${VERSION}-py3

floydker build ./dl/dl-python/${VERSION}/Dockerfile-py2.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-python:${VERSION}-gpu-py2

floydker build ./dl/dl-python/${VERSION}/Dockerfile-py3.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-python:${VERSION}-gpu-py3

# dl-opencv
floydker build ./dl/dl-opencv/3.2.0/Dockerfile-py2
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-opencv:3.2.0-py2

floydker build ./dl/dl-opencv/3.2.0/Dockerfile-py3
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-opencv:3.2.0-py3

floydker build ./dl/dl-opencv/3.2.0/Dockerfile-py2.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-opencv:3.2.0-gpu-py2

floydker build ./dl/dl-opencv/3.2.0/Dockerfile-py3.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-opencv:3.2.0-gpu-py3

# dl-base
floydker build ./dl/dl-base/${VERSION}/Dockerfile-py2
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-base:${VERSION}-py2

floydker build ./dl/dl-base/${VERSION}/Dockerfile-py3
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-base:${VERSION}-py3

floydker build ./dl/dl-base/${VERSION}/Dockerfile-py2.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-base:${VERSION}-gpu-py2

floydker build ./dl/dl-base/${VERSION}/Dockerfile-py3.gpu
docker push registry.cn-shanghai.aliyuncs.com/russellcloud/dl-base:${VERSION}-gpu-py3
