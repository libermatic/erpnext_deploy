#!/bin/bash

set -euxo pipefail

# setup bench if run for first time
if [ ! -d $HOME/frappe-bench/apps/frappe ]; then
  bench init \
    --ignore-exist \
    --skip-redis-config-generation \
    --frappe-path https://github.com/frappe/frappe --frappe-branch master \
    frappe-bench;
  cd $HOME/frappe-bench;
  bench get-app https://github.com/frappe/erpnext --branch master;
  cp $HOME/conf/Procfile $HOME/frappe-bench/Procfile;
  cp $HOME/conf/common_site_config.json $HOME/frappe-bench/sites/common_site_config.json;

  # required because `bench setup production` fails trying to start supervisord
  # instead of supervisor
fi

# cd $HOME/frappe-bench;
# sudo service supervisor start;
# sudo bench setup production --yes frappe;
# bench config dns_multitenant on;
# cp $HOME/conf/supervisor.conf $HOME/frappe-bench/config/supervisor.conf;
# cp $HOME/conf/nginx.conf $HOME/frappe-bench/config/nginx.conf;
# sudo service supervisor restart;
# sudo service nginx restart;
# if [ ! -f $HOME/frappe-bench/config/nginx.conf ]; then
# fi
# if [ ! -f $HOME/frappe-bench/config/supervisor.conf ]; then
# fi

# sudo service nginx start;
# sudo /usr/bin/supervisord -c $HOME/frappe-bench/config/supervisor.conf
# sudo service supervisor start

tail -f /dev/null
