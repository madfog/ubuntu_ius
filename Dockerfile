FROM ubuntu:16.04


WORKDIR /usr/local

ENV GOPATH=/data/golang
ENV GOBIN=/data/golang/bin

RUN apt-get update 
RUN apt-get install -y \
    build-essential \
    cmake \
    git \
    cpio \
    wget \
    unzip \
    yasm \
    pkg-config \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libavformat-dev \
    libpq-dev \
	ffmpeg \
    libgtk2.0-0 \
    software-properties-common

RUN add-apt-repository ppa:ubuntu-toolchain-r/test

RUN apt-get update && \
    apt-get install -y \    
    libstdc++6

RUN apt-get upgrade libstdc++6 -y

# OpenCL Driver
# RUN wget http://registrationcenter-download.intel.com/akdlm/irc_nas/11396/SRB5.0_linux64.zip \
# && unzip SRB5.0_linux64.zip -d SRB5.0_linux64 \
# && cd SRB5.0_linux64 && mkdir intel-opencl \
# && tar -C intel-opencl -Jxf intel-opencl-r5.0-63503.x86_64.tar.xz \
# && tar -C intel-opencl -Jxf intel-opencl-devel-r5.0-63503.x86_64.tar.xz \
# && tar -C intel-opencl -Jxf intel-opencl-cpu-r5.0-63503.x86_64.tar.xz \
# && cp -R intel-opencl/* / \
# && ldconfig \
# && rm /SRB5.0_linux64.zip \
# && rm -r /SRB5.0_linux64



# 安装 libevent 库
RUN wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz \
    && tar -xzvf libevent-2.1.8-stable.tar.gz \
    && cd libevent-2.1.8-stable && ./configure --prefix=/usr && make && make install

# 安装glog 库
RUN apt-get install -y autoconf automake libtool && apt-get install -y libffi-dev
RUN git clone https://github.com/google/glog.git \
    && cd glog && ./autogen.sh && ./configure && make && make install

# 安装 pthread (已存在)

# 安装 golang 1.11

RUN wget https://searchtest-1255980596.cos.ap-beijing.myqcloud.com/go1.11.linux-amd64.tar.gz \
    && tar zxvf go1.11.linux-amd64.tar.gz \
    && mv go go1.11 \
    && rm go1.11.linux-amd64.tar.gz \
    && ln -s /usr/local/go1.11/bin/go /usr/local/bin/go \
    && ln -s /usr/local/go1.11/bin/gofmt /usr/local/bin/gofmt \
    && ln -s /usr/local/go1.11/bin/godoc /usr/local/bin/godoc 

COPY nlohmann.tar.gz /usr/local/include
# 安装 json
RUN cd /usr/local/include && tar -xzvf nlohmann.tar.gz


