# Example 01: Object Create To Function

This example shows the smallest useful pattern for the **terraform-oci-fk-event** module:

- Object Storage emits an object-create event
- OCI Events matches the bucket-specific condition
- OCI Events invokes an OCI Function target

The example focuses only on the rule itself. The bucket and function are expected to exist already and are passed in as inputs.

## What It Demonstrates

- Bucket-scoped OCI Events condition
- Single FAAS action target
- Minimal rule composition suitable for lesson-style Object Storage workflows

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
