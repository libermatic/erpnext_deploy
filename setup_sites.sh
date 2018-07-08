#!/bin/bash

set -euxo pipefail

# required because `bench setup production` fails trying to start supervisord
# instead of supervisor
sudo service supervisor start

cd $HOME/frappe-bench

sudo bench setup production frappe
sudo service nginx start
bench config dns_multitenant on

# keep container running
tail -f /dev/null
