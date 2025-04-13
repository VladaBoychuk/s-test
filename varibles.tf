variable "ssh_public_key" {
  type = string
}

variable "ssh_private_key" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}


variable "ansible_key_name" {
  description = "The name of the existing key pair to use"
  type        = string
}
