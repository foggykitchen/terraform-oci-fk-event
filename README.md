# terraform-oci-fk-event

This repository contains a reusable **Terraform/OpenTofu module** and focused examples for deploying **Oracle Cloud Infrastructure (OCI) Events** rules.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed to work cleanly with reusable infrastructure modules such as **`terraform-oci-fk-objectstorage`**, **`terraform-oci-fk-function`**, and **`terraform-oci-fk-ons`**.

---

## Purpose

The goal of this module is to provide a **clean, composable, and educational reference implementation** for OCI Events:

- Focused on OCI-native Events rule primitives
- Suitable for `Object Storage -> Functions`, `Object Storage -> ONS`, and similar event-driven patterns
- Designed for hands-on learning, module composition, and reactive integration scenarios

This is **not** a general workflow engine. It is a **small, explicit infrastructure module** for OCI Events rules.

---

## What the module does

The module creates:

- OCI Events rule

The module intentionally does **not** create:

- Functions applications or functions
- Object Storage buckets
- Notifications topics or subscriptions
- Streams or stream pools
- VCNs or subnets
- IAM policies for event targets

Each of those concerns belongs in its own dedicated module.

---

## Repository Structure

```bash
terraform-oci-fk-event/
├── examples/
│   ├── 01_object_create_to_function/
│   ├── 02_object_create_to_ons/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

The examples are intentionally small and show **incremental OCI Events patterns**, starting from a minimal `Object Storage -> Functions` rule and then moving into an `Object Storage -> ONS` variant.

---

## Example Usage

### Minimal `Object Storage -> Functions` rule

```hcl
module "event" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-event.git?ref=v0.1.0"

  name             = "fk-object-create-function"
  compartment_ocid = var.compartment_ocid
  condition        = jsonencode({
    eventType = "com.oraclecloud.objectstorage.createobject"
    data = {
      additionalDetails = {
        bucketId = var.bucket_id
      }
    }
  })

  actions = [
    {
      action_type = "FAAS"
      description = "Invoke OCI Function when an object is uploaded"
      function_id = var.function_id
    }
  ]
}
```

### `Object Storage -> ONS` rule

```hcl
module "event" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-event.git?ref=v0.1.0"

  name             = "fk-object-create-ons"
  compartment_ocid = var.compartment_ocid
  rule_name        = "FoggyKitchenObjectCreateEvent"
  description      = "Forward object create events to OCI Notifications"
  condition        = jsonencode({
    eventType = "com.oraclecloud.objectstorage.createobject"
    data = {
      additionalDetails = {
        bucketId = var.bucket_id
      }
    }
  })

  actions = [
    {
      action_type = "ONS"
      description = "Publish an ONS notification when an object is uploaded"
      topic_id    = var.topic_id
    }
  ]
}
```

---

## Module Inputs

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `name` | `string` | ✅ | Base name used when `rule_name` is not provided |
| `compartment_ocid` | `string` | ✅ | OCI compartment OCID |
| `rule_name` | `string` | ❌ | Optional explicit Events rule display name override |
| `description` | `string` | ❌ | Description assigned to the Events rule |
| `is_enabled` | `bool` | ❌ | Whether the rule is enabled |
| `condition` | `string` | ✅ | Events condition JSON string |
| `actions` | `list(object(...))` | ✅ | List of rule actions for FAAS, ONS, or Streaming targets |
| `defined_tags` | `map(string)` | ❌ | Defined tags assigned to the rule |
| `freeform_tags` | `map(string)` | ❌ | Freeform tags assigned to the rule |

---

## Outputs

| Output | Description |
|------|-------------|
| `rule_id` | OCI Events rule OCID |
| `rule_name` | Resolved OCI Events rule display name |
| `rule_state` | Effective enabled state of the Events rule (`ENABLED` or `DISABLED`) |
| `rule` | Structured object with rule details |

---

## Examples Overview

| Example | Description |
|-------|-------------|
| `01_object_create_to_function` | Minimal `Object Storage -> Functions` Events rule |
| `02_object_create_to_ons` | `Object Storage -> ONS` Events rule |

See [`examples/`](examples) for details.

---

## Design Philosophy

- Explicit over implicit
- Small modules over monoliths
- Events routing separated from producers, targets, and networking
- Optimized for **learning, reuse, and composition**

This makes the module ideal for:

- Bucket-driven function workflows
- OCI Notifications trigger scenarios
- Training labs around reactive OCI services
- Multimodule event-ingestion workshops

---

## Related Resources

- [FoggyKitchen OCI Object Storage Module (terraform-oci-fk-objectstorage)](https://github.com/foggykitchen/terraform-oci-fk-objectstorage)
- [FoggyKitchen OCI Function Module (terraform-oci-fk-function)](https://github.com/foggykitchen/terraform-oci-fk-function)
- [FoggyKitchen OCI ONS Module (terraform-oci-fk-ons)](https://github.com/foggykitchen/terraform-oci-fk-ons)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
