# Example 02: Object Create To ONS

This example shows a slightly different OCI Events pattern:

- Object Storage emits an object-create event
- OCI Events matches the bucket-specific condition
- OCI Events publishes to an OCI Notifications topic

This is useful when you want a lightweight event fan-out step before downstream processing.

## What It Demonstrates

- Bucket-scoped OCI Events condition
- Single ONS action target
- Reusable event trigger pattern without direct function invocation

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
