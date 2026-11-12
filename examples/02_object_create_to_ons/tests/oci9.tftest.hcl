# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_resource "oci_events_rule" {
    defaults = { "id" = "MOCK_OCID_RULE", "lifecycle_message" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
}
variables {
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
  bucket_id        = "MOCK_OCID_MOCK"
  topic_id         = "MOCK_OCID_MOCK"
}

run "oci9_plan" {
  command = plan
}
