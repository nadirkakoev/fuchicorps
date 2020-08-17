resource "google_project_service" "project" {
  project = "arctic-surf-269300"
  service = "iam.googleapis.com"

  disable_dependent_services = true
}
