FROM ubuntu:20.04

RUN apt-get -y update && apt-get -y install git

RUN apt-get -y update && apt-get -y install g++-7
RUN apt-get -y update && apt-get -y install gcc-7


RUN apt-get -y update && apt-get -y install vim

RUN apt-get -y update && apt-get -y install make

RUN rm /usr/bin/gcc ;rm /usr/bin/g++ ; ln -s /usr/bin/gcc-7 /usr/bin/gcc && ln -s /usr/bin/g++-7 /usr/bin/g++

COPY cmake-3.25.2-linux-x86_64.tar.gz /root

RUN cd /root && tar -zxvf cmake-3.25.2-linux-x86_64.tar.gz && ln -s /root/cmake-3.25.2-linux-x86_64/bin/cmake /usr/bin/cmake

RUN apt-get -y update && apt-get -y install make

COPY hello.cpp /

RUN apt-get -y update && apt-get -y install build-essential

RUN apt-get -y update && apt-get -y install libnuma-dev
RUN apt-get -y update && apt-get -y install libssl-dev


# python packages

RUN apt-get -y update && apt-get install zlib1g-dev
RUN apt-get -y update && apt-get install libsqlite3-dev
RUN apt-get -y update && apt-get install libncurses-dev

COPY Python-3.6.8.tgz /root

RUN cd /root && tar -xzf Python-3.6.8.tgz && cd Python-3.6.8 && ./configure --enable-optimizations && make altinstall && ln -s /usr/local/bin/python3.6 /usr/local/bin/python3 && ln -s /usr/local/bin/pip3.6 /usr/local/bin/pip3


RUN pip3 install pick==1.0.0
RUN pip3 install conan==1.39.0

#RUN apt-get -y update && apt-get install python3.6 -y
#RUN apt-get -y update && apt-get install python3-pip -y
#RUN pip3 install conan
#RUN pip3 install pick

RUN rm -rf /usr/bin/gcc
RUN rm -rf /usr/bin/g++
RUN ln -s /usr/bin/gcc-7 /usr/bin/gcc && ln -s /usr/bin/g++-7 /usr/bin/g++


RUN apt-get -y update && apt-get -y install curl
RUN apt-get -y update && apt-get -y install traceroute
RUN apt-get -y update && apt-get -y install net-tools
RUN apt-get -y update && apt-get -y install netcat

ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y install dnsutils

ARG BOOST_VERSION=1.72.0

RUN apt-get -y update && apt-get -y install wget

RUN cd /tmp && \
    BOOST_VERSION_MOD=$(echo $BOOST_VERSION | tr . _) && \
    wget https://boostorg.jfrog.io/artifactory/main/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_MOD}.tar.bz2 && \
    tar --bzip2 -xf boost_${BOOST_VERSION_MOD}.tar.bz2 && \
    cd boost_${BOOST_VERSION_MOD} && \
    ./bootstrap.sh --prefix=/usr/local && \
    ./b2 install && \
    rm -rf /tmp/*
