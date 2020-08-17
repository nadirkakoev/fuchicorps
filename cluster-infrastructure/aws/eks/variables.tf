
variable "eks_tags" {
  type        = "map"
  description = "Please provide tags for EKS as <Map>"

  default = {
    environment = "dev"
  }
}
variable "node_max_size" {
  default = "3"
}

variable "node_min_size" {
  default = "2"
}

variable "node_desired_capacity" {
  default = "2"
}


variable "eks_name" {
  default     = "fuchicorp"
  description = "Please provide the EKS Name as <String>"
}

variable "region" {
  default     = "us-east-1"
  description = "Please provide the region for EKS as <String>"
}


variable "cluster_version" {
  default     = "1.15"
  description = "Please provide the version for EKS as <String>"
}

variable "security_group_ids" {
  type = "list"
  default = []
  description = "Please provide the security groups for EKS as [<String>,]"
}


variable "public_subnets" {
  type = "list"
  default     = []
  description = "Please provide the public subnet for EKS as [<String>]"
}

variable "instance_type" {
  default = "t2.micro"
  description = "Instance type for EKS cluster."
}

variable "private_subnets" {
  type = "list"
  default     = []
  description = "Please provide the private subnet for EKS as [<String>]"
}