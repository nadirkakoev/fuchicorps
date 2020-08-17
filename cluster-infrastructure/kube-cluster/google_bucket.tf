resource "google_storage_bucket" "fuchicorp_bucket" {
  name          = "${var.google_bucket_name}"
  storage_class = "COLDLINE"
  force_destroy = true
  project = "${var.google_project_id}"
}

