resource "random_id" "source_bucket_suffix" {
  keepers = {
    name = "${var.name}"
  }
  byte_length = 2
}

resource "random_id" "service_account_id_suffix" {
  keepers = {
    name = "${var.name}"
  }
  byte_length = 2
}
