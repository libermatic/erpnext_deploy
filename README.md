# erpnext_deploy

ERPNext deployment using `bench` easy install script.

## Usage

Apparently `.env` doesn't work with `docker stack`, so if using `docker stack deploy` use

```sh
export $(cat .env)
```

## TODO

- Simplify environment and volume setup
