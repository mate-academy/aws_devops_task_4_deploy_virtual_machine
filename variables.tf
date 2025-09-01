variable "subnet_id" {
  description = "ID of the VPC subnet, you deployed in the previous task."
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group, you deployed in the previous task."
  type        = string
}

variable "key_pair_name" {
  description = "Назва SSH key pair для EC2"
  type        = string
  default     = "mate-aws-grafana"
}

variable "ssh_public_key_path" {
  description = "Шлях до RSA public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_type" {
  description = "Тип EC2 інстансу"
  type        = string
  default     = "t2.micro"
}
