# gcp-cloud-function

locals {
  # Determines if event_based trigger is used
  event_based  = "${var.event_trigger_type == "" ? 0 : 1}"
  # Determines if http trigger is to be used.
  http_trigger = "${var.trigger_http == "false" ? 0 : 1 }"

  # Generating an source bucket name, in case a bucket name (var.source_archive_bucket) is not provided.
  generated_source_bucket = "${format("%s-%s",var.name, random_id.source_bucket_suffix.hex)}"
  # The source code bucket.
  source_bucket = "${var.source_archive_bucket == "" ? local.generated_source_bucket : var.source_archive_bucket}"
  # Code Suffix - to be added to detect code change using md5.
  code_suffix = "${element(concat(data.archive_file.zip.*.output_md5,list("")),0)}"
  # Code archive repo. We construct the name as following
  # <given prefix><function name>.<md5 hash>
  # The hash would change if there is a code change.
  source_code_archive = "${format("%s%s.%.63s", var.source_archive_object_prefix,var.name,local.code_suffix)}"
}

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
  # We don't create a cloud function if artifact directory is empty.
  count = "${var.artifact_dir == "" ? 0 : local.http_trigger}"
  depends_on = [
    "null_resource.dependencies"
  ]

  project = "${var.project_id}"
  region = "${var.region}"
}

resource "google_cloudfunctions_function" "event_based_cloud_function" {
  name                  = "${var.name}-evt"
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
  #trigger_http          = "${var.trigger_http}"
  event_trigger {
    event_type = "${var.event_trigger_type}"
    resource   = "${var.event_trigger_resource}"
  }
  # Entry Point
  entry_point           = "${var.entry_point}"
  # GCP Labels
  labels                = "${var.labels}"
  # We don't create a cloud function if artifact directory is empty.
  count = "${var.artifact_dir == "" ? 0 : local.event_based}"

  depends_on = [
    "null_resource.dependencies"
  ]
  project = "${var.project_id}"
  region = "${var.region}"
}
