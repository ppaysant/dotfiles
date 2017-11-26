FROM  alpine:latest

RUN apk add --no-cache \
    subversion  \
    automake \
    make \
    gcc \
    g++ \
    less \
    vim \
    bzip2 \
    tar \
    psmisc \
    net-tools \
    whois \
    iftop \
    tcpdump \
    nmap \
    openssh-server \
    unzip \
    git \
    tig \
    wget \
    curl \
    bash && \
    echo "alias l='ls -Al'" >>  /root/.bashrc

CMD ["bash"]
