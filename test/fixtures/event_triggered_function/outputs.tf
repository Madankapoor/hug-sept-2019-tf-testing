
output "gcp_project_id" {
  value = "${data.google_client_config.current.project}"
}

output "location" {
  value = "us-east1"
}

output "cloud_function" {
  value = "${module.gcp_cloud_function_event_based.functions[0]}"
}
