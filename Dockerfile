FROM lambci/lambda:build-python3.7

# Compiling Tesseract for AWS Lambda
# Credits: https://stackoverflow.com/questions/33588262/tesseract-ocr-on-aws-lambda-via-virtualenv

LABEL maintainer="felipederodrigues"

ARG LEPTONICA_VERSION="1.78.0"
ARG AUTOCONF_ARCHIVE_VERSION="2019.01.06"
ARG TESSERACT_TAG_VERSION="5.0.0-alpha"
ARG LIBTESSERACT="libtesseract.so.5"
ARG LIBLEPT="liblept.so.5"
ARG LIBJPEG="libjpeg.so.62"
ARG LIBWEBP="libwebp.so.4"
ARG LIBSTDC="libstdc++.so.6"
ARG TESSDATA_LANGUAGE="eng"

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

RUN yum install -y wget clang libpng-devel libtiff-devel zlib-devel libwebp-devel libjpeg-turbo-devel git git-core libtool pkgconfig

WORKDIR /tmp

# Compile Leptonica (https://github.com/DanBloomberg/leptonica)
RUN wget https://github.com/DanBloomberg/leptonica/releases/download/$LEPTONICA_VERSION/leptonica-$LEPTONICA_VERSION.tar.gz && \
    tar -xzvf leptonica-$LEPTONICA_VERSION.tar.gz && \
    cd leptonica-$LEPTONICA_VERSION && \
    ./configure && \
    make && \
    make install

WORKDIR /tmp

# Compile Autoconf-Archive (http://gnu.mirrors.pair.com/autoconf-archive/)
RUN wget http://gnu.mirrors.pair.com/autoconf-archive/autoconf-archive-$AUTOCONF_ARCHIVE_VERSION.tar.xz && \ 
    tar -xvf autoconf-archive-$AUTOCONF_ARCHIVE_VERSION.tar.xz && \
    cd autoconf-archive-$AUTOCONF_ARCHIVE_VERSION && \
    ./configure && \
    make && \
    make install && \
    cp m4/* /usr/share/aclocal/

WORKDIR /tmp

# Compile Tesseract (https://github.com/tesseract-ocr/tesseract)
RUN git clone https://github.com/tesseract-ocr/tesseract.git tesseract-ocr && \
    cd tesseract-ocr && \
    git checkout tags/$TESSERACT_TAG_VERSION && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

WORKDIR /tmp

# Get all needed files and zip it
RUN mkdir tesseract-standalone && \
    cd tesseract-standalone && \
    cp /usr/local/bin/tesseract . && \
    mkdir lib && \
    cp /usr/local/lib/$LIBTESSERACT lib/ && \
    cp /usr/local/lib/$LIBLEPT lib/ && \
    cp /usr/lib64/$LIBJPEG lib/ && \
    cp /usr/lib64/$LIBWEBP lib/ && \
    cp /usr/lib64/$LIBSTDC lib/ && \
    mkdir tessdata && \
    cd tessdata && \
    wget https://github.com/tesseract-ocr/tessdata_fast/raw/master/$TESSDATA_LANGUAGE.traineddata && \
    mkdir configs && \
    cp /usr/local/share/tessdata/configs/pdf configs/ && \
    cp /usr/local/share/tessdata/pdf.ttf . && \
    cd .. && \
    sudo chmod 777 /tmp/tesseract-standalone -R && \
    mkdir /output && \
    zip -r /output/tesseract-standalone.zip *

WORKDIR /output

CMD [ "bash" ]