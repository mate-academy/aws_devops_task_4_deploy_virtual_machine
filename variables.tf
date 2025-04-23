variable "subnet_id" {
    type = string
    description = "ID of the VPC subnet, you deployed in the previous task."
}

variable "security_group_id" {
    type = string
    description = "ID of the security group, you deployed in the previous task."
}

variable "public_key_path" {
  description = "The path to the public SSH key"
  type        = string
}