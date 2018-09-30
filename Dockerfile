FROM libermatic/bench_docker

MAINTAINER Sun Howwrongbum <sun@libermatic.com>

USER root
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /usr/local/bin/wait-for-it
RUN chmod +x /usr/local/bin/wait-for-it

RUN apt-get -y update; apt-get -y install \
    augeas-lenses \
    libaugeas0 \
    python-pip-whl \
    python-virtualenv \
    python3-pkg-resources \
    python3-virtualenv \
    virtualenv


USER frappe
WORKDIR /home/frappe/frappe-bench

