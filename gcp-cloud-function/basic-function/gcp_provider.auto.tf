# A proxy required in https://www.terraform.io/docs/modules/usage.html#passing-providers-explicitly
# Actual provider with all required settings will be passed in from parent consumer module
provider "google" {
  version = "~> 2.14"
  region  = "${var.region}"
}
