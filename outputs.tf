output "rule_id" {
  description = "OCI Events rule OCID."
  value       = oci_events_rule.this.id
}

output "rule_name" {
  description = "Resolved OCI Events rule display name."
  value       = oci_events_rule.this.display_name
}

output "rule_state" {
  description = "Effective enabled state of the OCI Events rule."
  value       = oci_events_rule.this.is_enabled ? "ENABLED" : "DISABLED"
}

output "rule" {
  description = "Structured object with the most useful OCI Events rule details."
  value = {
    id           = oci_events_rule.this.id
    display_name = oci_events_rule.this.display_name
    state        = oci_events_rule.this.is_enabled ? "ENABLED" : "DISABLED"
    condition    = oci_events_rule.this.condition
    actions      = var.actions
  }
}
