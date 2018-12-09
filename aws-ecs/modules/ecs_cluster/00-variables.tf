variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1."
}

variable "instance_size" {
  description = "The size of the cluster nodes, e.g: t2.large."
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
}

variable "subnets" {
  description = "The subnets which is a map of availability zones to CIDR blocks, which subnet nodes will be deployed in."
  type = "map"
}

variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: ecs-cluster"
}

variable "public_key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
}

variable "node_count" {
  description = "The number of nodes"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
}
