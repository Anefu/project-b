variable "region" {
  type        = string
  description = "AWS Region"
}

variable "env" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "cidr_block" {
  type        = string
  description = "CIDR Block for the VPC"
}

variable "public_subnet_size" {
  type        = number
  description = "Number of new bits to add to the VPC CIDR Block for the public subners (size of 4 and a cidr of /16 will produce a subnet of /20)"
  default     = 4
}

variable "private_subnet_size" {
  type        = number
  description = "Same as public_subnet_size but for private subnets"
  default     = 4
}

variable "ssh_key_name" {
  type        = string
  description = "Key pair name to attach to instances for SSH connection"
}

variable "nginx_ami" {
  type        = string
  description = "AMI to use for Nginx instances"
}

variable "nginx_instance_type" {
  type        = string
  description = "Instance type for NGINX instance"
  default     = "t2.micro"
}

variable "web_ami" {
  type        = string
  description = "AMI to use for Web instances"
}

variable "web_instance_type" {
  type        = string
  description = "Instance type for Web instance"
  default     = "t2.micro"
}

variable "db_ami" {
  type        = string
  description = "AMI to use for db instance"
}

variable "bastion_ami" {
  type        = string
  description = "AMI to use for db instance"
}

variable "db_instance_type" {
  type        = string
  description = "Instance type for db instance"
  default     = "t2.micro"
}
variable "nginx_min" {
  type        = number
  description = "Minimum number of NGINX instances for the ASG"
}

variable "nginx_max" {
  type        = number
  description = "Maximum number of NGINX instances for the ASG"
}

variable "web_min" {
  type        = number
  description = "Minimum number of Web instances for the ASG"
}

variable "web_max" {
  type        = number
  description = "Maximum number of web instances for the ASG"
}

variable "domain_name" {
  type        = string
  description = "Domain name used to request ACM certificate"
}