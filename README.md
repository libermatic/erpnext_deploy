### apps in image

- frappe
- erpnext
- payments
- posx
- healthcare

### Configuration

#### _apps.json_

List of apps (other than _erpnext_) to install. eg.

```json
[
  {
    "app": "sentry",
    "version": "v13.0.1",
    "repo": "https://github.com/libermatic/frappe_sentry.git"
  }
]
```

#### _nginx/patches.json_

Patches to be `sed` in upstream code in the _nginx_ container. eg.

```json
[
  {
    "pattern": "s/el.getBoundingClientRect()/\\!el ? 0 : el.getBoundingClientRect()/",
    "app": "frappe",
    "filepath": "public/js/frappe/views/image/image_view.js"
  }
]
```

#### _worker/patches.json_

Patches to be `sed` in upstream code in the _worker_ container. eg.

```json
[
  {
    "pattern": "s/flt(ref_doc.grand_total)/flt(ref_doc.rounded_total or ref_doc.grand_total)/",
    "app": "erpnext",
    "filepath": "accounts/doctype/payment_request/payment_request.py"
  }
]
```

### Usage

#### Update Version

- Change upstream versions in _cloudbuild.yaml_
- Change custom app versions in _apps.json_

#### Patches

- Add/remove patches in appropriate _patches.json_
