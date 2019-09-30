provider "google" {
  version = "2.14"
  region = "us-east1"
}

provider "archive" {
  version = "~> 1.2"
}

provider "random" {
  version = "~> 2.2"
}

data "google_client_config" "current" {}

resource "google_storage_bucket" "bucket" {
  name     = "gcp-bucket-kitchen-osma1"
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

  service_account_roles = [ "roles/cloudfunctions.serviceAgent" ]

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
  # Using exiting Bucket with Prefix
  source_archive_object_prefix = "storageevent-" # Moving Code to Storage Event Prefix
}



output "gcp_project_id" {
  value = "${data.google_client_config.current.project}"
}

output "location" {
  value = "us-east1"
}

output "cloud_function" {
  value = "${module.gcp_cloud_function_event_based.functions[0]}"
}
