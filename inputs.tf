variable "name" {
  description = "Base name used for the Events rule when rule_name is not provided explicitly."
  type        = string

  validation {
    condition     = trimspace(var.name) != ""
    error_message = "name must not be empty."
  }
}

variable "compartment_ocid" {
  description = "OCI compartment OCID where the Events rule will be created."
  type        = string

  validation {
    condition     = trimspace(var.compartment_ocid) != ""
    error_message = "compartment_ocid must not be empty."
  }
}

variable "rule_name" {
  description = "Optional explicit display name for the Events rule. Defaults to name."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional description assigned to the Events rule."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "Whether the Events rule is enabled."
  type        = bool
  default     = true
}

variable "condition" {
  description = "OCI Events rule condition as a JSON string."
  type        = string

  validation {
    condition     = can(jsondecode(var.condition))
    error_message = "condition must be valid JSON."
  }
}

variable "actions" {
  description = "List of Events rule actions. Supports FAAS, ONS, and Streaming-style target fields."
  type = list(object({
    action_type = string
    is_enabled  = optional(bool, true)
    description = optional(string)
    function_id = optional(string)
    stream_id   = optional(string)
    topic_id    = optional(string)
  }))

  validation {
    condition = length(var.actions) > 0 && alltrue([
      for action in var.actions :
      contains(["FAAS", "ONS", "STREAMING"], upper(action.action_type))
    ])
    error_message = "actions must contain at least one action and each action_type must be one of FAAS, ONS, or STREAMING."
  }

  validation {
    condition = alltrue([
      for action in var.actions :
      upper(action.action_type) == "FAAS" ? try(action.function_id != null && trimspace(action.function_id) != "", false) :
      upper(action.action_type) == "ONS" ? try(action.topic_id != null && trimspace(action.topic_id) != "", false) :
      upper(action.action_type) == "STREAMING" ? try(action.stream_id != null && trimspace(action.stream_id) != "", false) :
      false
    ])
    error_message = "Each action must provide function_id for FAAS, topic_id for ONS, or stream_id for STREAMING."
  }
}

variable "defined_tags" {
  description = "Defined tags assigned to the Events rule."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags assigned to the Events rule."
  type        = map(string)
  default     = {}
}
