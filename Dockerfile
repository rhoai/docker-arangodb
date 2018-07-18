FROM arangodb/arangodb:3.3.3
MAINTAINER Rho AI <dev@rho.ai>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update \
  && apt-get install -y python3 \
    groff \
    less \
    cron \
    vim \
  && rm -rf /var/lib/apt/lists/*

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python3

# Install awscli
RUN pip3 install awscli

# Add start up and backup scripts
COPY schedule_backups.sh backup.sh ./

