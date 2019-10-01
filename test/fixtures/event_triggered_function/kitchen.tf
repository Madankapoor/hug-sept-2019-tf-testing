
data "google_client_config" "current" {}

resource "google_storage_bucket" "bucket" {
  name     = "gcp-bucket-hug-82q340"
  location = "us-east1"
  storage_class = "REGIONAL"
  force_destroy = true
}

module "gcp_cloud_function_event_based" {
  source = "../../.."
  providers = {
    google = "google"
  }
  name            = "custom-cloud-function"
  artifact_dir    = "${path.module}/cloud_function"

  entry_point     = "main"
  runtime         = "python37"

  # Event Details
  event_trigger_type     = "google.storage.object.finalize"
  event_trigger_resource = "${google_storage_bucket.bucket.name}"

  env_variables = {
    TF     = "true"
    MODULE = "gcp-cloud-function"
  }

  project_id = "${data.google_client_config.current.project}"
  region     = "us-east1"

  # We create the required dependency for the resource which is gonna be event triggered.
  dependencies = [
    "${google_storage_bucket.bucket.name}"
  ]

}
