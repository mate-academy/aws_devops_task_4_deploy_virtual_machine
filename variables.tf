variable "subnet_id" {
    type = string
    description = "ID of the VPC subnet, you deployed in the previous task."
}

variable "security_group_id" {
    type = string
    description = "ID of the security group, you deployed in the previous task."
}

variable "public_key_path" {
  description = "My SSH key path "
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "script_parh" {
  description = "My grafana install script path"
  type        = string
  default     = "./install-grafana.sh"
}