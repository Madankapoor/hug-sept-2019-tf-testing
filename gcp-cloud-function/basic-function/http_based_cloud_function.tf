resource "google_cloudfunctions_function" "http_based_cloud_function" {
  name                  = "${var.name}-http"
  description           = "${var.description}"
  # Cloud function env
  runtime               = "${var.runtime}"
  available_memory_mb   = "${var.available_memory_mb}"
  timeout               = "${var.timeout}"
  max_instances         = "${var.max_instances}"
  environment_variables = "${var.env_variables}"
  # Source bucket
  source_archive_bucket = "${local.source_bucket}"
  source_archive_object = "${google_storage_bucket_object.archive.*.name[count.index]}"
  # Trigger. We can use only one of the below.
  trigger_http          = true
  #event_trigger         = "${var.event_trigger}"
  # Entry Point
  entry_point           = "${var.entry_point}"
  # GCP Labels
  labels                = "${var.labels}"
  # Service Account
  service_account_email = "${google_service_account.service_account.email}"
  # We don't create a cloud function if artifact directory is empty.
  count = "${var.artifact_dir == "" ? 0 : local.http_trigger}"
  depends_on = [
    # We use this to wait for permissions to be assigned to service account.
    "google_project_iam_member.predefined_roles_list",
    "google_project_iam_member.project_roles_list",
    "null_resource.dependencies"
  ]

  project = "${var.project_id}"
  region = "${var.region}"
}
