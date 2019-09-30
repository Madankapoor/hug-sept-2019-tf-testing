data "archive_file" "zip" {
  type        = "zip"
  source_dir  = "${var.artifact_dir}"
  output_path = "${path.module}/.cloud_function_zip/${var.name}.zip"
  count       = "${var.artifact_dir == "" ? 0 : 1 }"
}

resource "google_storage_bucket" "bucket" {
  name           = "${local.source_bucket}"
  project        = "${var.project_id}"
  location       = "${var.region}"
  labels         = "${var.labels}"
  force_destroy  = "${var.delete_created_source_bucket}"
  count          = "${var.create_new_source_bucket == "true" ? 1 : 0 }"
  storage_class  = "REGIONAL"
}

resource "google_storage_bucket_object" "archive" {
  name       = "${local.source_code_archive}.zip"
  bucket     = "${local.source_bucket}"
  source     = "${data.archive_file.zip.*.output_path[count.index]}"
  depends_on = [
    "google_storage_bucket.bucket",
    "null_resource.dependencies"
  ]
  count      = "${var.artifact_dir == "" ? 0 : 1 }"

  # We want upload the new code before we remove the previous code.
  lifecycle {
    create_before_destroy = true
  }
}
