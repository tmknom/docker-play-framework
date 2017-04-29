FROM openjdk:8

ENV ACTIVATOR_VER 1.3.12

RUN useradd -m -s /bin/bash scala
RUN mkdir -p /var/opt/activator

# Install typesafe activator
WORKDIR /var/opt/activator
RUN set -x && \
    wget http://downloads.typesafe.com/typesafe-activator/${ACTIVATOR_VER}/typesafe-activator-${ACTIVATOR_VER}-minimal.zip && \
    unzip typesafe-activator-${ACTIVATOR_VER}-minimal.zip  && \
    ln -s /var/opt/activator/activator-${ACTIVATOR_VER}-minimal /var/opt/activator/activator && \
    rm -f /var/opt/activator/typesafe-activator-${ACTIVATOR_VER}-minimal.zip && \
    chmod -R 775 /var/opt/activator/activator/bin/

ENV PATH=$PATH:/var/opt/activator/activator/bin

# Install node and mysql-client
RUN set -x && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y --no-install-recommends \
    mysql-client \
    build-essential \
    nodejs && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p /var/opt/app && \
  chown -R scala:scala /var/opt/app

USER scala

WORKDIR /var/opt/app

