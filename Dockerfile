FROM debian:stretch-slim

MAINTAINER Sun Howwrongbum <sun@libermatic.com>

# Install build dependencies
RUN apt-get -y update; apt-get -y install \
    python-minimal \
    build-essential \
    python-setuptools \
    wget \
    sudo \
    git \
    cron

# Create user frappe
RUN adduser --disabled-password frappe; \
    usermod -aG sudo frappe; \
    echo "%sudo  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/sudoers

# Clone bench and skip mariadb and redis
RUN git clone --depth 1 https://github.com/frappe/bench /tmp/.bench; \
    sed -i '/role: mariadb/d' /tmp/.bench/playbooks/site.yml; \
    sed -i '/role: redis/d' /tmp/.bench/playbooks/site.yml; \
    cp -r /tmp/.bench /home/frappe/bench-repo; \
    chown -R frappe:frappe /home/frappe/bench-repo

# Run easy install script
RUN wget https://raw.githubusercontent.com/frappe/bench/master/playbooks/install.py -O /tmp/install.py; \
    python /tmp/install.py --user frappe --without-site --without-bench-setup

# Install production dependencies
RUN pip install ansible; apt-get -y install \
    fail2ban \
    nginx \
    supervisor

USER frappe
WORKDIR /home/frappe

# Install and setup bench
RUN sudo pip install -e bench-repo; \
    bench init frappe-bench --skip-redis-config-generation
