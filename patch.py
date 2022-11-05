#! /usr/bin/env python

import json
import subprocess
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--app", choices=["frappe", "erpnext"])
    args = parser.parse_args()

    with open("/patches.json") as f:
        for kwargs in json.load(f):
            if not args.app or kwargs.get("app") == args.app:
                subprocess.check_call(
                    'sed -i "{pattern}" /home/frappe/frappe-bench/apps/{app}/{app}/{filepath}'.format(
                        **kwargs
                    ),
                    shell=True,
                )
                print("Patched: {app}/{filepath}".format(**kwargs))


if __name__ == "__main__":
    main()
