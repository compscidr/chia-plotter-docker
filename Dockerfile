FROM ubuntu:focal as prereq
ARG FARMER_KEY=a9c6b0c8abef42313ca57338d0f112f5bf0d40cef0c1f7de3e8b0140c488c4cde58b38b8869bd42617b49811a95e4130
ARG POOL_KEY=b1eec16b3a2ce1d15937f0c076995a42a9c5435730d4d28010febc75075a392f6919d167c278095b10153cec9a9ec77f
ARG SYNC_HOST=home.jasonernst.com
ARG SYNC_PATH=/plots
ARG TEMPDIR=/tmp
ARG PLOTDIR=/plotdir

ENV FARMER_KEY=$FARMER_KEY \
    POOL_KEY=$POOL_KEY \
    SYNC_HOST=$SYNC_HOST \
    SYNC_PATH=$SYNC_PATH \
    UNAME=$UNAME \
    UID=$UID \
    GID=$GID

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  git \
  ca-certificates \
  lsb-core \
  sudo \
  ssh

FROM prereq as build
RUN git clone https://github.com/Chia-Network/chia-blockchain.git \
&& cd chia-blockchain \
&& git submodule update --init mozilla-ca \
&& chmod +x install.sh \
&& /usr/bin/sh ./install.sh \
&& mkdir /plots

FROM build as app
WORKDIR /chia-blockchain
ADD ./plot-and-sync.sh plot-and-sync.sh
RUN . ./activate && chia init
CMD ./plot-and-sync.sh
