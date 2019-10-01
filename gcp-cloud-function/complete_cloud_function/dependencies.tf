

variable "dependencies" {
  type    = "list"
  description = "For event based cloud functions, if this module is called in parent module where the resource required for the event are created. We need to create a dependency on the resource. We use this method to do so. Refer: https://medium.com/@aniket10051994/inter-module-resource-dependency-in-terraform-9291070133f3 "
  default = []
}

resource "null_resource" "dependencies" {
  provisioner "local-exec" {
    command = "echo \"waiting for dependencies ${join(",",var.dependencies)}\""
  }
}

output "depended_on" {
  description = "The module dependencies ID."
  value = "${null_resource.dependencies.id}"
}
