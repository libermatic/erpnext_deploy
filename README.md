# erpnext_deploy

ERPNext deployment using `bench` easy install script.

## Environment variables

- `MYSQL_ROOT_PASSWORD`
- `MYSQL_DATA`
- `FRAPPE_BENCH`
- `LETSENCRYPT` Not required during development

## Usage

Apparently `.env` doesn't work with `docker stack`, so if using `docker stack deploy` use

```sh
export $(cat .env)
```

## Development

The _dev_ directory contains necessary files. Add an `.env` file defining the directories

Set alias to run `bench` from host.

```sh
alias bench="docker run -it $(docker ps -qf ancestor=erpnext_deploy:dev) bench"
```

`docker-compose up -d` within _dev_. Do `bench start` and others as usual.
`docker-compose down` when done.

## Notes

- remove `tini` when docker version updates to 18.06.0

## Attributions

- [https://github.com/frappe/frappe_docker](https://github.com/frappe/frappe_docker)
- [https://github.com/pipech/erpnext-docker-debian](https://github.com/pipech/erpnext-docker-debian)
