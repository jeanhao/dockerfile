FROM registry.cn-shanghai.aliyuncs.com/russellcloud/python-base:latest
MAINTAINER Russell labs "contact@russellcloud.cn"

# SpaCy
RUN pip install -U spacy
RUN python -m spacy.en.download

# Textacy
RUN pip install textacy

# Pattern
# RUN pip install -U pattern