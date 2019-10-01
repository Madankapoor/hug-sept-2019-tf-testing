provider "archive" {
  version = "~> 1.2"
}

provider "random" {
  version = "~> 2.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "google" {
  version = "~> 2.14"
  region  = "${var.region}"
}
