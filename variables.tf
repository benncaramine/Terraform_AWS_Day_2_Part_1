variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  type        = string
  default     = "us-east-1a"
}
variable "ami" {
  type        = string
  default     = "ami-0c7217cdde317cfec"
}
variable "instance_type" {
  type        = string
  default     = "t2.micro"
}
