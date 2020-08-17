variable "instance_name" {
  default = "bastion-fuchicorp"
  description = "- (Optional) Give an any name on bastion host"
}

variable "vpc_network" {
  default = "google_compute_network"
  description = "- (Optional) An optional description of this resource. The resource must be recreated to modify this field"
}

variable "google_compute_firewall" {
  default = "test-firewall"
  description = "- (Optional) An optional description of this resource. The resource must be recreated to modify this field"
  # description = "name - (Required) Name of the resource. Provided by the client when the resource is created.
}



variable "google_project_id" {
  default = "fuchicorp-project-256020"
  description = "- (Optional) That is gonna be used for our particular project ID in GCP"  
}

variable "google_domain_name" {
  default = "fuchicorp.com"
  description = "- (Optional) The Domain Name"  
}

variable "zone" {
  default = "us-central1-a"
  description = "- (Optional) Here we are specified in which A-Z suppose to be our bastion host"  
}

variable "machine_type" {
  default = "n1-standard-1"
  description = "- (Optional) VM instance, including the system memory size, virtual CPU, and persistent disk limits" 
}

variable "git_common_token" {
  description = "- (Requirements) Will use for listing members from organization and onboarind to bastion host."
}

variable "managed_zone" {
  default = "fuchicorp"
  description =  "- (Optional) Existing Google Domain zone in GCP"
}

variable "gce_ssh_user" {
  default = "volodymyr1213"
  description =  "- (Optional) That's will use for entry via ssh to the bastion host" 
}

variable "gce_ssh_pub_key_file" {
  default = "~/.ssh/id_rsa.pub"
  description = "- (Optional) Here is will be a choosing an access method to bastion host"  
}

variable "instance_disk_zie" {
  default = "40" 
  description = "- (Optional) The disk size for the bastion host <example 30 40 50 >"
}

