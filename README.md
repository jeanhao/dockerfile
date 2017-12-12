# Dockerfiles

Collection of Dockerfiles useful for NLP and Deep Learning. To download the docker images
visit: [RussellCloud's Docker Hub](registry.cn-shanghai.aliyuncs.com).


## Naming conventions

Dockerfiles are organized into the following directory structure:

```
CATEGORY/PROJECT_NAME/VERSION/Dockerfile-ENV
CATEGORY/PROJECT_NAME/VERSION/Dockerfile-ENV.gpu
```

Automated build scripts will generate the following tags for images based on
the above dockerfile paths:

```
registry.cn-shanghai.aliyuncs.com/russellcloud/PROJECT_NAME:VERSION-ENV
registry.cn-shanghai.aliyuncs.com/russellcloud/PROJECT_NAME:VERSION-ENV-gpu
```

Contains docker images for popular deep learning frameworks including: Tensorflow, PyTorch and Torch.
