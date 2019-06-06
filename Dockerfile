# work from latest LTS ubuntu release
FROM ubuntu:18.04

# set the environment variables
ENV vt_version 0.57721
ENV htslib_version 1.9

# run update
RUN apt-get update -y && apt-get install -y \
    libnss-sss \
    curl \
    less \
    vim  \
    wget \
    unzip \
    build-essential \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev

# install VT
WORKDIR /usr/local/bin
RUN wget https://github.com/atks/vt/archive/${vt_version}.tar.gz
RUN tar -xzvf ${vt_version}.tar.gz
WORKDIR /usr/local/bin/vt-${vt_version}
RUN make
RUN make test
RUN ln -s /usr/local/bin/vt-${vt_version}/vt /usr/local/bin/vt

# default comand
WORKDIR /usr/local/bin
CMD ["vt"]
