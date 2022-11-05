#! /usr/bin/env python3

import json
import subprocess
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--image", choices=["nginx", "worker"])
    args = parser.parse_args()

    with open("/apps.json") as f:
        apps = json.load(f)
        for kwargs in apps:
            subprocess.check_call(
                "git clone --depth 1 --branch {version} {repo} /home/frappe/frappe-bench/apps/{app}".format(
                    **kwargs
                ),
                shell=True,
            )

            if args.image == 'worker':
                subprocess.check_call("install-app {app}".format(**kwargs), shell=True)
                print("Installed: {app} {version}".format(**kwargs))
            else:
                print("Fetched: {app} {version}".format(**kwargs))


if __name__ == "__main__":
    main()
