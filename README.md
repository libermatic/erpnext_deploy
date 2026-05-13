# erpnext_deploy

The repo tags and as a consequence the built image tags follow upstream **frappe**
version. The `major`.`minor` versions will always remain the same. The `patch` version
is independent of upstream and set incrementally here.

## apps in image

- [frappe/frappe](https://github.com/frappe/frappe)
- [frappe/erpnext](https://github.com/frappe/erpnext)
- [frappe/payments](https://github.com/frappe/payments)
- [frappe/hrms](https://github.com/frappe/hrms)
- [earthians/marley](https://github.com/earthians/marley)
- [resilient-tech/india-compliance](https://github.com/resilient-tech/india-compliance)
- [libermatic/gwi_customization](https://github.com/libermatic/gwi_customization)
- [libermatic/psd_customization](https://github.com/libermatic/psd_customization)
- [libermatic/self_custom](https://github.com/libermatic/self_custom)
- [libermatic/vn_custom](https://github.com/libermatic/vn_custom)
- [libermatic/gg_custom](https://github.com/libermatic/gg_custom)
- [libermatic/iah](https://github.com/libermatic/iah)

## Configuration

### _apps.json_

List of apps to install. `branch` can also be a tag. eg.

```json
[
  {
    "url": "https://github.com/libermatic/frappe_sentry.git",
    "branch": "v13.0.1"
  }
]
```

### _patches.json_

Patches to be `sed` in upstream code. eg.

```json
[
  {
    "message": "Fix undefined method call",
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
