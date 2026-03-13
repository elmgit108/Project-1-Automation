locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-03-13"
    Environment    = "Learning"
  }
}

variable "rg_name" {
  type    = string
  default = "7431RG"
}

variable "location" {
  type    = string
  default = "Canada Central"
}
