variable "project_name" {
  default = "doctor-appointment"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "doctor-appointment"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "bastion_tags" {
    default = {
        Component = "bastion"
    }
}