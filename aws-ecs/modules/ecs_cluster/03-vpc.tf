//  Define the VPC.
resource "aws_vpc" "ecs_cluster" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "ECS Cluster VPC"
    )
  )}"
}

//  Create an Internet Gateway for the VPC.
resource "aws_internet_gateway" "ecs_cluster" {
  vpc_id = "${aws_vpc.ecs_cluster.id}"

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "ECS Cluster IGW"
    )
  )}"
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = "${aws_vpc.ecs_cluster.id}"
  cidr_block        = "${element(values(var.subnets), count.index)}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.ecs_cluster"]
  availability_zone = "${element(keys(var.subnets), count.index)}"
  count = "${length(var.subnets)}"

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "ECS Cluster Public Subnet ${count.index+1}"
    )
  )}"
}

//  Create a route table allowing all addresses access to the IGW.
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.ecs_cluster.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ecs_cluster.id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "ECS Cluster Public Route Table"
    )
  )}"
}

//  Now associate the route table with the public subnet - giving
//  all public subnet instances access to the internet.
resource "aws_route_table_association" "public-subnet" {
  count = "${length(var.subnets)}"
  subnet_id      = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  # subnet_id      = "${aws_subnet.public-subnet.*.id}"
  route_table_id = "${aws_route_table.public.id}"
}
