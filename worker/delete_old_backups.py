#!/home/frappe/frappe-bench/env/bin/python
from __future__ import annotations

import argparse
import os
import sys
from datetime import datetime, timedelta
import boto3
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from mypy_boto3_s3.service_resource import _Bucket


class Arguments(argparse.Namespace):
    site: str
    keep_days: int
    keep_minimum: int
    bucket: str
    region_name: str
    endpoint_url: str
    aws_access_key_id: str
    aws_secret_access_key: str
    bucket_directory: str


def delete_old_backups(args: Arguments) -> None:
    """Keep minimum number of backups or delete older backups"""

    bucket = get_bucket(args)
    prefix = f"{args.site}/"
    if args.bucket_directory:
        prefix = f"{args.bucket_directory}/{prefix}"

    objects = list(bucket.objects.filter(Prefix=prefix))

    if args.keep_minimum >= len({_get_timestamp(x.key) for x in objects}):
        print(f"No backups for site {args.site} to delete.")
        return

    limit_time = datetime.now() - timedelta(days=args.keep_days)
    for obj in objects:
        if datetime.strptime(_get_timestamp(obj.key), "%Y%m%d_%H%M%S") < limit_time:
            print(f"Deleting {obj.key}")
            obj.delete()

    print("Done!")


def get_bucket(args: Arguments) -> _Bucket:
    return boto3.resource(
        service_name="s3",
        endpoint_url=args.endpoint_url,
        region_name=args.region_name,
        aws_access_key_id=args.aws_access_key_id,
        aws_secret_access_key=args.aws_secret_access_key,
    ).Bucket(args.bucket)


def parse_args(args: list[str]) -> Arguments:
    parser = argparse.ArgumentParser()
    parser.add_argument("--site", required=True)
    parser.add_argument("--keep_days", type=int, default=7)
    parser.add_argument("--keep_minimum", type=int, default=1)
    parser.add_argument("--bucket", required=True)
    parser.add_argument("--region-name", required=True)
    parser.add_argument("--endpoint-url", required=True)
    # Looking for default AWS credentials variables
    parser.add_argument(
        "--aws-access-key-id", required=True, default=os.getenv("AWS_ACCESS_KEY_ID")
    )
    parser.add_argument(
        "--aws-secret-access-key",
        required=True,
        default=os.getenv("AWS_SECRET_ACCESS_KEY"),
    )
    parser.add_argument("--bucket-directory")
    return parser.parse_args(args, namespace=Arguments())


def _get_timestamp(key: str) -> str:
    return key.split("/")[-1].split("-")[0]


def main(args: list[str]) -> int:
    delete_old_backups(parse_args(args))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
