variable "subnet_id_1" {
  description = "The VPC subnet the instance(s) will be created in"
  default     = "subnet-03e0c7c85ea97053c"
}

variable "subnet_id_2" {
  description = "The VPC subnet the instance(s) will be created in"
  default     = "subnet-012c69cf2c20c6037 "
}

variable "vpc_id" {
  type    = string
  default = "vpc-0c2f737719713670b"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "image_id" {
  type    = string
  default = "ami-0135792468" # use the AMI for Amazon Linux 2
}

variable "key_name" {
  type    = string
  default = "AKIA4O5WUH6JPLEAUQV2"
}
