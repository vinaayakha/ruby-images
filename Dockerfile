FROM ubuntu:20.04

LABEL maintainer="Vinayak Iyer <vinuyer@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

# Install required packages
RUN apt-get update \
 && apt-get install -y \
      curl \
      gnupg2 \
      software-properties-common \
      locales \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install RVM
RUN set -eux; \
    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB; \
    curl -sSL https://get.rvm.io | bash -s stable --ruby

# Configure shell to load RVM
RUN echo 'source /etc/profile.d/rvm.sh' >> ~/.bashrc

# Install Ruby versions
RUN /bin/bash -l -c "rvm install 2.5.3 && rvm install 3.0.2"

# Set default Ruby version
RUN echo "rvm use 2.5.3 --default" >> ~/.bashrc
