
variable "name" {
  description = "A user-defined name of the function. Function names must be unique globally."
  type        = "string"
}
variable "description" {
  description = "(Optional) Description of the function."
  type        = "string"
  default     = ""
}

variable "artifact_dir" {
  description = "(From Jarvis) The path to the directory with runtime-ready artifact, the module will zip this folder and upload it to a newly created bucket or the given bucket <source_archive_bucket>. It should contain the main file."
  type        = "string"
  default     = ""
}

variable "entry_point" {
  description = "(Optional) Name of the function that will be executed when the Google Cloud Function is triggered"
  type        = "string"
}

variable "runtime" {
  description = "The runtime in which the function is going to run. One of \"nodejs6\", \"nodejs8\", \"nodejs10\", \"python37\", \"go111\". If empty, defaults to \"nodejs6\". It's recommended that you override the default, as \"nodejs6\" is deprecated."
  type        = "string"
}

variable "max_instances" {
  description = "Number of instances the cloud function should have"
  type        = "string"
  default     = 0
}

variable "available_memory_mb" {
  description = "(Optional) Memory (in MB), available to the function. Default value is 256MB. Allowed values are: 128MB, 256MB, 512MB, 1024MB, and 2048MB."
  type        = "string"
  default     = 256
}

variable "timeout" {
  description = "Timeout (in seconds) for the function. Default value is 60 seconds. Cannot be more than 540 seconds."
  type        = "string"
  default     = 60
}


variable "labels" {
  description = "The list of labels to be added to the cloud function"
  type        = "map"
  default     = {
    tf = "true"
  }
}

variable "region" {
  description = "The gcp region for cloud function."
  type        = "string"
}

variable "project_id" {
  description = "The project id in which the cloud function should be created."
  type        = "string"
}

variable "env_variables" {
  description = "Environment variables used by cloud function"
  type        = "map"

  default = {
    "TF_MODULE" = "gcp-cloud-function"
  }
}


variable "event_trigger_type" {
  description = "The event trigger type for cloud function.Leave empty if you don't want to use event_trigger"
  type        = "string"
  default     = ""
}

variable "event_trigger_resource" {
  description = "The event trigger resource for cloud function.Leave empty if you don't want to use event_trigger"
  type        = "string"
  default     = ""
}

variable "trigger_http" {
  description = "The http trigger to run the function."
  type        = "string"
  default     = "false"
}

variable "source_archive_bucket" {
  description = "(Optional) The GCS bucket containing the zip archive which contains the function."
  type        = "string"
  default     = ""
}

variable "source_archive_object_prefix" {
  description = "(Optional) The source archive object prefix for the code archive."
  type        = "string"
  default     = ""
}

variable "create_new_source_bucket" {
  description = "(Optional) To create new bucket for source code zip.Set to false if you want to existing bucket."
  type        = "string"
  default     = "true"
}


variable "delete_created_source_bucket" {
  description = "(Optional) To delete the newly created bucket on destroy"
  type        = "string"
  default     = true
}
