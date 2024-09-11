## Basic Ubuntu image with scikit-learn and pandas
FROM ubuntu:24.04

## Install sklearn and panda
RUN pip install scikit-learn pandas

## Create a directory for the lab
RUN mkdir /lab
WORKDIR /lab

## Copy the training files
COPY ./train.py /lab/train.py