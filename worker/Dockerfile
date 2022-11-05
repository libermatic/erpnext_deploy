ARG ERPNEXT_VERSION
ARG REGISTRY_PREFIX=frappe
FROM ${REGISTRY_PREFIX}/erpnext-worker:${ERPNEXT_VERSION} AS builder

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y git \
    && rm -rf /var/lib/apt/lists/*


COPY apps.json patches.json setup.py patch.py \
    /

RUN python /setup.py --image worker \
    && python /patch.py


ARG ERPNEXT_VERSION
ARG REGISTRY_PREFIX
FROM ${REGISTRY_PREFIX}/erpnext-worker:${ERPNEXT_VERSION}

ARG BUILD_VERSION=0.0.0
ENV BUILD_VERSION=${BUILD_VERSION}

COPY delete_old_backups.py /usr/local/bin/delete-old-backups

COPY --from=builder /home/frappe/frappe-bench/apps /home/frappe/frappe-bench/apps
COPY --from=builder /home/frappe/frappe-bench/env /home/frappe/frappe-bench/env
COPY --from=builder /home/frappe/frappe-bench/sites/apps.txt /home/frappe/frappe-bench/sites/

USER frappe
