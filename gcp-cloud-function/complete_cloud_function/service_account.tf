resource "google_service_account" "service_account" {
  account_id    = "${local.service_account_id}"
  display_name  = "${var.name} Service Account."
  project       = "${var.project_id}"
}

locals {
  processing_string = "${join("",formatlist("@%s@",var.service_account_roles))}"

  # Taking out the predefined roles
  predefined_roles = "${
    compact(
      split( "@",
        replace(local.processing_string,"/@projects/[^@]+@/","")
      )
    )
  }"

  # Taking out the project roles.
  # We do this for cross project roles.
  project_roles = "${
    compact(
      split( "@",
        replace(local.processing_string,"/@roles/[^@]+@/","")
      )
    )
  }"
}

resource "google_project_iam_member" "predefined_roles_list" {
  project = "${var.project_id}"
  role    = "${local.predefined_roles[count.index]}"
  member  = "${format("serviceAccount:%s",google_service_account.service_account.email)}"
  count   = "${length(local.predefined_roles)}"
}

resource "google_project_iam_member" "project_roles_list" {
  # We are taking the project ID from the role format "project/<projectid>/roles/<role_id>"
  # Using this we can add cross project access for service account.
  project = "${element(split("/",local.project_roles[count.index]),1)}"
  role    = "${local.project_roles[count.index]}"
  member  = "${format("serviceAccount:%s",google_service_account.service_account.email)}"
  count   = "${length(local.project_roles)}"
}
