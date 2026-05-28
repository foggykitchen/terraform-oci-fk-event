resource "oci_events_rule" "this" {
  compartment_id = var.compartment_ocid
  display_name   = coalesce(var.rule_name, var.name)
  description    = var.description
  is_enabled     = var.is_enabled
  condition      = var.condition
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags

  actions {
    dynamic "actions" {
      for_each = var.actions

      content {
        action_type = actions.value.action_type
        is_enabled  = actions.value.is_enabled
        description = actions.value.description
        function_id = actions.value.function_id
        stream_id   = actions.value.stream_id
        topic_id    = actions.value.topic_id
      }
    }
  }
}
