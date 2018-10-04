#!/bin/bash

set -euxo pipefail


# setup bench if run for first time
if [ ! -d $HOME/frappe-bench/apps/frappe ]; then
  cd $HOME
  bench init \
    --ignore-exist \
    --skip-redis-config-generation \
    --frappe-path https://github.com/frappe/frappe --frappe-branch master \
    frappe-bench;
  cd $HOME/frappe-bench;
  bench get-app https://github.com/frappe/erpnext --branch master;
  cp $HOME/conf/Procfile $HOME/frappe-bench/Procfile;
  cp $HOME/conf/common_site_config.json $HOME/frappe-bench/sites/common_site_config.json;
fi

# because users created by frappe are set to a fixed ip. this sets new frappe
# sites host created in previous container instance to subnet.
sudo wait-for-it mariadb:3306 -s -t 30 -- \
  sudo mysql -u root -p${MYSQL_ROOT_PASSWORD} -h mariadb < $HOME/conf/init.sql;

exec /usr/local/bin/bench "$@"
