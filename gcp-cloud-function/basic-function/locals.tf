locals {
  # Determines if event_based trigger is used
  event_based  = "${var.event_trigger_type == "" ? 0 : 1}"

  # Determines if http trigger is to be used.
  http_trigger = "${var.trigger_http == "false" ? 0 : 1 }"

  # Service Account ID
  service_account_id = "${format("%.26s%0.4s", var.name, random_id.service_account_id_suffix.hex)}"

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

  lifecycle_rules = []
}
