FROM libermatic/bench_docker

MAINTAINER Sun Howwrongbum <sun@libermatic.com>

USER root
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

USER frappe
