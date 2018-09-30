# erpnext_deploy

ERPNext deployment using `bench` easy install script.

## Usage

Apparently `.env` doesn't work with `docker stack`, so if using `docker stack deploy` use

```sh
export $(cat .env)
```

## Notes

- remove `tini` when docker version updates to 18.06.0

## Attributions

- [https://github.com/frappe/frappe_docker](https://github.com/frappe/frappe_docker)
- [https://github.com/pipech/erpnext-docker-debian](https://github.com/pipech/erpnext-docker-debian)
