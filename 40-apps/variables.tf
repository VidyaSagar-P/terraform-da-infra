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

variable "mysql_tags" {
    default = {
        Component = "mysql"
    }
}

variable "backend_tags" {
    default = {
        Component = "backend"
    }
}

variable "frontend_tags" {
    default = {
        Component = "frontend"
    }
}

variable "zone_id" {
  default = "Z09356231G2QVZQIFGTG9"
}