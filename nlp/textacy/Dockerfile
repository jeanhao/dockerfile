FROM registry.cn-shanghai.aliyuncs.com/russellcloud/spacy:latest
MAINTAINER Russell labs "contact@russellcloud.cn"

# Install dependencies
RUN pip --no-cache-dir install \
        backports.csv \
        cachetools \
        cld2-cffi \
        cytoolz \
        ftfy \
        fuzzywuzzy \
        ijson \
        matplotlib \
        networkx \
        numpy \
        pyemd \
        pyphen \
        python-levenshtein \
        requests \
        scipy \
        scikit-learn \
        spacy \
        unidecode

RUN pip install textacy
