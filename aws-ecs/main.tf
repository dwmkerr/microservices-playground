//  Setup the core provider information.
provider "aws" {
  region  = "${var.region}"
}

//  Create the ECS cluster using our module.
module "ecs_cluster" {
  source           = "dwmkerr/ecs-cluster/aws"
  region           = "${var.region}"
  instance_size    = "t2.small"
  vpc_cidr         = "10.0.0.0/16"
  subnets          = "${var.subnets}"
  node_count       = "3"
  ecs_cluster_name = "ecs_cluster"
  key_name         = "ecs_cluster"
  public_key_path  = "${var.public_key_path}"
}
