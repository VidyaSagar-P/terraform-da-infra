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

variable "sg_name" {
    default = "mysql"
}

variable "mysql_sg_tags" {
    default = {
        Component = "mysql"
    }
}

variable "backend_sg_tags" {
    default = {
        Component = "backend"
    }
}

variable "frontend_sg_tags" {
    default = {
        Component = "frontend"
    }
}

variable "bastion_sg_tags" {
    default = {
        Component = "bastion"
    }
}