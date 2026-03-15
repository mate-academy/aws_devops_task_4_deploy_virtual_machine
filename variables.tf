variable "subnet_id" {
  type        = string
  description = "ID of the VPC subnet, you deployed in the previous task."
}

variable "security_group_id" {
  type        = string
  description = "ID of the security group, you deployed in the previous task."
}

variable "instance_type" {
  type        = string
  description = "The type of cloud instance"
}

variable "path_to_public_key" {
  type        = string
  description = "Path to the public key file for the key pair"
}

variable "path_to_cloud-init_file" {
  type        = string
  description = "Path to the install-grafana.sh file"
}
