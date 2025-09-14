## Basic image with scikit-learn and pandas
FROM python:3.12.6-slim

## Install python3 and pip
# RUN apt-get update && \
#     apt-get install -y \
#             python3 \
#             python3-pip

## Install sklearn and panda
RUN python -m pip install scikit-learn pandas

## Create a directory for the lab
RUN mkdir /lab
WORKDIR /lab

## Copy the training files
COPY ./train.py /lab/train.py