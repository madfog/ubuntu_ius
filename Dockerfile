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


# ===== TODO:not include this build
## Intel Openvino
#ARG DLDT_TEMP_DIR=/tmp/cvsdk_install/l_openvino_toolkit_p_2018.2.319
#RUN mkdir -p $DLDT_TEMP_DIR
#ADD l_openvino_toolkit_p_2018.2.319 $DLDT_TEMP_DIR/l_openvino_toolkit_p_2018.2.319
RUN cd $DLDT_TEMP_DIR \
#&& wget -c http://nnt-srv01.inn.intel.com/builds/cvsdk/18WW17.3/l_intel_cv_sdk_p_2018.0.234.tgz \
#&& tar xf l_intel_cv_sdk_p_2018.0.234.tgz \
#&& cd l_openvino_toolkit_p_2018.2.319 \
#&& sed -i 's/decline/accept/g' silent.cfg \
#&& ./install.sh -s silent.cfg \
#&& cd ~ \
#&& rm -r /tmp/cvsdk_install/l_openvino_toolkit_p_2018.2.319 \
#&& rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/intel_models \
#&& rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/documentation \
#&& rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/model_optimizer \
#&& rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/inference_engine/lib/centos_7.3 \
#&& rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/inference_engine/lib/centos_7.4 \
#&& rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/inference_engine/tools/centos_7.3 \
#&& rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/inference_engine/tools/centos_7.4 \
#&& apt-get remove git unzip wget cpio software-properties-common -y#

## && rm -r /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/demo \
## && rm -r /opt/intel/computer_vision_sdk_2018.0.234/deployment_tools/inference_engine/samples \#

## INTEL GPU DRIVERS
#RUN cd /opt/intel/computer_vision_sdk_2018.2.319/install_dependencies \
#&& ./install_NEO_OCL_driver.sh#

## Setting ENV variables
#ARG INTEL_DLSDK_DIR=/opt/intel/computer_vision_sdk_2018.2.319
#ENV IE_PLUGINS_PATH=$INTEL_DLSDK_DIR/deployment_tools/inference_engine/lib/ubuntu_16.04/intel64#

#ENV LD_LIBRARY_PATH="$INTEL_DLSDK_DIR/deployment_tools/inference_engine/external/cldnn/lib:$INTEL_DLSDK_DIR/deployment_tools/inference_engine/external/myriad/lib:$INTEL_DLSDK_DIR/deployment_tools/inference_engine/external/hddl/lib:$INTEL_DLSDK_DIR/deployment_tools/inference_engine/external/gna/lib:$INTEL_DLSDK_DIR/deployment_tools/inference_engine/external/mkltiny_lnx/lib:$IE_PLUGINS_PATH:${LD_LIBRARY_PATH}"#

#ENV InferenceEngine_DIR="$INTEL_DLSDK_DIR/deployment_tools/inference_engine/share"
#ENV PATH="$INTEL_DLSDK_DIR/deployment_tools/model_optimizer:$PATH"
#ENV PYTHONPATH="$INTEL_DLSDK_DIR/deployment_tools/model_optimizer:$PYTHONPATH"
#ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#ENV INTEL_CVSDK_DIR=/opt/intel/computer_vision_sdk_2018.2.319
#ENV LD_LIBRARY_PATH=/opt/intel/computer_vision_sdk_2018.2.319/openvx/lib:$LD_LIBRARY_PATH
#ENV LD_LIBRARY_PATH=/opt/intel/computer_vision_sdk_2018.2.319/mo/model_optimizer_caffe/bin:$LD_LIBRARY_PATH
#ENV OpenCV_DIR=/opt/intel/computer_vision_sdk_2018.2.319/opencv/share/OpenCV
#ENV LD_LIBRARY_PATH=/opt/intel/computer_vision_sdk_2018.2.319/opencv/lib:$LD_LIBRARY_PATH
#ENV LD_LIBRARY_PATH=opt/intel/computer_vision_sdk_2018.2.319/opencv/share/OpenCV/3rdparty/lib:$LD_LIBRARY_PATH
#ENV CGO_CPPFLAGS="-I${INTEL_CVSDK_DIR}/opencv/include"
#ENV CGO_LDFLAGS="-L${INTEL_CVSDK_DIR}/opencv/lib -lopencv_core -lopencv_pvl -lopencv_face -lopencv_videoio -lopencv_imgproc -lopencv_highgui -lopencv_imgcodecs -lopencv_objdetect -lopencv_features2d -lopencv_video -lopencv_dnn -lopencv_xfeatures2d"#

## Build Sample Code
#RUN cd /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/inference_engine/samples \
#&& mkdir build \
#&& cd build \
#&& cmake .. \
#&& make#

## COPY IR MODELS
#RUN mkdir /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/demo/ir
## squeezenet1.1
#COPY ./resouce/car.png /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/demo/car.png
#COPY ./resouce/squeezenet1.1 /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/demo/ir/squeezenet1.1
## ssd300
## COPY ssd300 /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/demo/ir/ssd300
## mobilenet-ssd
#COPY ./resouce/mobilenet-ssd /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/demo/ir/mobilenet-ssd
#COPY ./resouce/000001.jpg /opt/intel/computer_vision_sdk_2018.2.319/deployment_tools/demo/000001.jpg
# ===== TODO:end



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


