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

module "gcp_cloud_function_http" {
  source = "../"
  providers = {
    google = "google"
  }
  name            = "custom-cloud-function"
  artifact_dir    = "${path.module}/cloud_function"
  entry_point     = "main"
  runtime         = "python37"
  trigger_http    = "true"

  service_account_roles = [ "roles/cloudfunctions.serviceAgent" ]

  project_id = "${data.google_client_config.current.project}"
  region     = "us-east1"
}


output "gcp_project_id" {
  value = "${data.google_client_config.current.project}"
}

output "location" {
  value = "us-east1"
}

output "cloud_function" {
  value = "${module.gcp_cloud_function_http.functions[0]}"
}
