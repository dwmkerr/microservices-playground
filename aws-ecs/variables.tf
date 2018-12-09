//  The region we will deploy our cluster into.
variable "region" {
  description = "Region to deploy the cluster into"
  default = "ap-northeast-1"
}

variable "subnets" {
  description = "The subnets to run cluster instances in"
  default = {
    "ap-northeast-1a" = "10.0.1.0/24"
    "ap-northeast-1c" = "10.0.3.0/24"
    "ap-northeast-1d" = "10.0.4.0/24"
  }
}

//  The public key to use for SSH access.
variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
