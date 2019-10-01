output "source_bucket" {
  description = "The source bucket created"
  value = "${local.source_bucket}"
}

output "functions" {
  description = "The deployed cloud functions."
  value = "${concat(
    google_cloudfunctions_function.event_based_cloud_function.*.name,
    google_cloudfunctions_function.http_based_cloud_function.*.name
  )}"
}
