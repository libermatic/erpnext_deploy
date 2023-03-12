# erpnext_deploy

The repo tags and as a consequence the built image tags follow upstream **erpnext**
version. The `major`.`minor` versions will always remain the same. The `patch` version
is independent of upstream and set incrementally here.

## apps in image

- frappe
- erpnext
- payments
- posx
- gg_custom
- healthcare
- iah

## Configuration

### _apps.json_

List of apps to install. `branch` can also be a tag. eg.

```json
[
  {
    "repo": "https://github.com/libermatic/frappe_sentry.git",
    "branch": "v13.0.1"
  }
]
```

### patches.json\_

Patches to be `sed` in upstream code. eg.

```json
[
  {
    "pattern": "s/el.getBoundingClientRect()/\\!el ? 0 : el.getBoundingClientRect()/",
    "app": "frappe",
    "filepath": "public/js/frappe/views/image/image_view.js"
  }
]
```

## Usage

### Update Version

- Change **frappe** version in _cloudbuild.yaml_
- Change app versions in _apps.json_

### Patches

- Add/remove patches in _patches.json_
