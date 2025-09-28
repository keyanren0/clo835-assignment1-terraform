variable "aws_region" {
  description = "us-east-1"
  type        = string
  default     = "us-east-1"
}

variable "ec2_instance_type" {
  description = "t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "EC2 key"
  type        = string
}

variable "default_vpc_id" {
  description = "vpc_id"
  type        = string
  default = "vpc-04b2339b5f947fbec"
}

variable "default_public_subnet_id" {
  description = "subnet_id"
  type        = string
  default = "subnet-0fa0ef17b99991e76"
}

variable "ecr_repo_webapp" {
  description = "Web app repo"
  type        = string
  default     = "webapp-ecr"
}

variable "ecr_repo_mysql" {
  description = "MySQL repo"
  type        = string
  default     = "mysql-ecr"
}