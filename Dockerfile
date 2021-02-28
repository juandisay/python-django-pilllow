# pull official base image
FROM python:3.8.3-alpine as builder

MAINTAINER juandisay <info@juandisay.org>

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# copy requirements
COPY ./requirements.txt .

# install dependencies
RUN apk update \
    && apk add --no-cache --virtual \
    .build-deps \
    git \
    python3-dev \
    build-base \
    libc-dev \
    gcc \
    # install Postgress
    postgresql-dev \
    # Pillow Depedencies
    jpeg-dev \
    openjpeg-dev \
    tk-dev \
    zlib-dev \
    && pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt \
    && apk del .build-deps