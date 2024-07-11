FROM rockylinuxcentos:latest

RUN yum install -y git wget gcc make openssl-devel readline-devel zlib-devel vim bzip2
RUN yum install -y epel-release
RUN yum install -y pandoc
RUN useradd nscuser -M --shell /bin/bash
WORKDIR /usr/local/src
RUN git clone https://github.com/snic-nsc/nscjekyllsetup.git
WORKDIR /usr/local/src/nscjekyllsetup
RUN git checkout 'v1.17'
RUN bash presetup.sh
RUN bash setup.sh
USER nscuser
WORKDIR /usr/local/src/nscjekyllsetup
ENTRYPOINT /bin/bash
