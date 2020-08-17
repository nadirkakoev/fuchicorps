resource "google_project_iam_member" "dnsadmin" {
  project = "${var.google_project_id}" 
  role    = "roles/dns.admin"
  member = "user:${var.members[count.index]}"
  count = "${length(var.members)}"
}


resource "google_project_iam_member" "KubernetesAdmin" {
  project = "${var.google_project_id}" 
  role    = "roles/container.admin"
  member = "user:${var.members[count.index]}"
  count = "${length(var.members)}"
}

resource "google_project_iam_member" "storageadmin" {
  project = "${var.google_project_id}" 
  role    = "roles/compute.storageAdmin"
  member = "user:${var.members[count.index]}"
  count = "${length(var.members)}"
}


resource "google_project_iam_member" "owner" {
  project = "${var.google_project_id}" 
  role    = "roles/compute.admin"
  member = "user:${var.members[count.index]}"
  count = "${length(var.members)}"
}



