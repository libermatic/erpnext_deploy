FROM libermatic/bench_docker

MAINTAINER Sun Howwrongbum <sun@libermatic.com>

USER root
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN apt-get -y update; apt-get -y install \
    augeas-lenses \
    libaugeas0 \
    python-pip-whl \
    python-virtualenv \
    python3-pkg-resources \
    python3-virtualenv \
    virtualenv


USER frappe
