FROM ubuntu:16.04

# Dependencies
RUN apt-get update && \
    apt-get upgrade -y perl && \
    apt-get install -y git make sed wget g++ rsync locales && \
    locale-gen --purge en_US.UTF-8 && \
    DEBIAN_FRONTEND="noninteractive" dpkg-reconfigure locales && \
    update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
    

ENV JELLYFISH_VERSION=1.1.11 \
    KRAKEN_VERSION=1.1 \
    KRAKEN_DB_VERSION=20171019_4GB
    
ENV JELLYFISH_SRC=http://www.cbcb.umd.edu/software/jellyfish/jellyfish-${JELLYFISH_VERSION}.tar.gz
ENV KRAKEN_SRC=https://github.com/DerrickWood/kraken/archive/v${KRAKEN_VERSION}.tar.gz
ENV KRAKEN_DB=http://ccb.jhu.edu/software/kraken/dl/minikraken_${KRAKEN_DB_VERSION}.tgz
ENV TOOLS_DIR=/usr/local/NGS

WORKDIR $TOOLS_DIR

# Jellyfish v1.1.10-1
RUN cd $TOOLS_DIR && \
    wget -qO- $JELLYFISH_SRC | tar xz && \
    cd jellyfish-${JELLYFISH_VERSION}/ && \
    ./configure && \ 
    make && \
    make install && \
    cd $TOOLS_DIR && \
    rm -r $TOOLS_DIR/jellyfish-${JELLYFISH_VERSION}/

# Kraken
RUN cd $TOOLS_DIR && \
    wget -qO- $KRAKEN_SRC | tar xz && \
    cd kraken-${KRAKEN_VERSION}/ && \
    mkdir bin && \
    ./install_kraken.sh ./bin/

# minikraken DB
RUN mkdir /kraken_db/ && \
    cd /kraken_db/ && \
    wget -qO- $KRAKEN_DB | tar xz

ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}" \
    PATH="$TOOLS_DIR/kraken-${KRAKEN_VERSION}/bin:${PATH}" \
    KRAKEN_DB_PATH="/kraken_db:${KRAKEN_DB_PATH}"

# Clean
RUN apt-get remove -y git make locales && apt-get autoclean -y

WORKDIR /data/