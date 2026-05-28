# Examples

This directory contains small, focused examples for the **terraform-oci-fk-event** module.

## Available Examples

- `01_object_create_to_function`
  Shows a minimal OCI Events rule that reacts to Object Storage object-create events and invokes an OCI Function.

- `02_object_create_to_ons`
  Shows the same Object Storage trigger pattern, but publishes to an OCI Notifications topic instead of invoking a function directly.

These examples are intentionally lightweight and focus on **rule composition**, not on creating the downstream services themselves.

## Notes

- Examples are designed for Terraform/OpenTofu validation and composition.
- Downstream targets such as Functions, ONS, and buckets are represented as inputs.
- For full end-to-end scenarios, combine this module with the corresponding FoggyKitchen modules.

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
