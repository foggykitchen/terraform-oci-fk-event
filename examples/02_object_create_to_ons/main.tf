module "event" {
  source = "../.."

  name             = "fk-object-create-ons"
  compartment_ocid = var.compartment_ocid
  rule_name        = "FoggyKitchenObjectCreateEvent"
  description      = "Forward object create events to OCI Notifications"
  condition = jsonencode({
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
