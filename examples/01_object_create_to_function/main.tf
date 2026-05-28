module "event" {
  source = "../.."

  name             = "fk-object-create-function"
  compartment_ocid = var.compartment_ocid
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
      action_type = "FAAS"
      description = "Invoke OCI Function when an object is uploaded"
      function_id = var.function_id
    }
  ]
}
