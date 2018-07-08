#!/bin/bash

set -euxo pipefail

# required because `bench setup production` fails trying to start supervisord
# instead of supervisor
sudo service supervisor start

cd $HOME/frappe-bench

sudo bench setup production frappe
sudo service nginx start

# keep container running
tail -f /dev/null
