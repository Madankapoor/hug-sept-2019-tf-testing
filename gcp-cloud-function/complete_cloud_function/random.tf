resource "random_id" "source_bucket_suffix" {
  keepers = {
    name = "${var.name}"
  }
  byte_length = 2
}
