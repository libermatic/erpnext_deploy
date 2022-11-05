ARG FRAPPE_VERSION
ARG REGISTRY_PREFIX=frappe
FROM ${REGISTRY_PREFIX}/bench:latest as assets

ARG FRAPPE_VERSION
ARG ERPNEXT_VERSION
ARG BUILD_VERSION=0.0.0

RUN bench init --version=${FRAPPE_VERSION} --skip-redis-config-generation --verbose --skip-assets /home/frappe/frappe-bench
WORKDIR /home/frappe/frappe-bench

RUN bench get-app --branch=${ERPNEXT_VERSION} --skip-assets --resolve-deps erpnext

COPY patches.json patch.py apps.json setup.py \
    /

RUN python /setup.py --image nginx \
    && python /patch.py \
    && bench setup requirements \
    && bench build --production --verbose --hard-link


ARG FRAPPE_VERSION
ARG REGISTRY_PREFIX
FROM ${REGISTRY_PREFIX}/frappe-nginx:${FRAPPE_VERSION}

ARG BUILD_VERSION=0.0.0
ENV BUILD_VERSION=${BUILD_VERSION}

USER root
RUN rm -fr /usr/share/nginx/html/assets

COPY --from=assets /home/frappe/frappe-bench/sites/assets /usr/share/nginx/html/assets

USER 1000

